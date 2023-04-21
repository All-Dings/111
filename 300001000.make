# Rendering_Makefile
#

## Git_Sub_Module Number_Files

Number_File_List += $(wildcard 0/*.*)
Number_File_List += $(wildcard 888/*.*)
Number_File_List += $(wildcard 2000001/*.*)
Number_File_List += $(wildcard 1000001000/*.*)
Number_File_List += $(wildcard 140100000/*.*)
Number_File_List += $(wildcard 1997080300/*.*)
Number_File_List += $(wildcard 250000000/*.*)
Number_File_List += $(wildcard 260010000/*.*)

## Git_Sub_Module Number_Files without leading Directory

Number_File_List_Local := $(notdir $(Number_File_List))
Number_File_List_Local := $(filter_out README.md,$(Number_File_List_Local))
Number_File_List_Local := $(filter_out Makefile,$(Number_File_List_Local))

## All_Rule

All: Sub_Module_Init Html

## Create Hard_Links for all Number_Files

Create_Hard_Links: $(Number_File_List_Local)

## Initialize Sub_Modules

Sub_Module_Init:
	git submodule update --init --recursive
	make -f 300001000.make Create_Hard_Links

## Generate HTML_Files

Html: Create_Hard_Links
	make -f 300000004.make

## Create_Hard_Link_Rule

%: */%
	ln -f $< $@

## Clean_Rule

Clean:
	make -f 300000004.make clean
	rm -f $(Number_File_List_Local)

.PHONY: All Clean
