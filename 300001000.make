# Rendering-Makefile
#

## Git-Sub-Module Number-Files

Number_File_List += $(wildcard 0/*.*)
Number_File_List += $(wildcard 888/*.*)
Number_File_List += $(wildcard 1000001000/*.*)
Number_File_List += $(wildcard 140100000/*.*)
Number_File_List += $(wildcard 1997080300/*.*)
Number_File_List += $(wildcard 250000000/*.*)
Number_File_List += $(wildcard 260010000/*.*)

## Git-Sub-Module Number-Files without leading Directory

Number_File_List_Local := $(notdir $(Number_File_List))
Number_File_List_Local := $(filter-out README.md,$(Number_File_List_Local))

## All-Rule

all: Sub_Module_Init Create_Hard_Links

## Create Hard-Links for all Number-Files

Create_Hard_Links: $(Number_File_List_Local)

## Initialize Sub-Modules

Sub_Module_Init:
	git submodule update --init --recursive

## Generate HTML-Files

html:
	make -f 300000004.make

## Create-Hard-Link-Rule

%: */%
	ln  $< $@

## Clean-Rule

clean:
	make -f 300000004.make clean
	rm -f $(Number_File_List_Local)

.PHONY: all clean
