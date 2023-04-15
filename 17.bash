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

function Generate()
{
	Generate_Md > 17.markdown	
}

Generate
