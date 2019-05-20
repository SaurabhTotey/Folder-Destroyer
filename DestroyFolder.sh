#!/bin/bash

if [ "$1" == "" ]; then
	echo "Must pass in a path for a folder to destroy";
	exit 1;
fi

if [ "$2" == "" ]; then
	echo "Must pass in how many options the seeker must look through";
	exit 1;
fi

if [ "$3" == "" ]; then
	echo "Must pass in a depth for how many folders deep the destroyed folder will be";
	exit 1;
fi
