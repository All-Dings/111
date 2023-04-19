#!/bin/bash
#
# Gerate function
#

source 16.bash


function Ls_Names_Md()
{
	local name file

	mwLsNames | while read name;
	do
		file=$(mwName2File "$name")
		
		printf -- "- [%s](%s)\n" "$name" "$file"
	done
}

function Generate_Md()
{
	printf "# List of all Things\n"
	printf "\n"
	Ls_Names_Md
	printf "\n"
	printf "Generated: $(date)"
}

function Update_Sub_Modules()
{
	local Tag=$1

	for Git_Sub_Module in $(git submodule | awk '{print $2}')
	do
		>&2 echo "Updating: $Git_Sub_Module"

		cd $Git_Sub_Module
		git pull origin Master
		git checkout Master
		git pull --rebase
	
		git tag -d $Tag
		git push --delete origin $Tag
		# git push origin :refs/tags/$Tag
		git tag $Tag
		git push --tags;
		cd ..
		git add $Git_Sub_Module
	done
	git commit -m "Update Sub-Modules"
}

function Generate_Dings()
{
	echo "Generating All-Dings ..."
	Generate_Md > 17.md
}

function Generate_Dings_Fast_And_Good()
{
	local Dings_File="17.md"

	echo "# Dings-File" > $Dings_File
	echo >>  $Dings_File
	cat 0.txt | (while read -r Line; do echo $Line | sed -E 's#([0-9]+)\.(md|jpg|mp3)[ ]+(.*)#[\3](\1.\2)#g'; done) >> $Dings_File
}


function Render
{
	local Tag=$1

	if [ "$Tag" == "" ]; then
		>&2 echo "Usage 17.bash DAY-TAG"
		exit 1
	fi
	Update_Sub_Modules $Tag
	make -f 300001000.make Create_Hard_Links
	Generate_Dings_Fast_And_Good
}

Render $1
