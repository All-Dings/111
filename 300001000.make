# Rendering-Makefile
#

## Git-Sub-Module Number-Files

Number_File_List += $(wildcard 0/*.*)
Number_File_List += $(wildcard 888/*.*)

## Git-Sub-Module Number-Files without leading Directory

Number_File_List_Local := $(notdir $(Number_File_List))
Number_File_List_Local := $(filter-out README.md,$(Number_File_List_Local))

## All-Rule

all: $(Number_File_List_Local)

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
