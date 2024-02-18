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

# if [ -n "$1" ]; then
#     msg="$1"
#     echo "$msg"
# else
#     msg_file=".git/COMMIT_EDITMSG"
#     msg=$(cat "$msg_file")
# fi

if [ -n "$COMMIT_MSG" ]; then
    msg="$COMMIT_MSG"
else
    echo "Error: No commit message provided."
    exit 1
fi

echo "DEBUG: msg = $msg"

# if echo "$msg" | grep -E "^[[:space:]]*($(IFS="|"; echo "${pref[*]}"))[[:space:]]*:" >/dev/null 2>&1; then
if echo "$msg" | grep -E "\b(?:add|update|remove|refactor|bug-fix|document updated|Added|Test|bug-Fix):" >/dev/null 2>&1; then
    echo "Correct message format......."
    echo "Committing your changes"
else
    echo "Warning: Wrong commit message format"
    echo "Allowed prefixes list:-"
    for i in ${pref[@]}
    do
        echo $i
    done
    exit 1
fi
