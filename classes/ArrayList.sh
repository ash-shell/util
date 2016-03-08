#!/bin/bash

################################################################
################################################################
################################################################
# This class defines an ArrayList
#
# This class roughly follows the interface of a Java ArrayList,
# and shares the same goals.
#
# Statements followed by a "^" are quoted directly from the Java Docs:
# https://docs.oracle.com/javase/7/docs/api/java/util/ArrayList.html
################################################################
################################################################
################################################################

# Private member variable
ArrayList_array=()

################################################################
# Constructor
################################################################
ArrayList__construct(){
    : # Do nothing
}

################################################################
# if $2 is not passed:
# Appends the specified element to the end of this list. ^
#
# If $2 is passed:
# Inserts the specified element at the specified position in
# this list. ^
#
# @param $1: Element to be appended to this list ^
# @param [$2]: Position to append the element.  This value must
#   be an integer within (0 - ArrayList Size) inclusive.
################################################################
ArrayList__add(){
    local element="$1"
    local position="$2"
    local size="$(ArrayList__size)"

    # End of the array
    if [[ -z "$position" || "$position" = "$size" ]]; then
        ArrayList_array["$size"]="$element"

    # Position in the middle of the array
    elif [[ "$position" =~ ^[0-9]+$ && "$position" -le "$size" ]]; then
        local new_list=()
        local new_size=$((size+1))

        local counter=0
        while [  "$counter" -lt "$new_size" ]; do
            # Before the new value
            if [[ $counter -lt $position ]]; then
                local val=$(ArrayList__get $counter)
                new_list["$counter"]="$val"

            # The new value
            elif [[ $counter -eq $position ]]; then
                new_list["$counter"]="$element"

            # After the new value
            else
                local pos=$((counter-1))
                local val=$(ArrayList__get "$pos")
                new_list["$counter"]="$val"
            fi

            # Increment Counter
            let counter=counter+1
        done
        ArrayList_array=( "${new_list[@]}" )

    # Invalid position
    else
        Logger__error 'Error at ArrayList.add'
        Logger__error 'Position ($2) must be an integer between (0 - ArrayList Size) inclusive'
        exit
    fi
}

################################################################
# Returns the number of elements in this list. ^
#
# @returns: The number of elements in this list ^
################################################################
ArrayList__size(){
    echo ${#ArrayList_array[@]}
}

################################################################
# Returns the element at the specified position in this list. ^
#
# @1: The index of the element to return ^
################################################################
ArrayList__get(){
    echo ${ArrayList_array["$1"]}
}

################################################################
# Removes all of the elements from this list. The list will
# be empty after this call returns. ^
################################################################
ArrayList__clear(){
    ArrayList_array=()
}

################################################################
# Returns a deep copy of this ArrayList instance
# (The ArrayList and its elements are copied)
#
# Note: This is different than Javas ArrayList.clone(), which
# only does a shallow copy
#
# @param $1: The pre-allocated ArrayList to clone into
################################################################
ArrayList__clone(){
    local clone="$1"
    Obj__init $clone

    local size=$(ArrayList__size)
    local counter=0
    while [  $counter -lt $size ]; do
        val=$(ArrayList__get $counter)
        Obj__call $clone add "$val"
        # Update Counter
        let counter=counter+1
    done

    echo $clone
}

################################################################
# @returns the index of the first occurrence of the
# specified element in this list, or -1 if this list
# does not contain the element. ^
################################################################
ArrayList__index_of() {
    # Loop over array to find index
    local size=$(ArrayList__size)
    local counter=0
    while [  $counter -lt $size ]; do
        local val=$(ArrayList__get $counter)
        if [[ $val = $1 ]]; then
            echo $counter
            return
        fi

        # Update Counter
        let counter=counter+1
    done

    # Nothing was Found
    echo "-1"
}

################################################################
# @returns A simple JSON string representing this ArrayList
################################################################
ArrayList__to_string() {
    printf "[ "
    local size=$(ArrayList__size)
    local counter=0
    while [  $counter -lt $size ]; do
        local val=$(ArrayList__get $counter)
        printf "$val"
        if [[ $counter -lt $size-1 ]]; then
            printf ", "
        else
            printf " "
        fi
        let counter=counter+1
    done
    printf "]"
}
