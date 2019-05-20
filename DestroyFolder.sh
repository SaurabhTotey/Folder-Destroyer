#!/bin/bash

if [ $# -lt 4 ]; then
	echo "Program is called as such: '$0 [Path to Folder to Destroy] [Number of Options Per Layer] [Number of Layers of Folders]'."
fi

if [ "$1" == "" ]; then
	echo "Must pass in a path for a folder to destroy.";
	exit 1;
fi

if [ "$2" == "" ]; then
	echo "Must pass in how many folders the seeker must look through per layer.";
	exit 1;
fi

if [ "$3" == "" ]; then
	echo "Must pass in a depth for how many folders or layers deep the destroyed folder will be.";
	exit 1;
fi
