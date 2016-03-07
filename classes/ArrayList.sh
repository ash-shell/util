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
# Appends the specified element to the end of this list. ^
#
# @1: Element to be appended to this list ^
################################################################
ArrayList__add(){
    ArrayList_array[$(ArrayList__size)]="$1"
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
        val=$(ArrayList__get $counter)
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
        val=$(ArrayList__get $counter)
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
