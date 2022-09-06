using Printf
using DataFrames
using CSV

function run_loop(MR_neg_df,MR_pos_df)
    println("Enterling loops")
    dof1 = Vector{Int64}
    dof1Dump = zeros(Int64, (length(MR_pos_df."DOF")+length(MR_neg_df."DOF"))*4)
    dof2 = Vector{Int64}
    dof2Dump = zeros(Int64, (length(MR_pos_df."DOF")+length(MR_neg_df."DOF"))*4)
    val = Vector{Bool}
    valDump = zeros(Bool, (length(MR_pos_df."DOF")+length(MR_neg_df."DOF"))*4)
    elemCount = 0
    progCheck = 0
    progCheck2 = 100000
    for (k1I, k1D) in enumerate(MR_pos_df."DOF")
        progCheck+=1
        if progCheck==progCheck2
            println(progCheck)
            progCheck2 += 100000
        end
        buff = MR_pos_df."buffer"[k1I]
        test = (MR_neg_df."buffer").== buff
        dof2Idx = MR_neg_df."DOF"[test]
        for k2D in dof2Idx
            elemCount += 1
            dof1Dump[elemCount] = k1D
            dof2Dump[elemCount] = k2D
            valDump[elemCount] = true
        end
    end
    dof1 = vcat(dof1, dof1Dump[1:elemCount])
    dof2 = vcat(dof2, dof2Dump[1:elemCount])
    val = vcat(val, valDump[1:elemCount])
    dofs = hcat(dof1,dof2)
    dofsUni = unique(dofs, dims=1)
    CSV.write("ARIdx.csv",  Tables.table(dofsUni), writeheader=false)
end


println("Loading CSVs")
MR_neg_df = CSV.read("MR_neg.csv", DataFrame)
MR_pos_df = CSV.read("MR_pos.csv", DataFrame)


MR_neg_df."buffer" = convert.(Int64, MR_neg_df."buffer")
MR_neg_df."DOF" = convert.(Int64, MR_neg_df."DOF")
MR_pos_df."buffer" = convert.(Int64, MR_pos_df."buffer")
MR_pos_df."DOF" = convert.(Int64, MR_pos_df."DOF")


run_loop(MR_neg_df,MR_pos_df)
