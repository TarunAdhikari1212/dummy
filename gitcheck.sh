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
		# branch="$OPTARG"
		# IFS=, read -ra br_arr <<<"$branch"
		# for branch in "${br_arr[@]}"
		# do
		# 	for i in $(git branch -r)
		# 	do
		# 		prefix="origin/"
        #                 	br="${i#$prefix}"
		# 		if [ "$branch" -eq "$br" ]; then
		# 			branches_array+=("$branch")
		# 		fi
		# 	done
		# done
		# ;;
		branch="$OPTARG"
		bar=$(echo ${OPTARG}|sed "s/,/,\n/g")
		set -f
        	IFS=,
		for i in $(bar);
		do
			for j in $(git branch -r);
			do
				if [ $i == $j ]; then
					branches_array+=("$i")
				fi
			done
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


#Printing valid branches only!
echo "Valid branches...."
for branch in "${branches_array[@]}";
do
	echo "Branch: $branch"
done

exit
read -p "Want to continue merge into main(yes/no):" chk
case $chk in
	"yes")
		for branch in "${branches_array[@]}";
		do
			echo "Merging branch $branch"
			git checkout $branch
			git merge -X ours -m "Merging content from main into $branch" $branch
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
