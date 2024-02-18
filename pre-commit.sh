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

if [[ "$@" =~ "-m" ]]; then
    # Find the index of the -m option
    index=$(expr $(echo "$@" | grep -b -o -m 1 "\-m" | cut -d: -f1) + 1)
    
    # Extract the commit message directly
    msg="${!index}"
else
    echo "Error: Please use the -m option to provide a commit message."
    exit 1
fi

echo "DEBUG: msg_file = $msg_file"
echo "DEBUG: msg = $msg"

if echo "$msg" | grep -E "^[[:space:]]*($(IFS="|"; echo "${pref[*]}"))[[:space:]]*:" >/dev/null 2>&1; then
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
    exit 1
fi
