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

#TODO: below only generates folders for a single path
eval "mkdir DestroyedFolder"
eval "cd DestroyedFolder"
for i in {1 .. $(($3))}
do
	while [ $(ls -1 | wc -l) -lt $(($2)) ]
	do
		eval "mkdir $(cat /dev/urandom | env LC_CTYPE=C tr -cd 'a-f0-9' | head -c 32)"
	done
	eval "shopt -s nullglob"
	dirs=(*/)
	[[ $dirs ]] && cd -- "${dirs[RANDOM%${#dirs[@]}]}"
done
