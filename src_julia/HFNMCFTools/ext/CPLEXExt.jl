module CPLEXExt
    using HFNMCFTools, CPLEX

    function __init__()
        HFNMCFTools._OPTIMIZER_REGISTRY["cplex"] = CPLEX.Optimizer
    end
end