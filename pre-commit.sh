#!/bin/bash
#Author Name: Tarun Adhikari
#Publish Date: Feb 16, 2024
#Last Updated: Feb 16, 2024

declare -a pref=(
    [0]=add
    [1]=update
    [2]=remove
    [3]=refactor
    [4]=bug-fix
    [5]=document
)

msg=$(git log -1 --pretty=%B)

if echo "$commit_message" | grep -E "^[[:space:]]*($(IFS="|"; echo "${pref[*]}"))[[:space:]]*:" >/dev/null 2>&1; then
    echo "Correct message format......."
    echo "Committing your changes"
    git commit -m "$msg"
else
    echo "Warning: Wrong commit message format"
    echo "Allowed prefixes list:-"
    for i in ${pref[@]}
    do
        echo $i
    done
fi
