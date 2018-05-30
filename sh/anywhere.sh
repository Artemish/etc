#!/bin/bash

anywhere() {
    if [ "$#" -ne 2 ]; then
        echo "Usage: $0 <command> <filename>" 2>&1 
        return 
    fi

    declare -a choices
    IFS=$'\n' choices=($(locate "$2" | egrep --color=never "$2\$"))

    if [ ${#choices} -eq 1 ]; then
        choice="${choices[1]}"
    elif [ ${#choices} -eq 0 ]; then
        echo "No matches found for '$2'. exiting" 2>&1
        return 1
    else
        for (( i = 1; i <= $#choices; i++ )) do
            printf "[%d] %s\n" $i "${choices[$i]}"
        done
        printf "Choice: "
        read -r number
        choice="${choices[$number]}"
    fi

    echo "Running $1 $choice"
    echo 

    "$1" "$choice"
}
