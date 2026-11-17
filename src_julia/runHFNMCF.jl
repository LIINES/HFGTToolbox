# Copyright (c) 2022-2025 Engineering Systems Analytics LLC
# @author: Amro M. Farid
# @version: 4.7.4
# @Modified: 05/22/2026

using Pkg
Pkg.activate(joinpath(@__DIR__, "HFNMCFTools"))
using HFNMCFTools

# # Load optional commercial solvers if available.
# # Install in your global Julia environment: julia -e 'using Pkg; Pkg.add("CPLEX")'
# for pkg in ["CPLEX", "Gurobi"]
#     try; @eval using $(Symbol(pkg)); catch; end
# end

# Check command line arguments
if length(ARGS) < 1
    println("Usage: julia runHFNMCF.jl <path_to_json_input_file>")
    exit(1)
end
inputFilePath = ARGS[1]

println("Running HFNMCF optimization with input file: $inputFilePath")
myLFES = HFNMCFTools.optHFNMCF(inputFilePath)
println("Optimization complete. Results saved to: ", myLFES.juliaOutputFilePath)

