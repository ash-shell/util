#!/bin/bash

#################################################
# This is simply here to test out implementations
#
# You can run `ash util` to run this
#################################################
Util__callable_main(){
    Logger__alert 'Creating $cats ArrayList:'
    local cats=$(Obj__alloc "ArrayList")
    Obj__init $cats
    echo "$(Obj__call $cats to_string)"

    Logger__alert 'Adding cats to $cats...'
    Obj__call $cats add "Rigby"
    Obj__call $cats add "Norbert"
    Obj__call $cats add "Diggersby"
    echo "$(Obj__call $cats to_string)"

    Logger__alert 'Size of $cats:'
    echo "$(Obj__call $cats size)"

    Logger__alert 'Cats at positions:'
    echo "0: $(Obj__call $cats get 0)"
    echo "1: $(Obj__call $cats get 1)"

    Logger__alert '$cats to_string:'
    echo "$(Obj__call $cats to_string)"

    Logger__alert 'Index of value "Norbert":'
    echo "Index of Norbert: $(Obj__call $cats index_of "Norbert")"

    Logger__alert "Clearing:"
    Obj__call $cats clear
    echo "$(Obj__call $cats to_string)"

    Logger__alert "Adding More Cats!"
    Obj__call $cats add "Fuzzy"
    Obj__call $cats add "Ginger"
    echo "$(Obj__call $cats to_string)"

    Logger__alert 'Cloning our $cats array to $dogs'
    local dogs=$(Obj__alloc "ArrayList")
    Obj__call $cats clone $dogs

    Logger__alert 'Adding Roofus to dogs:'
    Obj__call $dogs add "Roofus"
    echo "Cats: $(Obj__call $cats to_string)"
    echo "Dogs: $(Obj__call $dogs to_string)"

    Logger__alert 'Adding Dogby to dogs at [0]'
    Obj__call $dogs add "Dogby" "0"
    echo "Dogs: $(Obj__call $dogs to_string)"

    Logger__alert 'Adding Droopy to dogs at [3]'
    Obj__call $dogs add "Droopy" "3"
    echo "Dogs: $(Obj__call $dogs to_string)"

    Logger__alert 'Checking if dogs contains Droopy'
    local contains_droopy=$(Obj__call $dogs contains "Droopy")
    echo "Dogs contains Droopy: $contains_droopy"

    Logger__alert 'Checking if cats contains Droopy'
    local contains_droopy=$(Obj__call $cats contains "Droopy")
    echo "Cats contains Droopy: $contains_droopy"
}
