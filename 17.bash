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
	local Old_Tag;

	for Git_Sub_Module in $(git submodule | awk '{print $2}')
	do
		>&2 echo "Updating: $Git_Sub_Module"

		Old_Tag=$(git tag -l | grep $Tag)
		cd $Git_Sub_Module
		git pull origin Master
		git checkout Master
		git pull --rebase
	
		if [ "$Old_Tag" != "" ]; then
			git tag -d $Tag
		fi
		git push origin :refs/tags/$Tag
		git tag $Tag
		git push --tags;
		cd ..
		git add $Git_Sub_Module
	done
	git commit -m "Update Sub-Modules"
}

function Generate_All_Dings()
{
	echo "Generating All-Dings ..."
	Generate_Md > 17.markdown	
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
	Generate_All_Dings
}

Render $1
