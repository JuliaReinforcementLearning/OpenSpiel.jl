Base.show(io::IO, g::CxxWrap.StdLib.SharedPtrAllocated{Game}) = print(io, to_string(g[]))
Base.show(io::IO, s::CxxWrap.StdLib.UniquePtrAllocated{State}) = print(io, to_string(s[]))
Base.show(io::IO, gp::Union{GameParameterAllocated, GameParameterDereferenced}) = print(io, to_repr_string(gp))

function Base.hash(s::CxxWrap.CxxWrapCore.SmartPointer{T}, h::UInt) where {T<:Union{Game,State}}
    hash(to_string(s[]), h)
end

function Base.:(==)(s::CxxWrap.CxxWrapCore.SmartPointer{T}, ss::CxxWrap.CxxWrapCore.SmartPointer{T}) where {T<:Union{Game, State}}
    to_string(s[]) == to_string(ss[])
end

GameParameter(x::Int) = GameParameter(Ref(Int32(x)))

Base.copy(s::CxxWrap.StdLib.UniquePtrAllocated{State}) = deepcopy(s)
Base.deepcopy(s::CxxWrap.StdLib.UniquePtrAllocated{State}) = clone(s[])
Base.reshape(s::CxxWrap.StdLib.StdVectorAllocated, dims::Int32...) = reshape(s, Int.(dims))

if Sys.KERNEL == :Linux
    function apply_action(state, actions::AbstractVector{<:Number})
        A = StdVector{CxxLong}()
        for a in actions
            push!(A, a)
        end
        apply_actions(state, A)
    end
elseif Sys.KERNEL == :Darwin
    function apply_action(state, actions::AbstractVector{<:Number})
        A = StdVector{Int}()
        for a in actions
            push!(A, a)
        end
        apply_actions(state, A)
    end
else
    @error "unsupported system"
end

function deserialize_game_and_state(s::CxxWrap.StdLib.StdStringAllocated)
    game_and_state = _deserialize_game_and_state(s)
    first(game_and_state), last(game_and_state)
end

Base.values(m::StdMap) = [m[k] for k in keys(m)]

function StdMap{K, V}(kw) where {K, V}
    ps = StdMap{K, V}()
    for (k, v) in kw
        ps[convert(K, k)] = convert(V, v)
    end
    ps
end

function Base.show(io::IO, ps::StdMapAllocated{K, V}) where {K, V}
    println(io, "StdMap{$K,$V} with $(length(ps)) entries:")
    for k in keys(ps)
        println(io, "  $k => $(ps[k])")
    end
end

function load_game(s::Union{String, CxxWrap.StdLib.StdStringAllocated}; kw...)
    if length(kw) == 0
        _load_game(s)
    else
        ps = [StdString(string(k)) => v for (k,v) in kw]
        _load_game(s, StdMap{StdString, GameParameter}(ps))
    end
end

function load_game_as_turn_based(s::Union{String, CxxWrap.StdLib.StdStringAllocated}; kw...)
    if length(kw) == 0
        _load_game_as_turn_based(s)
    else
        ps = [StdString(string(k)) => v for (k,v) in kw]
        _load_game_as_turn_based(s, StdMap{StdString, GameParameter}(ps))
    end
end

is_chance_node(state::CxxWrap.StdLib.UniquePtrAllocated{State}) = is_chance_node(state[])

new_initial_state(game::CxxWrap.StdLib.SharedPtrAllocated{Game}) = new_initial_state(game[])

legal_actions(state::CxxWrap.StdLib.UniquePtrAllocated{State}) = legal_actions(state[])

child(state::CxxWrap.StdLib.UniquePtrAllocated{State}, i::Int64) = child(state[], i)

is_terminal(state::CxxWrap.StdLib.UniquePtrAllocated{State}) = is_terminal(state[])

information_state_string(state::CxxWrap.StdLib.UniquePtrAllocated{State}) = information_state_string(state[])

information_state_string(state::CxxWrap.StdLib.UniquePtrAllocated{State}, i) = information_state_string(state[], i)

information_state_tensor(state::CxxWrap.StdLib.UniquePtrAllocated{State}, i::Int64) = information_state_tensor(state[], i)

information_state_tensor_shape(game::CxxWrap.StdLib.SharedPtrAllocated{Game}) = information_state_tensor_shape(game[])

