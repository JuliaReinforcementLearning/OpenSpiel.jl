# OpenSpiel.jl

[![Build Status](https://travis-ci.com/JuliaReinforcementLearning/OpenSpiel.jl.svg?branch=master)](https://travis-ci.com/JuliaReinforcementLearning/OpenSpiel.jl)

This package provides a Julia wrapper for the [OpenSpiel](https://github.com/deepmind/open_spiel) project. Most APIs are aligned with those in Python. Here's a quick example:

```julia
using OpenSpiel

# Here we need the StatsBase package for weighted sampling
using Pkg
Pkg.add("StatsBase")
using StatsBase

function run_once(name)
    game = load_game(name)
    state = new_initial_state(game)
    println("Initial state of game[$(name)] is:\n$(state)")

    while !is_terminal(state)
        if is_chance_node(state)
            outcomes_with_probs = chance_outcomes(state)
            println("Chance node, got $(length(outcomes_with_probs)) outcomes")
            actions, probs = zip(outcomes_with_probs...)
            action = actions[sample(weights(collect(probs)))]
            println("Sampled outcome: $(action_to_string(state, action))")
            apply_action(state, action)
        elseif is_simultaneous_node(state)
            chosen_actions = [rand(legal_actions(state, pid-1)) for pid in 1:num_players(game)]  # in Julia, indices start at 1
            println("Chosen actions: $([action_to_string(state, pid-1, action) for (pid, action) in enumerate(chosen_actions)])")
            apply_action(state, chosen_actions)
        else
            action = rand(legal_actions(state))
            println("Player $(current_player(state)) randomly sampled action: $(action_to_string(state, action))")
            apply_action(state, action)
        end
        println(state)
    end
    rts = returns(state)
    for pid in 1:num_players(game)
        println("Utility for player $(pid-1) is $(rts[pid])")
    end
end

run_once("tic_tac_toe")
run_once("kuhn_poker")
run_once("goofspiel(imp_info=True,num_cards=4,points_order=descending)")
```

For higher level APIs you may refer [ReinforcementLearningEnvironments.jl](https://github.com/JuliaReinforcementLearning/ReinforcementLearningEnvironments.jl).