#!/bin/bash
#Author Name: Tarun Adhikari
#Publish Date: Feb 11, 2024
#Last Updated: Feb 13, 2024

#Master branch name hardcoded.
main="main"
git checkout $main
git pull

branches_array=()
while getopts ":f:b:" opt;
do
	case $opt in
	f)
		file="$OPTARG"
		for i in $(git branch -r);
		do
			prefix="origin/"
        		branch="${i#$prefix}"
        		if grep -q -e "$branch" "$file";
        		then
                		echo "Branch $branch found in remote"
                		branches_array+=("$branch")
        		fi
		done
		;;
	b)
		branch="$OPTARG"
		echo -e ${OPTARG}|sed "s/,/,\\n/g"
		IFS=, read -ra barr <<<"${branch}"
		echo "$barr[@]"
		for i in $(git branch -r);
		do
			prefix="origin/"
                        branch="${i#$prefix}"
			if printf '%s\0' "$barr[@]" | grep -qwz -e $branch
			then
				branches_array+=("$branch")
			fi
		done
		;;
	*)
		echo "Remote branches:"
		git branch -r
		echo "==================================================="
		echo "Usage: [-f file_name}] [-b branches(csv)]"
		exit 1
		;;
	esac
done


#Printing branches!
echo "Valid branches...."
for branch in "${branches_array[@]}";
do
	echo "Branch: $branch"
done

read -p "Want to continue merge into main(yes/no):" chk
case $chk in
	"yes")
		for branch in "${branches_array[@]}";
		do
			echo "Merging branch $branch"
			git checkout $branch
			git merge -X ours -m "Merging content from main into $branch" $main
			git push
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