get_uniform_policy(game::CxxWrap.StdLib.SharedPtrAllocated{Game}) = get_uniform_policy(game[])

record_batched_trajectories(game::CxxWrap.StdLib.SharedPtrAllocated{Game}, p::CxxWrap.StdLib.StdVectorAllocated{TabularPolicy}, m::StdMapAllocated{StdString, Int32}, i::Int64, b::Bool, i2::Int64, i3::Int64) = record_batched_trajectories(game[], p, m, i, b, i2, i3)

expected_returns(state::CxxWrap.StdLib.UniquePtrAllocated{State}, policy::CxxWrap.StdLib.SharedPtrAllocated{Policy}, i::Int64) = expected_returns(state[], policy[], i)

exploitability(game::CxxWrap.StdLib.SharedPtrAllocated{Game}, policy::CxxWrap.StdLib.SharedPtrAllocated{Policy}) = exploitability(game[], policy[])

current_player(state::CxxWrap.StdLib.UniquePtrAllocated{State}) = current_player(state[])

action_to_string(state::CxxWrap.StdLib.UniquePtrAllocated{State}, i1, i2) = action_to_string(state[], i1, i2)

apply_action(state::CxxWrap.StdLib.UniquePtrAllocated{State}, i::AbstractVector{<:Number}) = apply_action(state[], i)

apply_action(state::CxxWrap.StdLib.UniquePtrAllocated{State}, i::Number) = apply_action(state[], i)

restart_at(b::MCTSBotAllocated, s::CxxWrap.StdLib.UniquePtrAllocated{State}) = restart_at(b, s[])

best_child(root::CxxWrap.StdLib.UniquePtrAllocated{SearchNode}) = best_child(root[])

get_outcome(root::CxxWrap.StdLib.UniquePtrAllocated{SearchNode}) = get_outcome(root[])

get_player(p::CxxWrap.StdLib.UniquePtrAllocated{SearchNode}) = get_player(p[])

get_children(root::CxxWrap.StdLib.UniquePtrAllocated{SearchNode}) = get_children(root[])

is_simultaneous_node(state::CxxWrap.StdLib.UniquePtrAllocated{State}) = is_simultaneous_node(state[])

step(bot, state::CxxWrap.StdLib.UniquePtrAllocated{State}) = step(bot, state[])

chance_outcomes(state::CxxWrap.StdLib.UniquePtrAllocated{State}) = chance_outcomes(state[])

returns(state::CxxWrap.StdLib.UniquePtrAllocated{State}) = returns(state[])

min_utility(game::CxxWrap.StdLib.SharedPtrAllocated{Game}) = min_utility(game[])

max_utility(game::CxxWrap.StdLib.SharedPtrAllocated{Game}) = max_utility(game[])

serialize_game_and_state(game::CxxWrap.StdLib.SharedPtrAllocated{Game}, state::CxxWrap.StdLib.UniquePtrAllocated{State}) = serialize_game_and_state(game[], state[])

is_mean_field_node(state::CxxWrap.StdLib.UniquePtrAllocated{State}) = is_mean_field_node(state[])

legal_actions(state::CxxWrap.StdLib.UniquePtrAllocated{State}, i) = legal_actions(state[], i)

history(state::CxxWrap.StdLib.UniquePtrAllocated{State}) = history(state[])

is_player_node(state::CxxWrap.StdLib.UniquePtrAllocated{State}) = is_player_node(state[])

num_players(game::CxxWrap.StdLib.SharedPtrAllocated{Game}) = num_players(game[])

distribution_support(state::CxxWrap.StdLib.UniquePtrAllocated{State}) = distribution_support(state[])

get_type(game::CxxWrap.StdLib.SharedPtrAllocated{Game}) = get_type(game[])

update_distribution(state::CxxWrap.StdLib.UniquePtrAllocated{State}, dist::CxxWrap.StdLib.StdVectorAllocated{Float64}) = update_distribution(state[], dist)

num_cols(game::CxxWrap.StdLib.SharedPtrAllocated{MatrixGame}) = num_cols(game[])

num_rows(game::CxxWrap.StdLib.SharedPtrAllocated{MatrixGame}) = num_rows(game[])

extensive_to_matrix_game(game::CxxWrap.StdLib.SharedPtrAllocated{Game}) = extensive_to_matrix_game(game[])
