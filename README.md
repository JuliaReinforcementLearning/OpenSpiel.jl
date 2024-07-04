# OpenSpiel.jl

[![Build Status](https://travis-ci.com/JuliaReinforcementLearning/OpenSpiel.jl.svg?branch=master)](https://travis-ci.com/JuliaReinforcementLearning/OpenSpiel.jl)

This package provides a Julia wrapper for the [OpenSpiel](https://github.com/deepmind/open_spiel) project. For more details, please refer the [doc](https://openspiel.readthedocs.io/en/latest/julia.html)

For higher level APIs you may refer [ReinforcementLearningEnvironments.jl](https://github.com/JuliaReinforcementLearning/ReinforcementLearningEnvironments.jl).

# Installation Guidelines

## Linux:
## 1. Install Julia with specific version:
- To install latest stable version:
```
curl -fsSL https://install.julialang.org | sh
```
- To install long term support version:
```
sudo snap install julia --classic --channel=lts
```
Suggested to use LTS version to avoid errors with OpenSpiel.jl

## 2. Add OpenSpiel.jl wrapper to your Julia Repl:
- Open terminal and start a Julia terminal by running the executable
  
    ```
    julia
    ```
- Open Packages
  
  ```
  julia> ]
  ```
- Add the below command
  
  ```
  pkg> add https://github.com/JuliaReinforcementLearning/OpenSpiel.jl.git
  ```
- To test if it installed correctly run the below code in your Julia repl

  ```
  using OpenSpiel
  ```
  
