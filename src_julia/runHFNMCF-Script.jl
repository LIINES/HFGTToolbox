# Copyright (c) 2022-2026 Engineering Systems Analytics LLC
# @author: Amro M. Farid
# @version: 4.6.8
# @Modified: 03/30/2026

using Pkg
Pkg.activate(joinpath(@__DIR__, "HFNMCFTools"))
using HFNMCFTools

# Load optional commercial solvers if available.
# Install in your global Julia environment: julia -e 'using Pkg; Pkg.add("CPLEX")'
for pkg in ["CPLEX", "Gurobi"]
    try; @eval using $(Symbol(pkg)); catch; end
end
 

############ Load Input Data #################
# WARNING!  If you are using VSCode, make sure to open the folder with the entire HFGT Toolbox and not just Julia folder.  
inputFilePath = "3_PyHFGT_Output_Data/myLFES-ExampleNetworkNoOperandNetsHFNMCF-Defaultxml-Base-2026-05-24.json"
# inputFilePath = "3_PyHFGT_Output_Data/myLFES-H2NG-NetherlandsAMF-Defaultxml-Base-2026-05-24.json"
# inputFilePath = "3_PyHFGT_Output_Data/myLFES-miniTEN-Coordinated-defaultXML-2026-01-05.json"
# inputFilePath = "3_PyHFGT_Output_Data/myLFES-TransportationNetwork-Defaultxml-Base-2026-03-26.json"
# inputFilePath = "3_PyHFGT_Output_Data/myLFES-RCPSP1-Defaultxml-Renewable-Resources-2026-04-12.json"
# inputFilePath = "3_PyHFGT_Output_Data/myLFES-RCPSP1-Defaultxml-Renewable-Resources-Esn-2026-01-24.json"
# inputFilePath = "3_PyHFGT_Output_Data/myLFES-ElectricPowerSystem-Dynamiceconomicdispatch-defaultXML-2025-12-20.json"
# inputFilePath = "3_PyHFGT_Output_Data/myLFES-ElectricPowerSystem-Staticeconomicdispatch-defaultXML-2025-12-20.json"
# inputFilePath = "3_PyHFGT_Output_Data/myLFES-NEAC-freight-Defaultxml-Base-2026-03-26.json"
# inputFilePath = "3_PyHFGT_Output_Data/myLFES-NEAC-freight-Defaultxml-Long-2026-05-05.json"
# inputFilePath = "3_PyHFGT_Output_Data/myLFES-NEAC-freight-Defaultxml-Place-Specific-Fatigue-2026-05-05.json"
# inputFilePath = "3_PyHFGT_Output_Data/myLFES-MCFEdge-Defaultxml-Base-2026-02-08.json"
# inputFilePath = "3_PyHFGT_Output_Data/myLFES-MCF2Edge-Defaultxml-Base-2026-02-08.json"
# inputFilePath = "3_PyHFGT_Output_Data/myLFES-EPS9-DCOPF-Defaultxml-Base-2026-01-24.json"

# inputFilePath = "3_PyHFGT_Output_Data/myLFES-ChesapeakeBayWatershedSystem-Defaultxml-Nitrogenphosphorusdelivery-2026-01-31.json"
# inputFilePath = "3_PyHFGT_Output_Data/myLFES-EPS9-DCOPF-Sysml-Base-2026-04-11.json"
# inputFilePath = "3_PyHFGT_Output_Data/myLFES-EPS2-UnitCommitment-Defaultxml-Base-2026-04-17.json"
# inputFilePath = "3_PyHFGT_Output_Data/myLFES-NEAC-freight-Defaultxml-Place-Specific-Fatigue-2026-05-05.json"
# inputFilePath = "3_PyHFGT_Output_Data/myLFES-TIMESCoalSystem-Defaultxml-Staticeconomicdispatch-2026-05-05.json"

using JuMP
using PrettyPrint, SparseArrays
# include("HFNMCFTools/src/HFNMCFTools.jl")

myLFES = HFNMCFTools.loadHFNMCFData(inputFilePath)

# ############ Start of JuMP Optimization #################
# HFNMCF, QB, QF, QE, UEneg, UEpos, QSL, QFL,QEL, ULneg, ULpos = HFNMCFTools.buildHFNMCFProblem(myLFES)

# if myLFES.verboseMode
#     HFNMCFTools.visualizeHFNMCFProblem(HFNMCF)
# end

# # # Solving HFNMCF Optimization Model
# println("\n")
# println("Solving HFNMCF Optimization Model")
# println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
# optimize!(HFNMCF)
# ############ End of Jump Optimization #################
# # # Reporting HFNMCF Optimization Model Solution
# println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
# println("\n")
# println(termination_status(HFNMCF))
# if termination_status(HFNMCF) != MOI.INFEASIBLE_OR_UNBOUNDED
#     println("Optimal Value:  ",objective_value(HFNMCF))
#     myLFES = HFNMCFTools.storeHFNMCFResults(myLFES, QB, QF, QE, UEneg, UEpos, QSL, QFL, QEL, ULneg, ULpos)
# end

# ############ HOWTO Analyze Your Results #################
# Investigate the following names and values of decision variables one by one.   
# myLFES.engSysNet.pnPlaces.name
# myLFES.engSysNet.XS
# myLFES.engSysNet.XF
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
# myLFES = HFNMCFTools.saveHFNMCFData(myLFES)

