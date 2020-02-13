__precompile__(false)
module OpenSpiel

using CxxWrap
using OpenSpiel_jll

import CxxWrap:argument_overloads
import Base:show, length, getindex, setindex!, keys, values, copy, deepcopy, first, last, step, getfield, setfield!

@wrapmodule(libspieljl)

include("patch.jl")

# export all
for n in names(@__MODULE__(); all=true)
    if Base.isidentifier(n) &&
        !startswith(String(n), "_") &&
        n ∉ (Symbol(@__MODULE__()), :eval, :include)
        @eval export $n
    end
end


function __init__()
    # TODO: https://github.com/JuliaInterop/libcxxwrap-julia/issues/39#issuecomment-585019888
    # @initcxx
end


end # module
