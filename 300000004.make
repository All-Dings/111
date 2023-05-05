# All_Things_Makefile_File
#

## Work-Dir
Work_Dir := Work-Dir

## Git_Sub_Module Number_Files

Number_File_List += $(wildcard 0/*.*)
Number_File_List += $(wildcard 888/*.*)
Number_File_List += $(wildcard 2000001/*.*)
Number_File_List += $(wildcard 1000001000/*.*)
Number_File_List += $(wildcard 140100000/*.*)
Number_File_List += $(wildcard 1997080300/*.*)
Number_File_List += $(wildcard 250000000/*.*)
Number_File_List += $(wildcard 260010000/*.*)
Number_File_List += $(wildcard 400000000/*.*)
Number_File_List += $(wildcard ./*.*)

## Git_Sub_Module Number_Files without leading Directory

Number_File_List_Local := $(notdir $(Number_File_List))
Number_File_List_Local := $(filter-out README.md,$(Number_File_List_Local))
Number_File_List_Local := $(filter-out Makefile,$(Number_File_List_Local))
Number_File_List_Local := $(addprefix $(Work_Dir)/, $(Number_File_List_Local))

# Soft-Link List

Soft_Link_List := \
	${Work_Dir}/Dings_Lib.py \
	${Work_Dir}/dings \
	${Work_Dir}/Dockerfile

## All_Rule

all: $(Work_Dir) $(Number_File_List_Local) ${Soft_Link_List}

## Create Work-Dir

$(Work_Dir):
	if [ ! -d $(Work_Dir) ] ; then mkdir $(Work_Dir) ; fi

${Work_Dir}/Dings_Lib.py: ${Work_Dir}/300010010.py
	cd ${Work_Dir}; ln -s 300010010.py Dings_Lib.py
${Work_Dir}/dings: ${Work_Dir}/300020002.pl
	cd ${Work_Dir}; printf "%s\n%s %s%s\n" '#!/bin/bash' 'python3 300020001.py' "$$" '@' > dings; chmod a+x dings
${Work_Dir}/Dockerfile: ${Work_Dir}/18.dockerfile
	cd ${Work_Dir}; ln -s 18.dockerfile Dockerfile

## Generate Hard-Links

$(Work_Dir)/%: 0/%
	ln -f $< $@
$(Work_Dir)/%: 888/%
	ln -f $< $@
$(Work_Dir)/%: 2000001/%
	ln -f $< $@
$(Work_Dir)/%: 1000001000/%
	ln -f $< $@
$(Work_Dir)/%: 140100000/%
	ln -f $< $@
$(Work_Dir)/%: 1997080300/%
	ln -f $< $@
$(Work_Dir)/%: 250000000/%
	ln -f $< $@
$(Work_Dir)/%: 260010000/%
	ln -f $< $@
$(Work_Dir)/%: 400000000/%
	ln -f $< $@
$(Work_Dir)/%: ./%
	ln -f $< $@

## Clean_Rule

clean:
	rm -f $(Number_File_List_Local) $(Soft_Link_List)

.PHONY: all clean
