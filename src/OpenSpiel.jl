module OpenSpiel

using CxxWrap
using OpenSpiel_jll

import CxxWrap:argument_overloads

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
    @initcxx
end


end # module
