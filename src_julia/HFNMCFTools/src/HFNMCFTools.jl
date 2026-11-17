# Copyright (c) 2022-2026 Engineering Systems Analytics LLC
# @author: Amro M. Farid
# @version: 4.6.10
# @Modified: 04/02/2026

# Julia Version 1.12.3
# Commit 966d0af0fdf (2025-12-15 11:20 UTC)
# Build Info:
#   Official https://julialang.org release
# Platform Info:
#   OS: macOS (x86_64-apple-darwin24.0.0)
#   CPU: 10 × Apple M1 Max
#   WORD_SIZE: 64
#   LLVM: libLLVM-18.1.7 (ORCJIT, westmere)
#   GC: Built with stock GC
# Threads: 1 default, 1 interactive, 1 GC (on 10 virtual cores)
# Environment:
#   JULIA_EDITOR = code
#   JULIA_VSCODE_REPL = 1

module HFNMCFTools

using PrettyPrint
using JSON3
using JuMP, HiGHS
using SparseArrays, CSV, DataFrames
using PrecompileTools: @setup_workload, @compile_workload         # This is a small dependency

# Load optional commercial solvers if available.
# Install in your global Julia environment: julia -e 'using Pkg; Pkg.add("CPLEX")'
for pkg in ["CPLEX", "Gurobi"]
    try; @eval using $(Symbol(pkg)); catch; end
end

const ZERO_TOL = 1e-5
############ Function Library #####################################################################################
mutable struct MutableStruct
    fields::Dict{Symbol,Any}
    MutableStruct() = new(Dict{Symbol,Any}())
end
function Base.getproperty(m::MutableStruct, f::Symbol)
    if f === :fields
        return getfield(m, :fields)
    elseif haskey(m.fields, f)
        return m.fields[f]
    else
        return getfield(m, f)
    end
end
function Base.setproperty!(m::MutableStruct, f::Symbol, v)
    if f === :fields
        setfield!(m, :fields, v)
    else
        m.fields[f] = v
    end
end

function parseJSON3(x::JSON3.Object)
    obj = MutableStruct()
    for (k,v) in pairs(x)
        setproperty!(obj, Symbol(k), parseJSON3(v))
    end
    return obj
end
function parseJSON3(x::JSON3.Array)
    return [parseJSON3(v) for v in x]
end
parseJSON3(x) = x
function createJSON3(x)
    if x isa MutableStruct
        return Dict(String(k) => createJSON3(v) for (k, v) in x.fields)
    elseif x isa AbstractVector
        return [createJSON3(v) for v in x]
    else
        # numbers, strings, bools, nothing
        return x
    end
end
function setVariableDomain!(x,varDomain,varName)
    idxLBinary  = occursin.("binary",  varDomain)
    idxLInteger = occursin.("integer", varDomain)
    idxLReal    = occursin.("real", varDomain)
    idxLPos     = occursin.("+", varDomain)
    temp = idxLBinary .| idxLInteger .| idxLReal
    try
        if !all(temp)
            temp = findall(.!temp)
            throw(ArgumentError("Fail! Decision variable must be binary, integer, or real! Inspect indices: $temp in $varName"))
        end
    catch e
        println("$e.  Abort! Abort!")
        return false
    end
    if ndims(x) == 1
        set_binary.(x[idxLBinary])
        set_integer.(x[idxLInteger])
        set_lower_bound.(x[idxLPos], 0)
    elseif ndims(x) == 2
        set_binary.(x[idxLBinary, :])
        set_integer.(x[idxLInteger, :])
        set_lower_bound.(x[idxLPos,:], 0)
    end
    return true
end
function mutableStruct2SparseMat(sparseMatDict)
    if isa(sparseMatDict, MutableStruct)
        tempData    = convert.(Float64,sparseMatDict.data)
        # tempCoords1 = convert.(Int64,sparseMatDict.coords[1]) .+ 1
        tempCoords1 = convert.(Int64, [row[1] for row in sparseMatDict.coords]) .+ 1
        # tempCoords2 = convert.(Int64,sparseMatDict.coords[2]) .+ 1
        tempCoords2 = convert.(Int64, [row[2] for row in sparseMatDict.coords]) .+ 1
        tempShape   = convert.(Int64,sparseMatDict.shape)
        A = sparse(tempCoords1, tempCoords2, tempData, tempShape[1], tempShape[2])
    else
        A = sparseMatDict
    end
    return A
end

function sparseMat2MutableStruct(A)
    if isa(A,SparseMatrixCSC)
        # Zero out near-zeros in-place
        A.nzval .= cleanZeros(A.nzval)
        # Remove stored zeros from the sparse structure
        dropzeros!(A)

        ms = MutableStruct()
        idxRows, idxCols, vals = findnz(A)
        # convert to 0-based indexing to match your format
        # ms.coords     = [idxRows .- 1, idxCols .- 1]
        ms.coords     = [[r, c] for (r, c) in zip(idxRows .- 1, idxCols .- 1)]
        ms.data       = vals
        idxSorted     = sortperm(ms.coords)
        ms.coords     = ms.coords[idxSorted]
        ms.data       = ms.data[idxSorted]
        ms.shape      = [size(A, 1), size(A, 2)]
        ms.sparseType = "coo_array"
        ms.myClass    = "SparseMAT"
    else
        ms = A
    end
    return ms
