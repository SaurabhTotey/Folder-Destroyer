#!/bin/bash

if [ $# -lt 3 ]; then
	echo "Program is called as such: '$0 [Path to Folder to Destroy] [Number of Options Per Layer] [Number of Layers of Folders]'."
fi

if [ "$1" == "" ]; then
	echo "Must pass in a path for a folder to destroy.";
	exit 1;
fi

if [ "$2" == "" ]; then #TODO: check that $2 is an int
	echo "Must pass in how many folders the seeker must look through per layer.";
	exit 1;
fi

if [ "$3" == "" ]; then #TODO: check that $3 is an int
	echo "Must pass in a depth for how many folders or layers deep the destroyed folder will be.";
	exit 1;
fi

# Parameters are 1: depth remaining, 2: number of options per layer, 3: folder to go inside of and destroy
createRandomOptions() {
	if [ $(($1)) -le 0 ]; then
		return 0
	fi
	eval "cd $3"
	while [ $(ls -1 | wc -l) -lt $(($2)) ]
	do
		eval "mkdir $(cat /dev/urandom | env LC_CTYPE=C tr -cd 'a-f0-9' | head -c 16)"
	done
	#TODO: call createRandomOptions for all of the created folders and decrement $1 which is the depth remaining
	eval "cd .."
}

eval "mkdir DestroyedFolder"
createRandomOptions $3 $2 "DestroyedFolder"

eval "cd DestroyedFolder"
for i in {1 .. $(($3))}
do
	eval "shopt -s nullglob"
	dirs=(*/)
	[[ $dirs ]] && cd -- "${dirs[RANDOM%${#dirs[@]}]}"
done

#TODO: move folder to destroy to current location

#TODO: compress DestroyedFolder
