#!/bin/bash

if [ $# -lt 3 ]; then
	echo "Program is called as such: '$0 [Path to Folder to Destroy] [Number of Options Per Layer] [Number of Layers of Folders]'."
fi

if [ "$1" == "" ]; then
	echo "Must pass in a path for a folder to destroy."
	exit 1
fi

if [[ "$2" == "" || $(($2)) != "$2" ]]; then
	echo "Must pass in how many folders the seeker must look through per layer."
	exit 1
fi

if [[ "$3" == "" || $(($3)) != "$3" ]]; then
	echo "Must pass in a depth for how many folders or layers deep the destroyed folder will be."
	exit 1
fi

# Parameters are 1: depth remaining, 2: number of options per layer, 3: folder to go inside of and add options
createRandomOptions() {
	if [ $(($1)) -le 0 ]; then
		return 0
	fi
	cd "$3" || exit
	directories=()
	while [ "$(find . -maxdepth 1 | wc -l)" -lt $(($2)) ]; do
		newDirectory=$(env LC_CTYPE=C tr -cd 'a-f0-9' < /dev/urandom | head -c 16)
		mkdir "$newDirectory"
		directories+=( "$newDirectory" )
	done
	for directory in "${directories[@]}"; do
		createRandomOptions $(($1 - 1)) "$2" "$directory"
	done
	cd ..
}

mkdir DestroyedFolder
createRandomOptions "$3" "$2" "DestroyedFolder"

cd DestroyedFolder || exit
for ((i=0; i < $3; i++)); do
	dirs=(*/)
	cd -- "${dirs[RANDOM%${#dirs[@]}]}" || exit
done
pathToHideDestroyedFolder=$(pwd)
for ((i=0; i <= $3; i++)); do
	cd ..
done

mv "$1" "$pathToHideDestroyedFolder"

readmeLocation="./DestroyedFolder/README.txt"
touch $readmeLocation
echo -e "Hello dear victim.\nYou have become the target of a folder destruction attack. Your original folder has been hidden inside this maze of randomly named folders.\nEach folder will lead to another layer of folders with $2 options of folders, each of which lead to another layer with another $2 options of folders. This is repeated for a total of $3 layers.\nYour original folder is hidden past the last layer of one random path of these folders.\nGood luck, comrade." > "$readmeLocation"

tar -czf DestroyedFolder.tar.gz ./DestroyedFolder
rm -rf ./DestroyedFolder