end
function convertVecOfVec2Matrix(myMatrix)
    A = vcat(myMatrix'...)
    return A
end
function convertMatrix2VecOfVec(A)
    return [collect(row) for row in eachrow(A)]
end
convertMatrix2VecOfVec(A::AbstractMatrix) = [collect(row) for row in eachrow(A)]
function cleanZeros(mat::AbstractArray)
    return map(x -> isZero(x) ? 0.0 : x, mat)
end
isZero(::Nothing) = true
isZero(x::Number) = iszero(x) || abs(x) < ZERO_TOL
isZero(x) = false
isEmpty(::Nothing) = true
isEmpty(x) = isempty(x)

const _OPTIMIZER_REGISTRY = Dict{String, Any}()
# An internal helper function to return the optimizer based on the
# Registry populated by optional solver extensions (GurobiExt, CPLEXExt) via
# their __init__() functions. Extensions cannot overwrite methods with the same
# signature during precompilation, so a registry/lookup pattern is used instead.
function get_optimizer(optimizer_name::String)
    opt_lower = lowercase(optimizer_name)

    if opt_lower == "highs"
        return HiGHS.Optimizer
    elseif haskey(_OPTIMIZER_REGISTRY, opt_lower)
        return _OPTIMIZER_REGISTRY[opt_lower]
    else
        error("Optimizer '$(optimizer_name)' is not loaded. Add it to your project with Pkg.add(\"$(optimizer_name)\") and then restart Julia.")
    end
end
function teeprintln(file::IO, args...)
    println(stdout, args...)
    println(file, args...)
    flush(file)
end
function addFreightFatigueRules!(HFNMCF, myLFES, ULneg, l)
    # This function has been derived from https://www.nhvr.gov.au/safety-accreditation-compliance/fatigue-management/work-and-rest-requirements
    idx = findfirst(==("discharge state-of-charge"), myLFES.operand.pnTransitions[l].name)
    if myLFES.simHorizon >= 1+22
        # The 5.25 Hour out of 5.5 Hour Fatigue Rule 
        for k in 1:myLFES.simHorizon-1-22
            kStart = 1  + k
            kEnd   = 22 + k 
            @constraint(HFNMCF, sum(ULneg[l][idx,kStart:kEnd]) .<= 21, base_name = "OperandNet$(l)_Fatigue_5.25Hrs")
        end
    end
    if myLFES.simHorizon >= 1+32
        # The 7.5 Hour out of 8.0 Hour Fatigue Rule 
        for k in 1:myLFES.simHorizon-1-32
            kStart = 1  + k
            kEnd   = 32 + k 
            @constraint(HFNMCF, sum(ULneg[l][idx,kStart:kEnd]) .<= 30, base_name = "OperandNet$(l)_Fatigue_8.0Hrs")
        end
    end
    if myLFES.simHorizon >= 1+44
        # The 10.0 Hour out of 11.0 Hour Fatigue Rule 
        for k in 1:myLFES.simHorizon-1-44
            kStart = 1  + k
            kEnd   = 44 + k 
            @constraint(HFNMCF, sum(ULneg[l][idx,kStart:kEnd]) .<= 40, base_name = "OperandNet$(l)_Fatigue_11.0Hrs")
        end
    end
    if myLFES.simHorizon >= 1+96
        # The 12.0 Hour out of 24.0 Hour Fatigue Rule 
        for k in 1:myLFES.simHorizon-1-96
            kStart = 1  + k
            kEnd   = 96 + k 
            @constraint(HFNMCF, sum(ULneg[l][idx,kStart:kEnd]) .<= 48, base_name = "OperandNet$(l)_Fatigue_24.0Hrs")
        end
    end 
    if myLFES.simHorizon >= 1+672
        # The 72.0 Hour out of 7 Day Fatigue Rule 
        for k in 1:myLFES.simHorizon-1-672
            kStart = 1   + k
            kEnd   = 672 + k 
            @constraint(HFNMCF, sum(ULneg[l][idx,kStart:kEnd]) .<= 288, base_name = "OperandNet$(l)_Fatigue_7Day")
        end
    end 
    if myLFES.simHorizon >= 1+1344
        # The 144.0 Hour out of 14 Day Fatigue Rule 
        for k in 1:myLFES.simHorizon-1-1344
            kStart = 1    + k
            kEnd   = 1344 + k 
            @constraint(HFNMCF, sum(ULneg[l][idx,kStart:kEnd]) .<= 576, base_name = "OperandNet$(l)_Fatigue_14Day")
        end
    end 
end
############ End of Function Library ###############################################################################

############ Primary JuMP Functions ################################################################################

function loadHFNMCFData(inputFilePath)
    println("JSON Optimization Model Data:  Loading")
    # Reformatting variables
    myLFES = parseJSON3(JSON3.read(inputFilePath))
    println("JSON Optimization Model Data:  Loaded")
    myLFES.engSysNet.Mneg = mutableStruct2SparseMat(myLFES.engSysNet.Mneg)
    myLFES.engSysNet.Mpos = mutableStruct2SparseMat(myLFES.engSysNet.Mpos)
    myLFES.operand.Mneg = [mutableStruct2SparseMat(myLFES.operand.Mneg[l]) for l in 1:myLFES.operand.number]
    myLFES.operand.Mpos = [mutableStruct2SparseMat(myLFES.operand.Mpos[l]) for l in 1:myLFES.operand.number]
    myLFES.operand.syncMat = [mutableStruct2SparseMat(myLFES.operand.syncMat[l]) for l in 1:myLFES.operand.number]
    
    if myLFES.hasBufferUpperBound
        myLFES.engSysNet.pnPlaces.upperBound = convertVecOfVec2Matrix(myLFES.engSysNet.pnPlaces.upperBound)
    end
    if myLFES.hasBufferLinearCost
        myLFES.engSysNet.pnPlaces.linearCostCoeff = convertVecOfVec2Matrix(myLFES.engSysNet.pnPlaces.linearCostCoeff)
    end
    if myLFES.hasBufferQuadCost
        myLFES.engSysNet.pnPlaces.quadCostCoeff = convertVecOfVec2Matrix(myLFES.engSysNet.pnPlaces.quadCostCoeff)
    end
    if myLFES.hasProcessLinearCostFlowNeg
        myLFES.engSysNet.pnTransitions.linearCostCoeffFlowNeg = convertVecOfVec2Matrix(myLFES.engSysNet.pnTransitions.linearCostCoeffFlowNeg)
    end
    if myLFES.hasProcessLinearCostFlowPos
        myLFES.engSysNet.pnTransitions.linearCostCoeffFlowPos = convertVecOfVec2Matrix(myLFES.engSysNet.pnTransitions.linearCostCoeffFlowPos)
    end
    if myLFES.hasProcessLinearCostStock
        myLFES.engSysNet.pnTransitions.linearCostCoeffStock  = convertVecOfVec2Matrix(myLFES.engSysNet.pnTransitions.linearCostCoeffStock)
    end
    if myLFES.hasProcessQuadCostFlowNeg
        myLFES.engSysNet.pnTransitions.quadCostCoeffFlowNeg = convertVecOfVec2Matrix(myLFES.engSysNet.pnTransitions.quadCostCoeffFlowNeg)
    end
    if myLFES.hasProcessQuadCostFlowPos
        myLFES.engSysNet.pnTransitions.quadCostCoeffFlowPos = convertVecOfVec2Matrix(myLFES.engSysNet.pnTransitions.quadCostCoeffFlowPos)
    end
    if myLFES.hasProcessQuadCostStock
        myLFES.engSysNet.pnTransitions.quadCostCoeffStock  = convertVecOfVec2Matrix(myLFES.engSysNet.pnTransitions.quadCostCoeffStock)
    end
    for l in 1:myLFES.operand.number
        if myLFES.operand.hasPlaceLinearCost[l]
            myLFES.operand.pnPlaces[l].linearCostCoeff = convertVecOfVec2Matrix(myLFES.operand.pnPlaces[l].linearCostCoeff)
        end
        if myLFES.operand.hasPlaceQuadCost[l]
            myLFES.operand.pnPlaces[l].quadCostCoeff = convertVecOfVec2Matrix(myLFES.operand.pnPlaces[l].quadCostCoeff)
        end
        if myLFES.operand.hasTransitionLinearCostFlowNeg[l]
            myLFES.operand.pnTransitions[l].linearCostCoeffFlowNeg = convertVecOfVec2Matrix(myLFES.operand.pnTransitions[l].linearCostCoeffFlowNeg)
        end
        if myLFES.operand.hasTransitionLinearCostFlowPos[l]
            myLFES.operand.pnTransitions[l].linearCostCoeffFlowPos = convertVecOfVec2Matrix(myLFES.operand.pnTransitions[l].linearCostCoeffFlowPos)
        end
        if myLFES.operand.hasTransitionLinearCostStock[l]
            myLFES.operand.pnTransitions[l].linearCostCoeffStock = convertVecOfVec2Matrix(myLFES.operand.pnTransitions[l].linearCostCoeffStock)
        end

        if myLFES.operand.hasTransitionQuadCostFlowNeg[l]
            myLFES.operand.pnTransitions[l].quadCostCoeffFlowNeg = convertVecOfVec2Matrix(myLFES.operand.pnTransitions[l].quadCostCoeffFlowNeg)
        end
        if myLFES.operand.hasTransitionQuadCostFlowPos[l]
            myLFES.operand.pnTransitions[l].quadCostCoeffFlowPos = convertVecOfVec2Matrix(myLFES.operand.pnTransitions[l].quadCostCoeffFlowPos)
        end
        if myLFES.operand.hasTransitionQuadCostStock[l]
            myLFES.operand.pnTransitions[l].quadCostCoeffStock = convertVecOfVec2Matrix(myLFES.operand.pnTransitions[l].quadCostCoeffStock)
        end
    end
    myLFES.operand.XS = Vector{Union{Nothing, MutableStruct,SparseMatrixCSC{Float64,Int64}}}(fill(nothing, myLFES.operand.number))
    myLFES.operand.XF = Vector{Union{Nothing, MutableStruct,SparseMatrixCSC{Float64,Int64}}}(fill(nothing, myLFES.operand.number))
    myLFES.operand.XE = Vector{Union{Nothing, MutableStruct,SparseMatrixCSC{Float64,Int64}}}(fill(nothing, myLFES.operand.number))
    myLFES.operand.Uneg = Vector{Union{Nothing, MutableStruct,SparseMatrixCSC{Float64,Int64}}}(fill(nothing, myLFES.operand.number))
    myLFES.operand.Upos = Vector{Union{Nothing, MutableStruct,SparseMatrixCSC{Float64,Int64}}}(fill(nothing, myLFES.operand.number))
    return myLFES
end
function buildHFNMCFProblem(myLFES)
    println("Building Optimization Model")
    opt = get_optimizer(myLFES.optimizer)
    HFNMCF = Model(opt)

    # # Variable Declaration
    println("\t Declaring Decision Variables")
    if myLFES.hasESN_STF1
        # These are the amounts of operands remaining in each place after any negative firing vector at any momment in time k in the engineering system net places
        @variable(HFNMCF, QF[1:myLFES.buffer.number * myLFES.operand.number, 1:myLFES.simHorizon-1])
        if myLFES.hasESNEnablingConstraint
            # Old Method To Be Deprecated:  This sets all QF variables as positive reals together, but it does not allow for some places to be positive real and some places to be real.  The new method below allows for this flexibility.
            # setVariableDomain!(QF,fill("real+", myLFES.buffer.number * myLFES.operand.number),"myLFES.engSysNet.pnPlaces")
            # New Method To Be Used:  This allows for some places to be positive real and some places to be real.  It is more flexible than the old method, but it is more verbose.
            setVariableDomain!(QF,myLFES.engSysNet.pnPlaces.varDomainEnabled,"myLFES.engSysNet.pnPlaces")
        else
            setVariableDomain!(QF,fill("real", myLFES.buffer.number * myLFES.operand.number),"myLFES.engSysNet.pnPlaces")
        end
        # These are the amounts of operands stored in each place at any momment in time k in the engineering system net places
        @variable(HFNMCF, QB[1:myLFES.buffer.number * myLFES.operand.number, 1:myLFES.simHorizon])
        setVariableDomain!(QB,myLFES.engSysNet.pnPlaces.varDomain,"myLFES.engSysNet.pnPlaces")
    else
        QB = fill(nothing, 1,1)
        QF = fill(nothing, 1,1)
    end
    if myLFES.hasESN_STF2
        # These are the amounts of operands stored in each place at any momment in time k in the engineering system net transitions
        @variable(HFNMCF, QE[1:myLFES.systemConcept.DOFS, 1:myLFES.simHorizon])
        setVariableDomain!(QE,myLFES.engSysNet.pnTransitions.varDomain,"myLFES.engSysNet.pnTransitions")
    else
        QE = fill(nothing,1,1)
    end
    if myLFES.hasESN_STF1 || myLFES.hasESN_STF2 
        # These are the number of times an engineering system net transition is initiated at a moment in time k. 
        @variable(HFNMCF, UEneg[1:myLFES.systemConcept.DOFS, 1:myLFES.simHorizon-1])
        setVariableDomain!(UEneg,myLFES.engSysNet.pnTransitions.varDomain,"myLFES.engSysNet.pnTransitions")
        # These are the number of times an engineering system net transition is terminated at a moment in time k. 
        @variable(HFNMCF, UEpos[1:myLFES.systemConcept.DOFS, 1:myLFES.simHorizon-1])
        setVariableDomain!(UEpos,myLFES.engSysNet.pnTransitions.varDomain,"myLFES.engSysNet.pnTransitions")
    else
        UEneg = fill(nothing,1,1)
        UEpos = fill(nothing,1,1)
    end
    # Pre-allocate arrays to hold JuMP variable matrices
    QFL   = Vector{Any}(nothing, myLFES.operand.number)   # Operand net places
    QSL   = Vector{Any}(nothing, myLFES.operand.number)   # Operand net places
    QEL   = Vector{Any}(nothing, myLFES.operand.number)   # Operand net transitions (amount stored)
    ULneg = Vector{Any}(nothing, myLFES.operand.number)   # Number of times a transition is initiated
    ULpos = Vector{Any}(nothing, myLFES.operand.number)   # Number of times a transition is terminated

    # Loop over operand nets
    for l in 1:myLFES.operand.number
        m, n = myLFES.operand.MFull[l].shape
        operandNetSizes = [Tuple(myLFES.operand.MFull[l].shape) for l in 1:myLFES.operand.number]
        if myLFES.operand.hasOperandNet_STF1[l]
            # These are the amounts of operands remaining in each place after any negative firing vector at any moment in time k in the operand net places
            QFL[l] = @variable(HFNMCF, [1:m, 1:myLFES.simHorizon-1])
            if myLFES.operand.hasOperandNetEnablingConstraint[l]
                setVariableDomain!(QFL[l],fill("real+", m),"myLFES.operand.pnPlaces[$l]")
            else
                setVariableDomain!(QFL[l],fill("real",  m),"myLFES.operand.pnPlaces[$l]")
            end
            # These are the amounts of operands stored in each place at any momment in time k in the operand net places
            QSL[l] = @variable(HFNMCF, [1:m, 1:myLFES.simHorizon])  
            setVariableDomain!(QSL[l],myLFES.operand.pnPlaces[l].varDomain, "myLFES.operand.pnPlaces[$l]")
        end
        if myLFES.operand.hasOperandNet_STF2[l]
            # These are the amounts of operands stored in each place at any momment in time k in the operand net transitions
            QEL[l] = @variable(HFNMCF, [1:n, 1:myLFES.simHorizon])  
            setVariableDomain!(QEL[l],myLFES.operand.pnTransitions[l].varDomain, "myLFES.operand.pnTransitions[$l]")
        end
        if myLFES.operand.hasOperandNet_STF1[l] || myLFES.operand.hasOperandNet_STF2[l]
            # These are the number of times an operand net transition is initiated at a moment in time k. 
            ULneg[l] = @variable(HFNMCF, [1:n, 1:myLFES.simHorizon-1])
            setVariableDomain!(ULneg[l],myLFES.operand.pnTransitions[l].varDomain,"myLFES.operand.pnTransitions[$l]")
            # These are the number of times an operand net transition is terminated at a moment in time k. 
            ULpos[l] = @variable(HFNMCF, [1:n, 1:myLFES.simHorizon-1])
            setVariableDomain!(ULpos[l],myLFES.operand.pnTransitions[l].varDomain,"myLFES.operand.pnTransitions[$l]")
        end
    end
    # # Engineering System Net & Operand Net State Transition Functions
    for k in 1:myLFES.simHorizon-1
        # Engineering System Net State Transition Function
        if myLFES.hasESN_STF1
            println("\t Building Engineering System Net State Transition Function Constraints - QB:  Time Step $k")
            # The engineering system net state transition function ONE is built up one time step at a time to avoid memory limitations. 
            if !myLFES.hasESN_Duration || all(isZero,myLFES.engSysNet.pnTransitions.duration)
                # This condition eliminates the need for the UEpos[:,k] variable
                @constraint(HFNMCF, QF[:,k]   .== QB[:,k] - (myLFES.engSysNet.Mneg) * UEneg[:,k] * myLFES.deltaT, base_name = "ESN_STF1A_$(k)")
                @constraint(HFNMCF, QB[:,k+1] .== QF[:,k] + (myLFES.engSysNet.Mpos) * UEneg[:,k] * myLFES.deltaT, base_name = "ESN_STF1B_$(k)")
                # If there is a problem with the enabling constraint, then for debugging purposes comment out the two lines above, and uncomment out the line below.  
                # @constraint(HFNMCF, QB[:,k+1]   .== QB[:,k] + (myLFES.engSysNet.Mpos - myLFES.engSysNet.Mneg) * UEneg[:,k] * myLFES.deltaT, base_name = "ESN_STF1A_$(k)")
            else
                # This is the default general case for the UEpos[:,k] variable
                @constraint(HFNMCF, QF[:,k]   .== QB[:,k] - (myLFES.engSysNet.Mneg * UEneg[:,k] * myLFES.deltaT), base_name = "ESN_STF1A_$(k)")
                @constraint(HFNMCF, QB[:,k+1] .== QF[:,k] + (myLFES.engSysNet.Mpos * UEpos[:,k] * myLFES.deltaT), base_name = "ESN_STF1B_$(k)")
                # If there is a problem with the enabling constraint, then for debugging purposes comment out the two lines above, and uncomment out the line below.  
                # @constraint(HFNMCF, QB[:,k+1] .== QB[:,k]  + (myLFES.engSysNet.Mpos * UEpos[:,k] * myLFES.deltaT) - (myLFES.engSysNet.Mneg * UEneg[:,k] * myLFES.deltaT), base_name = "ESN_STF1A_$(k)")
            end
        end
        if myLFES.hasESN_STF2
            println("\t Building Engineering System Net State Transition Function Constraints - QE:  Time Step $k")
            #  The engineering system net state transition function TWO is built up one time step at a time to avoid memory limitations. 
            if !myLFES.hasESN_Duration || all(isZero,myLFES.engSysNet.pnTransitions.duration)
                # This condition eliminates the need for the UEpos[:,k] variable 
                # This line needs to be validated!  AMRO!  
                @constraint(HFNMCF, QE[:,k+1] .== QE[:,k] - (UEpos[:,k] + UEneg[:,k]) * myLFES.deltaT, base_name = "ESN_STF2_$(k)")
            else
                # This is the default general case for the UEpos[:,k] variable
                @constraint(HFNMCF, QE[:,k+1] .== QE[:,k] - (UEpos[:,k] * myLFES.deltaT) + (UEneg[:,k] * myLFES.deltaT), base_name = "ESN_STF2_$(k)")
            end
        end
        if myLFES.hasESN_Duration
            println("\t Building Engineering System Net State Transition Function Constraints - Duration:  Time Step $k")
            # The engineering system net state transition function duration constraint is built up one time step and one capability at a time by necessity.
            if !all(isZero,myLFES.engSysNet.pnTransitions.duration)
                # This is the default general case of the UEpos[:,k] variable 
                for psi in 1:myLFES.systemConcept.DOFS
                    if (k + myLFES.engSysNet.pnTransitions.duration[psi]) <= myLFES.simHorizon-1
                        @constraint(HFNMCF, UEpos[psi, (k+myLFES.engSysNet.pnTransitions.duration[psi])] .== UEneg[psi, k], base_name = "ESN_STFDuration_$(k)")
                    end
                    if k <= myLFES.engSysNet.pnTransitions.duration[psi]
                        # This line needs to be validated!  AMRO!  
                        @constraint(HFNMCF, UEpos[psi,k] .== 0, base_name = "ESN_STFDuration_$(k)")
                    end
                end
            else
                # This is the special case of the UEpos[:,k] variable
            end
        end
        # The engineering system net state transition function has an upper bound ramping constraint on the transitions.  
        if myLFES.hasProcessUpperBoundRamp && k<=myLFES.simHorizon-2
            local idx
            idx = .!isEmpty.(myLFES.engSysNet.pnTransitions.upperBoundRamp)
            @constraint(HFNMCF, UEneg[idx,k+1] - UEneg[idx,k] .<= myLFES.engSysNet.pnTransitions.upperBoundRamp[idx], base_name = "ESN_UpperBoundRamp_$(k)")
        end
        # The engineering system net state transition function has a lower bound ramping constraint on the transitions.  
        if myLFES.hasProcessLowerBoundRamp && k<=myLFES.simHorizon-2
            local idx
            idx = .!isEmpty.(myLFES.engSysNet.pnTransitions.lowerBoundRamp)
            @constraint(HFNMCF, UEneg[idx,k+1] - UEneg[idx,k] .>= myLFES.engSysNet.pnTransitions.lowerBoundRamp[idx], base_name = "ESN_LowerBoundRamp_$(k)")
        end
        # Operand Net State Transition Function
        for l in 1: myLFES.operand.number
            if myLFES.operand.hasOperandNet_STF1[l]
                println("\t Building Operand Net Number $l State Transition Function Constraints - QSL:  Time Step $k")
                # The operand net state transition function ONE is built up one time step at a time to avoid memory limitations. 
                if all(isZero,myLFES.operand.pnTransitions[l].duration)
                    # This condition eliminates the need for the ULpos[:,k] variable
                    @constraint(HFNMCF, QFL[l][:,k]   .== QSL[l][:,k] - (myLFES.operand.Mneg[l] * ULneg[l][:,k] * myLFES.deltaT), base_name = "OperandNet$(l)_STF1A_$(k)")
                    @constraint(HFNMCF, QSL[l][:,k+1] .== QFL[l][:,k] + (myLFES.operand.Mpos[l] * ULneg[l][:,k] * myLFES.deltaT), base_name = "OperandNet$(l)_STF1B_$(k)")
                    # If there is a problem with the enabling constraint, then for debugging purposes comment out the two lines above, and uncomment out the line below.  
                    # @constraint(HFNMCF, QSL[l][:,k+1] .== QSL[l][:,k] + (myLFES.operand.Mpos[l] - myLFES.operand.Mneg[l]) * ULneg[l][:,k] * myLFES.deltaT, base_name = "OperandNet$(l)_STF1A_$(k)")
                else
                    # This is the default general case for the ULpos[:,k] variable
                    @constraint(HFNMCF, QFL[l][:,k]   .== QSL[l][:,k] - (myLFES.operand.Mneg[l] * ULneg[l][:,k] * myLFES.deltaT), base_name = "OperandNet$(l)_STF1A_$(k)")
                    @constraint(HFNMCF, QSL[l][:,k+1] .== QFL[l][:,k] + (myLFES.operand.Mpos[l] * ULpos[l][:,k] * myLFES.deltaT), base_name = "OperandNet$(l)_STF1B_$(k)")
                    # If there is a problem with the enabling constraint, then for debugging purposes comment out the two lines above, and uncomment out the line below. 
                    # @constraint(HFNMCF, QSL[l][:,k+1] .== QSL[l][:,k] + (myLFES.operand.Mpos[l] * ULpos[l][:,k] * myLFES.deltaT) - (myLFES.operand.Mneg[l] * ULneg[l][:,k] * myLFES.deltaT), base_name = "OperandNet$(l)_STF1A_$(k)")
                end
            end
            if myLFES.operand.hasOperandNet_STF2[l]
                println("\t Building Operand Net Number $l State Transition Function Constraints - QEL:  Time Step $k")
                # The operand net state transition function TWO is built up one time step at a time to avoid memory limitations. 
                if all(isZero,myLFES.operand.pnTransitions[l].duration)
                    # This condition eliminates the need for the ULpos[:,k] variable
                    # This line needs to be validated!  AMRO!  
                    @constraint(HFNMCF, QEL[l][:,k+1] .== QEL[l][:,k] - (ULpos[l][:,k] + ULneg[l][:,k]) * myLFES.deltaT, base_name = "OperandNet$(l)_STF2_$(k)")  
                else
                    # This is the default general case for the ULpos[:,k] variable
                    @constraint(HFNMCF, QEL[l][:,k+1] .== QEL[l][:,k] - (ULpos[l][:,k] * myLFES.deltaT) + (ULneg[l][:,k] * myLFES.deltaT), base_name = "OperandNet$(l)_STF2_$(k)")
                end
            end
            if myLFES.operand.hasOperandNet_Duration[l]
                println("\t Building Operand Net Number $l State Transition Function Constraints - Duration:  Time Step $k")
                # The operand net state transition function duration constraint is built up one time step and one capability at a time by necessity.
                if !all(isZero, myLFES.operand.pnTransitions[l].duration) 
                    # This is the default general case of the UEpos[:,k] variable
                    for x in 1:myLFES.operand.pnTransitions[l].number
                        if (k + myLFES.operand.pnTransitions[l].duration[x]) <= myLFES.simHorizon-1
                            @constraint(HFNMCF, ULpos[l][x, (k+myLFES.operand.pnTransitions[l].duration[x])] .== ULneg[l][x, k], base_name = "OperandNet$(l)_STFDuration_$(k)")
                        end
                        if k <= myLFES.operand.pnTransitions[l].duration[x]
                            # This line needs to be validated!  AMRO!  
                            @constraint(HFNMCF, ULpos[l][x,k] .== 0, base_name = "OperandNet$(l)_STFDuration_$(k)")
                        end
                    end
                else
                    # This is the special case of the ULpos[:,k] variable
                end
            end
            if myLFES.operand.hasSyncMatNeg[l]
                # idxSyncMatNeg is necessary when not all operand net transitions have their corresponding ESN transitions.
                # This happens when the operand net has intelligence/autonomy.  
                idxSyncMatNeg = vec(sum(myLFES.operand.syncMat[l], dims=2)) .> 0
                @constraint(HFNMCF,ULneg[l][idxSyncMatNeg,k] - myLFES.operand.syncMat[l][idxSyncMatNeg,:] * UEneg[:,k] .== 0, base_name = "OperandNet$(l)_SyncNeg_$(k)")
            end
            if myLFES.operand.hasSyncMatPos[l]
                # idxSyncMatPos is necessary when not all operand net transitions have their corresponding ESN transitions.
                # This happens when the operand net has intelligence/autonomy.  
                idxSyncMatPos = vec(sum(myLFES.operand.syncMat[l], dims=2)) .> 0
                @constraint(HFNMCF,ULpos[l][idxSyncMatPos,k] - myLFES.operand.syncMat[l][idxSyncMatPos,:] * UEpos[:,k] .== 0, base_name = "OperandNet$(l)_SyncPos_$(k)")
            end
        end
    end
    # # Exogenous Value Constraints on Engineering System Net Transitions
    if myLFES.hasProcessValues
        println("\t Building Engineering System Net Transition Exogenous Value Constraints")
        idx = .!isEmpty.(myLFES.engSysNet.pnTransitions.value)
        @constraint(HFNMCF, UEneg[idx, :] .== convertVecOfVec2Matrix(myLFES.engSysNet.pnTransitions.value[idx]), base_name = "ESN_UEValue")
    end
    # # Initial Condition Constraints on Engineering System Net Places
    if myLFES.hasBufferInitCond
        println("\t Building Engineering System Net Place Initial Conditions")
        @constraint(HFNMCF, QB[:, 1] .== myLFES.engSysNet.pnPlaces.initCond, base_name = "ESN_QBInitCond")
    end
    # # Initial Condition Constraints on Engineering System Net Transitions
    if myLFES.hasProcessInitCond && myLFES.hasESN_Duration
        println("\t Building Engineering System Net Transition Initial Conditions")
        @constraint(HFNMCF, QE[:, 1] .== myLFES.engSysNet.pnTransitions.initCond, base_name = "ESN_QEInitCond")
    end
    # # Final Condition Constraints on Engineering System Net Places
    if myLFES.hasBufferFinalCond
        println("\t Building Engineering System Net Transition Final Conditions")
        @constraint(HFNMCF, QB[:, myLFES.simHorizon] .== myLFES.engSysNet.pnPlaces.finalCond, base_name = "ESN_QBFinalCond")
    end
    # # Final Condition Constraints on Engineering System Net Transitions
    # This line needs to be validated!  AMRO!  
    if myLFES.hasProcessInitCond && myLFES.hasESN_Duration
        println("\t Building Engineering System Net Transition Final Conditions")
        @constraint(HFNMCF, QE[:, myLFES.simHorizon] .== myLFES.engSysNet.pnTransitions.finalCond, base_name = "ESN_QEFinalCond")
    end
    # # Upper Bound Constraint on Engineering System Net Places 
    if myLFES.hasBufferUpperBound
        println("\t Building Engineering System Net Place Upper Bound Constraints")
        @constraint(HFNMCF, QB[:,:] .<= myLFES.engSysNet.pnPlaces.upperBound, base_name = "ESN_QBUpperBound")
    end
    # # Upper Bound Constraint on Engineering System Net Transitions Inflows
    if myLFES.hasProcessUpperBoundFlowNeg
        println("\t Building Engineering System Net Transition Upper Bound In Flow Constraint")
        idx = .!isEmpty.(myLFES.engSysNet.pnTransitions.upperBoundFlowNeg)
        @constraint(HFNMCF, UEneg[idx,:] .<= myLFES.engSysNet.pnTransitions.upperBoundFlowNeg[idx], base_name = "ESN_UENegUpperBoundFlowNeg")
    end
    # # Upper Bound Constraint on Engineering System Net Transitions Outflows
    if myLFES.hasProcessUpperBoundFlowPos
        println("\t Building Engineering System Net Transition Upper Bound Out Flow Constraint")
        idx = .!isEmpty.(myLFES.engSysNet.pnTransitions.upperBoundFlowPos)
        @constraint(HFNMCF, UEpos[idx,:] .<= myLFES.engSysNet.pnTransitions.upperBoundFlowPos[idx], base_name = "ESN_UEPosUpperBoundFlowPos")
    end
    # # Upper Bound Constraint on Engineering System Net Transitions Stocks
    if myLFES.hasProcessUpperBoundStock
        println("\t Building Engineering System Net Transition Upper Bound Stock Constraint")
        idx = .!isEmpty.(myLFES.engSysNet.pnTransitions.upperBoundStock)
        @constraint(HFNMCF, QE[idx, :]   .== myLFES.engSysNet.pnTransitions.upperBoundStock[idx], base_name = "ESN_QEUpperBoundStock")
    end
    # # Lower Bound Constraint on Engineering System Net Places 
    if myLFES.hasBufferLowerBound
        println("\t Building Engineering System Net Place Lower Bound Constraints")
        @constraint(HFNMCF, QB[:,:] .>= myLFES.engSysNet.pnPlaces.lowerBound, base_name = "ESN_QBLowerBound")
    end
    # # Lower Bound Constraint on Engineering System Net Transitions Inflows
    if myLFES.hasProcessLowerBoundFlowNeg
        println("\t Building Engineering System Net Transition Lower Bound In Flow Constraint")
        idx = .!isEmpty.(myLFES.engSysNet.pnTransitions.lowerBoundFlowNeg)
        @constraint(HFNMCF, UEneg[idx,:] .>= myLFES.engSysNet.pnTransitions.lowerBoundFlowNeg[idx], base_name = "ESN_UENegLowerBoundFlowNeg")
    end
    # # Lower Bound Constraint on Engineering System Net Transitions Outflows
    if myLFES.hasProcessLowerBoundFlowPos
        println("\t Building Engineering System Net Transition Lower Bound Out Flow Constraint")
        idx = .!isEmpty.(myLFES.engSysNet.pnTransitions.lowerBoundFlowPos)
        @constraint(HFNMCF, UEpos[idx,:] .>= myLFES.engSysNet.pnTransitions.lowerBoundFlowPos[idx], base_name = "ESN_UEPosLowerBoundFlowPos")
    end
    # # Lower Bound Constraint on Engineering System Net Transitions Stocks
    if myLFES.hasProcessLowerBoundStock
        println("\t Building Engineering System Net Transition Lower Bound Stock Constraint")
        idx = .!isEmpty.(myLFES.engSysNet.pnTransitions.lowerBoundStock)
        @constraint(HFNMCF, QE[idx, :]   .>= myLFES.engSysNet.pnTransitions.lowerBoundStock[idx], base_name = "ESN_QELowerBoundStock")
    end
    # # Initial Conditions, Final Conditions, and Capacity Constraints on Operand Nets
    for l in 1:myLFES.operand.number
        # # Initial Condition Constraints on Operand Net Places
        if myLFES.operand.hasPlaceInitConds[l]
            println("\t Building Operand Net Number $l Initial Condition Place Constraints")
            @constraint(HFNMCF, QSL[l][:,1] .== myLFES.operand.pnPlaces[l].initCond, base_name = "OperandNet$(l)_QSLInitCond")
        end
        # # Initial Condition Constraints on Operand Net Transitions
        if myLFES.operand.hasTransitionInitConds[l] && myLFES.operand.hasOperandNet_Duration[l]
            println("\t Building Operand Net Number $l Initial Condition Transition Constraints")
            @constraint(HFNMCF, QEL[l][:,1] .== myLFES.operand.pnTransitions[l].initCond, base_name = "OperandNet$(l)_QELInitCond")
        end
        # # Final Condition Constraints on Operand Net Places
        if myLFES.operand.hasPlaceFinalConds[l]
            println("\t Building Operand Net Number $l Final Condition Place Constraints")
            @constraint(HFNMCF, QSL[l][:,myLFES.simHorizon] .== myLFES.operand.pnPlaces[l].finalCond, base_name = "OperandNet$(l)_QSLFinalCond")
        end
        # # Final Condition Constraints on Operand Net Transitions
        if myLFES.operand.hasTransitionFinalConds[l] && myLFES.operand.hasOperandNet_Duration[l]
            println("\t Building Operand Net Number $l Final Condition Transition Constraints")
            @constraint(HFNMCF, QEL[l][:,myLFES.simHorizon] .== myLFES.operand.pnTransitions[l].finalCond, base_name = "OperandNet$(l)_QSLFinalCond")
        end
        # # Upper Bound Constraint on Operand Net Places 
        if myLFES.operand.hasPlaceUpperBound[l]
            println("\t Building Operand Net Number $l Place Upper Bound Constraints")
            local idx 
            idx = .!isEmpty.(myLFES.operand.pnPlaces[l].upperBound)
            @constraint(HFNMCF, QSL[l][idx,:] .<= myLFES.operand.pnPlaces[l].upperBound[idx], base_name = "OperandNet$(l)_QSLUpperBound")
        end
        # # Upper Bound Constraint on Operand Net Transition Inflows 
        if myLFES.operand.hasTransitionUpperBoundFlowNeg[l]
            println("\t Building Operand Net Number $l Transition Upper Bound Inflow Constraints")
            local idx 
            idx = .!isEmpty.(myLFES.operand.pnTransitions[l].upperBoundFlowNeg)
            @constraint(HFNMCF, ULneg[l][idx,:] .<= myLFES.operand.pnTransitions[l].upperBoundFlowNeg[idx], base_name = "OperandNet$(l)_ULNegUpperBound")
        end
        # # Upper Bound Constraint on Operand Net Transition Outflows 
        if myLFES.operand.hasTransitionUpperBoundFlowPos[l]
            println("\t Building Operand Net Number $l Transition Upper Bound Outflow Constraints")
            local idx 
            idx = .!isEmpty.(myLFES.operand.pnTransitions[l].upperBoundFlowPos)
            @constraint(HFNMCF, ULpos[l][idx,:] .<= myLFES.operand.pnTransitions[l].upperBoundFlowPos[idx], base_name = "OperandNet$(l)_ULPosUpperBound")
        end
        # # Upper Bound Constraint on Operand Net Transition Stocks
        if myLFES.operand.hasTransitionUpperBoundStock[l]
            println("\t Building Operand Net Number $l Transition Upper Bound Stock Constraints")
            local idx 
            idx = .!isEmpty.(myLFES.operand.pnTransitions[l].upperBoundStock)
            @constraint(HFNMCF, QEL[l][idx,:] .<= myLFES.operand.pnTransitions[l].upperBoundStock[idx], base_name = "OperandNet$(l)_QELUpperBound")
        end
        # # Lower Bound Constraint on Operand Net Places 
        if myLFES.operand.hasPlaceLowerBound[l]
            println("\t Building Operand Net Number $l Place Lower Bound Constraints")
            local idx 
            idx = .!isEmpty.(myLFES.operand.pnPlaces[l].upperBound)
            @constraint(HFNMCF, QSL[l][idx,:] .>= myLFES.operand.pnPlaces[l].lowerBound[idx], base_name = "OperandNet$(l)_QSLLowerBound")
        end
        # # Lower Bound Constraint on Operand Net Transition Inflows 
        if myLFES.operand.hasTransitionLowerBoundFlowNeg[l]
            println("\t Building Operand Net Number $l Transition Lower Bound Inflow Constraints")
            local idx 
            idx = .!isEmpty.(myLFES.operand.pnTransitions[l].upperBoundFlowNeg)
            @constraint(HFNMCF, ULneg[l][idx,:] .>= myLFES.operand.pnTransitions[l].lowerBoundFlowNeg[idx], base_name = "OperandNet$(l)_ULNegLowerBound")
        end
        # # Lower Bound Constraint on Operand Net Transition Outflows 
        if myLFES.operand.hasTransitionLowerBoundFlowPos[l]
            println("\t Building Operand Net Number $l Transition Lower Bound Outflow Constraints")
            local idx 
            idx = .!isEmpty.(myLFES.operand.pnTransitions[l].upperBoundFlowPos)
            @constraint(HFNMCF, ULpos[l][idx,:] .>= myLFES.operand.pnTransitions[l].lowerBoundFlowPos[idx], base_name = "OperandNet$(l)_ULPosLowerBound")
        end
        # # Lower Bound Constraint on Operand Net Transition Stocks
        if myLFES.operand.hasTransitionLowerBoundStock[l]
            println("\t Building Operand Net Number $l Transition Lower Bound Stock Constraints")
            local idx 
            idx = .!isEmpty.(myLFES.operand.pnTransitions[l].upperBoundStock)
            @constraint(HFNMCF, QEL[l][idx,:] .>= myLFES.operand.pnTransitions[l].lowerBoundStock[idx], base_name = "OperandNet$(l)_QELLowerBound")
        end

        # # Implement Fatigue Rules
        if myLFES.subAnalysisMethod == "FreightFatigue"
            addFreightFatigueRules!(HFNMCF, myLFES, ULneg, l)
        end
    end

    # # Objective Function
    if myLFES.hasESN_STF1 && myLFES.hasBufferLinearCost
        println("\t Building Objective Function -- Engineering System Net Buffer Linear Costs")
        @expression(HFNMCF, fQB, sum(sum(myLFES.engSysNet.pnPlaces.linearCostCoeff .* QB)))
    else
        @expression(HFNMCF, fQB, 0)
    end
    if (myLFES.hasESN_STF1 || myLFES.hasESN_STF2) && myLFES.hasProcessLinearCostStock
        println("\t Building Objective Function -- Engineering System Net Process Stock Linear Costs")
        @expression(HFNMCF, fQE, sum(sum(myLFES.engSysNet.pnTransitions.linearCostCoeffStock .* QE)))
    else
        @expression(HFNMCF, fQE, 0)
    end
    if (myLFES.hasESN_STF1 || myLFES.hasESN_STF2) && myLFES.hasProcessLinearCostFlowNeg
        println("\t Building Objective Function -- Engineering System Net Process Inflow Linear Costs")
        @expression(HFNMCF, fUEneg, sum(sum(myLFES.engSysNet.pnTransitions.linearCostCoeffFlowNeg .* UEneg)))
    else
        @expression(HFNMCF, fUEneg, 0)
    end
    if (myLFES.hasESN_STF1 || myLFES.hasESN_STF2) && myLFES.hasProcessLinearCostFlowPos
        println("\t Building Objective Function -- Engineering System Net Process Outflow Linear Costs")
        @expression(HFNMCF, fUEpos, sum(sum(myLFES.engSysNet.pnTransitions.linearCostCoeffFlowPos .* UEpos)))
    else
        @expression(HFNMCF, fUEpos, 0)
    end
    if myLFES.hasESN_STF1 && myLFES.hasBufferQuadCost
        println("\t Building Objective Function -- Engineering System Net Buffer Quadratic Costs")
        @expression(HFNMCF, FQB, sum(sum(myLFES.engSysNet.pnPlaces.quadCostCoeff .* QB .* QB)))
    else
        @expression(HFNMCF, FQB, 0)
    end
    if (myLFES.hasESN_STF1 || myLFES.hasESN_STF2) && myLFES.hasProcessQuadCostStock
        println("\t Building Objective Function -- Engineering System Net Process Stock Quadratuc Costs")
        @expression(HFNMCF, FQE, sum(sum(myLFES.engSysNet.pnTransitions.quadCostCoeffStock .* QE .* QE)))
    else
        @expression(HFNMCF, FQE, 0)
    end
    if (myLFES.hasESN_STF1 || myLFES.hasESN_STF2) && myLFES.hasProcessQuadCostFlowNeg
        println("\t Building Objective Function -- Engineering System Net Process Inflow Quadratic Costs")
        @expression(HFNMCF, FUEneg, sum(sum(myLFES.engSysNet.pnTransitions.quadCostCoeffFlowNeg .* UEneg .* UEneg)))
    else
        @expression(HFNMCF, FUEneg, 0)
    end
    if (myLFES.hasESN_STF1 || myLFES.hasESN_STF2) && myLFES.hasProcessQuadCostFlowPos
        println("\t Building Objective Function -- Engineering System Net Process Outflow Quadratic Costs")
        @expression(HFNMCF, FUEpos, sum(sum(myLFES.engSysNet.pnTransitions.quadCostCoeffFlowPos .* UEpos .* UEpos)))
    else
        @expression(HFNMCF, FUEpos, 0)
    end

    # Predefine container for expressions
    fQSL   = Vector{Any}(undef, myLFES.operand.number)
    fQEL   = Vector{Any}(undef, myLFES.operand.number)
    fULneg = Vector{Any}(undef, myLFES.operand.number)
    fULpos = Vector{Any}(undef, myLFES.operand.number)
    FQSL   = Vector{Any}(undef, myLFES.operand.number)
    FQEL   = Vector{Any}(undef, myLFES.operand.number)
    FULneg = Vector{Any}(undef, myLFES.operand.number)
    FULpos = Vector{Any}(undef, myLFES.operand.number)
    for l in 1:myLFES.operand.number
        if myLFES.operand.hasOperandNet_STF1[l] && myLFES.operand.hasPlaceLinearCost[l]
            println("\t Building Objective Function -- Operand Net Number $l Place Linear Costs")
            fQSL[l] = @expression(HFNMCF, sum(sum(myLFES.operand.pnPlaces[l].linearCostCoeff .* QSL[l])))
        else
            fQSL[l] = @expression(HFNMCF, 0)
        end
        if myLFES.operand.hasOperandNet_STF1[l] && myLFES.operand.hasTransitionLinearCostStock[l]
            println("\t Building Objective Function -- Operand Net Number $l Transition Linear Costs")
            fQEL[l] = @expression(HFNMCF, sum(sum(myLFES.operand.pnTransitions[l].linearCostCoeffStock .* QEL[l])))
        else
            fQEL[l] = @expression(HFNMCF, 0)
        end
        if (myLFES.operand.hasOperandNet_STF1[l] || myLFES.operand.hasOperandNet_STF2[l]) && myLFES.operand.hasTransitionLinearCostFlowNeg[l]
            println("\t Building Objective Function -- Operand Net Number $l Transition Inflow Linear Costs")
            fULneg[l] = @expression(HFNMCF, sum(sum(myLFES.operand.pnTransitions[l].linearCostCoeffFlowNeg .* ULneg[l])))
        else
            fULneg[l] = @expression(HFNMCF, 0)
        end
        if (myLFES.operand.hasOperandNet_STF1[l] || myLFES.operand.hasOperandNet_STF2[l]) && myLFES.operand.hasTransitionLinearCostFlowPos[l]
            println("\t Building Objective Function -- Operand Net Number $l Transition Outflow Linear Costs")
            fULpos[l] = @expression(HFNMCF, sum(sum(myLFES.operand.pnTransitions[l].linearCostCoeffFlowPos .* ULpos[l])))
        else
            fULpos[l] = @expression(HFNMCF, 0)
        end
        if myLFES.operand.hasOperandNet_STF1[l] && myLFES.operand.hasPlaceQuadCost[l]
            println("\t Building Objective Function -- Operand Net Number $l Place Quadratic Costs")
            FQSL[l] = @expression(HFNMCF, sum(sum(myLFES.operand.pnPlaces[l].quadCostCoeff .* QSL[l] .* QSL[l])))
        else
            FQSL[l] = @expression(HFNMCF, 0)
        end
        if myLFES.operand.hasOperandNet_STF1[l] && myLFES.operand.hasTransitionQuadCostStock[l]
            println("\t Building Objective Function -- Operand Net Number $l Transition Quadratic Costs")
            fQEL[l] = @expression(HFNMCF, sum(sum(myLFES.operand.pnTransitions[l].quadCostCoeffStock .* QEL[l] .* QEL[l])))
        else
            FQEL[l] = @expression(HFNMCF, 0)
        end
        if (myLFES.operand.hasOperandNet_STF1[l] || myLFES.operand.hasOperandNet_STF2[l]) && myLFES.operand.hasTransitionQuadCostFlowNeg[l]
            println("\t Building Objective Function -- Operand Net Number $l Transition Inflow Quadratic Costs")
            FULneg[l] = @expression(HFNMCF, sum(sum(myLFES.operand.pnTransitions[l].quadCostCoeffFlowNeg .* ULneg[l] .* ULneg[l])))
        else
            FULneg[l] = @expression(HFNMCF, 0)
        end
        if (myLFES.operand.hasOperandNet_STF1[l] || myLFES.operand.hasOperandNet_STF2[l]) && myLFES.operand.hasTransitionQuadCostFlowPos[l]
            println("\t Building Objective Function -- Operand Net Number $l Transition Outflow Quadratic Costs")
            FULpos[l] = @expression(HFNMCF, sum(sum(myLFES.operand.pnTransitions[l].quadCostCoeffFlowPos .* ULpos[l] .* ULpos[l])))
        else
            FULpos[l] = @expression(HFNMCF, 0)
        end
    end
    println("\t Building Complete Objective Function")
    @objective(HFNMCF, Min, FQB + FQE + FUEneg + FUEpos + fQB + fQE + fUEneg + fUEpos + sum(FQSL) + sum(FQEL) + sum(FULneg) + sum(FULpos) + sum(fQSL) + sum(fQEL) + sum(fULneg) + sum(fULpos))
    return HFNMCF, QB, QF, QE, UEneg, UEpos, QSL, QFL,QEL, ULneg, ULpos
end
function visualizeHFNMCFProblem(HFNMCF)
    open("tempHFNMCFProblem.txt", "w") do file
        teeprintln(file)
        teeprintln(file, "Objective Function:  ")
        teeprintln(file, objective_function(HFNMCF))
        teeprintln(file, "Constraints:")

        for c in all_constraints(HFNMCF, include_variable_in_set_constraints=false)
            teeprintln(file, c)
        end
    end
end
function storeHFNMCFResults(myLFES, QB, QF, QE, UEneg, UEpos, QSL, QFL, QEL, ULneg, ULpos)
    if myLFES.hasESN_STF1
        println("QB - Value of Engineering System Net Places:")
        display(cleanZeros(value.(QB)));
        myLFES.engSysNet.XS = sparse(cleanZeros(value.(QB)))
        myLFES.engSysNet.XF = sparse(cleanZeros(value.(QF)))
    end
    if myLFES.hasESN_STF2
        println("QE - Value of Engineering System Net Transitions:")
        display(cleanZeros(value.(QE)));
        myLFES.engSysNet.XE = sparse(cleanZeros(value.(QE)))
    end
    if myLFES.hasESN_STF1 || myLFES.hasESN_STF2
        println("UEneg - Value of Engineering System Net Transition Initiation:")
        display(cleanZeros(value.(UEneg)));
        myLFES.engSysNet.Uneg = sparse(cleanZeros(value.(UEneg)))
    end
    if (myLFES.hasESN_STF1 || myLFES.hasESN_STF2) && !all(isZero,myLFES.engSysNet.pnTransitions.duration)
        println("UEpos - Value of Engineering System Net Transition Termination:")
        display(cleanZeros(value.(UEpos)));
        myLFES.engSysNet.Upos = sparse(cleanZeros(value.(UEpos)))
    end
    for l in 1:myLFES.operand.number
        if myLFES.operand.hasOperandNet_STF1[l]
            println("QSL[$l] - Value of Operand Net Number $l Places:")
            display(convert.(Int64, value.(QSL[l])));
            myLFES.operand.XS[l] = sparse(cleanZeros(value.(QSL[l])))
            myLFES.operand.XF[l] = sparse(cleanZeros(value.(QFL[l])))
        end
        if myLFES.operand.hasOperandNet_STF2[l]
            println("QEL[$l] Value of Operand Net Number $l Transitions:")
            display(convert.(Int64, value.(QEL[l])));
            myLFES.operand.XE[l] = sparse(cleanZeros(value.(QEL[l])))
        end
        if myLFES.operand.hasOperandNet_STF1[l] || myLFES.operand.hasOperandNet_STF2[l]
            println("ULneg[$l] - Value of Operand Net Number $l Transition Initiation:")
            display(convert.(Bool, value.(ULneg[l])));
            myLFES.operand.Uneg[l] = sparse(cleanZeros(value.(ULneg[l])))
            println("ULpos[$l] - Value of Operand Net Number $l Transition Termination:")
            display(convert.(Bool, value.(ULpos[l])));
            myLFES.operand.Upos[l] = sparse(cleanZeros(value.(ULpos[l])))
        end
    end
    return myLFES
end
function saveHFNMCFData(myLFES)
    if myLFES.hasESN_STF1
        println("QB - Value of Engineering System Net Places:")
        myLFES.engSysNet.XS = sparseMat2MutableStruct(myLFES.engSysNet.XS)
        myLFES.engSysNet.XF = sparseMat2MutableStruct(myLFES.engSysNet.XF)
    end
    if myLFES.hasESN_STF2
        println("QE - Value of Engineering System Net Transitions:")
        myLFES.engSysNet.XE = sparseMat2MutableStruct(myLFES.engSysNet.XE)
    end
    if myLFES.hasESN_STF1 || myLFES.hasESN_STF2
        println("UEneg - Value of Engineering System Net Transition Initiation:")
        myLFES.engSysNet.Uneg = sparseMat2MutableStruct(myLFES.engSysNet.Uneg)
    end
    if (myLFES.hasESN_STF1 || myLFES.hasESN_STF2) && !all(isZero,myLFES.engSysNet.pnTransitions.duration)
        myLFES.engSysNet.Upos = sparseMat2MutableStruct(myLFES.engSysNet.Upos)
    end
    for l in 1:myLFES.operand.number
        if myLFES.operand.hasOperandNet_STF1[l]
            println("QSL[$l] - Value of Operand Net Number $l Places:")
            myLFES.operand.XS[l] = sparseMat2MutableStruct(myLFES.operand.XS[l])
            myLFES.operand.XF[l] = sparseMat2MutableStruct(myLFES.operand.XF[l])
        end
        if myLFES.operand.hasOperandNet_STF2[l]
            println("QEL[$l] Value of Operand Net Number $l Transitions:")
            myLFES.operand.XE[l] = sparseMat2MutableStruct(myLFES.operand.XE[l])
        end
        if myLFES.operand.hasOperandNet_STF1[l] || myLFES.operand.hasOperandNet_STF2[l]
            println("ULneg[$l] - Value of Operand Net Number $l Transition Initiation:")
            myLFES.operand.Uneg[l] = sparseMat2MutableStruct(myLFES.operand.Uneg[l])
            println("ULpos[$l] - Value of Operand Net Number $l Transition Termination:")
            myLFES.operand.Upos[l] = sparseMat2MutableStruct(myLFES.operand.Upos[l])
        end
    end
    myLFES.engSysNet.Mneg = sparseMat2MutableStruct(myLFES.engSysNet.Mneg)
    myLFES.engSysNet.Mpos = sparseMat2MutableStruct(myLFES.engSysNet.Mpos)
    myLFES.operand.Mneg = [sparseMat2MutableStruct(myLFES.operand.Mneg[l]) for l in 1:myLFES.operand.number]
    myLFES.operand.Mpos = [sparseMat2MutableStruct(myLFES.operand.Mpos[l]) for l in 1:myLFES.operand.number]
    myLFES.operand.syncMat = [sparseMat2MutableStruct(myLFES.operand.syncMat[l]) for l in 1:myLFES.operand.number]
    
    if myLFES.hasBufferLinearCost
        myLFES.engSysNet.pnPlaces.linearCostCoeff = convertMatrix2VecOfVec(myLFES.engSysNet.pnPlaces.linearCostCoeff)
    end
    if myLFES.hasBufferQuadCost
        myLFES.engSysNet.pnPlaces.quadCostCoeff = convertMatrix2VecOfVec(myLFES.engSysNet.pnPlaces.quadCostCoeff)
    end
    if myLFES.hasProcessLinearCostFlowNeg
        myLFES.engSysNet.pnTransitions.linearCostCoeffFlowNeg = convertMatrix2VecOfVec(myLFES.engSysNet.pnTransitions.linearCostCoeffFlowNeg)
    end
    if myLFES.hasProcessLinearCostFlowPos
        myLFES.engSysNet.pnTransitions.linearCostCoeffFlowPos = convertMatrix2VecOfVec(myLFES.engSysNet.pnTransitions.linearCostCoeffFlowPos)
    end
    if myLFES.hasProcessLinearCostStock
        myLFES.engSysNet.pnTransitions.linearCostCoeffStock  = convertMatrix2VecOfVec(myLFES.engSysNet.pnTransitions.linearCostCoeffStock)
    end
    if myLFES.hasProcessQuadCostFlowNeg
        myLFES.engSysNet.pnTransitions.quadCostCoeffFlowNeg = convertMatrix2VecOfVec(myLFES.engSysNet.pnTransitions.quadCostCoeffFlowNeg)
    end
    if myLFES.hasProcessQuadCostFlowPos
        myLFES.engSysNet.pnTransitions.quadCostCoeffFlowPos = convertMatrix2VecOfVec(myLFES.engSysNet.pnTransitions.quadCostCoeffFlowPos)
    end
    if myLFES.hasProcessQuadCostStock
        myLFES.engSysNet.pnTransitions.quadCostCoeffStock  = convertMatrix2VecOfVec(myLFES.engSysNet.pnTransitions.quadCostCoeffStock)
    end

    for l in 1:myLFES.operand.number
        if myLFES.operand.hasPlaceLinearCost[l]
            myLFES.operand.pnPlaces[l].linearCostCoeff = convertMatrix2VecOfVec(myLFES.operand.pnPlaces[l].linearCostCoeff)
        end
        if myLFES.operand.hasPlaceQuadCost[l]
            myLFES.operand.pnPlaces[l].quadCostCoeff = convertMatrix2VecOfVec(myLFES.operand.pnPlaces[l].quadCostCoeff)
        end
        if myLFES.operand.hasTransitionLinearCostFlowNeg[l]
            myLFES.operand.pnTransitions[l].linearCostCoeffFlowNeg = convertMatrix2VecOfVec(myLFES.operand.pnTransitions[l].linearCostCoeffFlowNeg)
        end
        if myLFES.operand.hasTransitionLinearCostFlowPos[l]
            myLFES.operand.pnTransitions[l].linearCostCoeffFlowPos = convertMatrix2VecOfVec(myLFES.operand.pnTransitions[l].linearCostCoeffFlowPos)
        end
        if myLFES.operand.hasTransitionLinearCostStock[l]
            myLFES.operand.pnTransitions[l].linearCostCoeffStock = convertMatrix2VecOfVec(myLFES.operand.pnTransitions[l].linearCostCoeffStock)
        end

        if myLFES.operand.hasTransitionQuadCostFlowNeg[l]
            myLFES.operand.pnTransitions[l].quadCostCoeffFlowNeg = convertMatrix2VecOfVec(myLFES.operand.pnTransitions[l].quadCostCoeffFlowNeg)
        end
        if myLFES.operand.hasTransitionQuadCostFlowPos[l]
            myLFES.operand.pnTransitions[l].quadCostCoeffFlowPos = convertMatrix2VecOfVec(myLFES.operand.pnTransitions[l].quadCostCoeffFlowPos)
        end
        if myLFES.operand.hasTransitionQuadCostStock[l]
            myLFES.operand.pnTransitions[l].quadCostCoeffStock = convertMatrix2VecOfVec(myLFES.operand.pnTransitions[l].quadCostCoeffStock)
        end
    end
    JSON3.write(myLFES.juliaOutputFilePath.value, HFNMCFTools.createJSON3(myLFES))
    return myLFES
end
function optHFNMCF(inputFilePath)
    myLFES = loadHFNMCFData(inputFilePath)

    ############ Start of JuMP Optimization #################
    HFNMCF, QB, QF, QE, UEneg, UEpos, QSL, QFL,QEL, ULneg, ULpos = buildHFNMCFProblem(myLFES)

    if myLFES.verboseMode
        visualizeHFNMCFProblem(HFNMCF)
    end

    # # Solving HFNMCF Optimization Model
    println("\n")
    println("Solving HFNMCF Optimization Model")
    println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
    optimize!(HFNMCF)
    ############ End of Jump Optimization #################
    # # Reporting HFNMCF Optimization Model Solution
    println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
    println("\n")
    println(termination_status(HFNMCF))
    if termination_status(HFNMCF) != MOI.INFEASIBLE_OR_UNBOUNDED
        println("Optimal Value:  ",objective_value(HFNMCF))
        myLFES = storeHFNMCFResults(myLFES, QB, QF, QE, UEneg, UEpos, QSL, QFL, QEL, ULneg, ULpos)
    end

    # ############ HOWTO Analyze Your Results #################
    # Investigate the following names and values of decision variables one by one.   
    # myLFES.engSysNet.pnPlaces.name
    # myLFES.engSysNet.XS
    # myLFES.engSysNet.pnTransitions.name
    # myLFES.engSysNet.XE
    # myLFES.engSysNet.Uneg
    # myLFES.engSysNet.Upos
    # myLFES.operand.number
    # l = 1 # Any number from 1 to myLFES.oeprand.number
    # myLFES.operand.operandName
    # myLFES.operand.operandName[l]
    # myLFES.operand.pnPlaces.name[l]
    # myLFES.operand.XS[l]
    # myLFES.operand.pnTransitions.name[l]
    # myLFES.operand.XE[l]
    # myLFES.operand.Uneg[l]
    # myLFES.operand.Upos[l]
    # You can investigate the constant parameters of the HFNMCF problem in saveHFNMCFData()
    # You can investigate how these decision variables and constant parameters are used in buildHFNMCFProblem()
    # ############ Saving Output Data #################
    myLFES = HFNMCFTools.saveHFNMCFData(myLFES)
    return myLFES
end

export loadHFNMCFData, buildHFNMCFProblem, visualizeHFNMCFProblem, storeHFNMCFResults, saveHFNMCFData, optHFNMCF
end # End of Module
