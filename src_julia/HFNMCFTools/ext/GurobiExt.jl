module GurobiExt
    using HFNMCFTools, Gurobi

    function __init__()
        HFNMCFTools._OPTIMIZER_REGISTRY["gurobi"] = Gurobi.Optimizer
    end
end