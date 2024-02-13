#!/bin/bash
#Author Name: Tarun Adhikari
#Publish Date: Feb 11, 2024
#Last Updated: Feb 12, 2024

#Master branch name hardcoded.
main="main"
git checkout $main
git pull origin $main
prefix="origin/"

file="$1"
if [ -s "$file" ];
then
	echo "List of branches:"
	while read -r line;
  	do
    		echo "$line"
	done < "$file"
else
	git branch -r
fi

#Creation of a array for valid branches only!
branches_array=()
echo "Validating from remote branches...."
for i in $(git branch -r);
do
	branch="${i#$prefix}"
	if grep -q -e "$branch" "$file";
        then
		echo "Branch $branch found in remote"
		branches_array+=("$branch")
	fi
done

read -p "Check for updates?(yes/no):" flag
case $flag in
	"yes")	
		echo "Checking for updates in valid branches...."
        	for branch in "${branches_array[@]}";
        	do
			echo "Checking branch: $branch"
            		git checkout "$branch" 2>/dev/null
      			upstream=$(git rev-parse --abbrev-ref --symbolic-full-name "$branch@{upstream}" 2>/dev/null)
      			if [ -n "$upstream" ]; then
        			if git merge-base --is-ancestor "$upstream" "$branch"; then
					echo "========================="
        			else
					echo "========================="
        			fi
      			else
        			echo "The branch '$branch' doesn't have any commits ahead."
      			fi
    		done
	;;
	"no")
		echo "Exiting now."
		exit
	;;
	*)
		echo "Wrong input. Exiting!"
	;;
esac

read -p "Want to continue merge into main(yes/no):" chk
case $chk in
	"yes")
		for branch in "${branches_array[@]}";
		do
			echo "Merging branch $branch"
			git checkout $main
			git merge -X theirs -m "Merging branch $branch in main" $branch
			sleep 5
		done
		;;
	"no")
		echo "Exiting!"
		exit
		;;
	*)
		echo "Wrong Input! Exiting!"
		exit
		;;
esac
