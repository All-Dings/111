# Rendering_Makefile
#

ifndef Dings_Day
$(error Error: Bash Variable "Dings_Day" not set)
endif

## Work_Dir
Work_Dir := Work-Dir

Md_File_List   := $(wildcard ${Work_Dir}/*.md)
Md_File_List   := $(notdir $(Md_File_List))
Html_File_List := $(subst .md,.html,$(Md_File_List))
Html_File_List := $(addprefix ${Dings_Day}/, $(Html_File_List))

Jpg_File_List  := $(wildcard ${Work_Dir}/*.jpg)
Jpg_File_List  := $(notdir $(Jpg_File_List))
Jpg_File_List  := $(filter-out 0.jpg,$(Jpg_File_List)) # LFS-Problem
Jpg_File_List  := $(filter-out 8.jpg,$(Jpg_File_List)) # LFS-Problem
Jpg_File_List  := $(addprefix ${Dings_Day}/, $(Jpg_File_List))

Target_File_List := \
	${Html_File_List} \
	${Jpg_File_List} \
	${Dings_Day}/index.html \
	${Dings_Day}/300000014.css

define Markdown_to_Html
	pandoc --standalone --template ${Work_Dir}/300000002.htm $(1) -o $(2)
	sed -i '' -E 's/(href="[0-9]+)\.md/\1\.html/g' $(2)
	sed -i '' -E 's#<body>#<body><pre class="console"><code>Warning: Although I give my very Best, Mistakes are still possible.</code></pre>#g' $(2)
endef

define Render_Jpg_File
	magick convert $(1) -resize 800 -quality 80 $(2)
endef

all:
	$(info For rendering all Dings do the following:)
	$(info )
	$(info $$ export Dings_Day=Day-XX)
	$(info $$ make workdir)
	$(info $$ make render)
	$(info )

workdir:
	make -f 300000004.make

render: ${Dings_Day} ${Target_File_List}

$(Dings_Day):
	mkdir $(Dings_Day)

## Web_Server_Directory_Index_Rule

${Dings_Day}/index.html: ${Work_Dir}/300000006.md
	$(call Markdown_to_Html, $<, $@)

# CSS-File

${Dings_Day}/300000014.css: ${Work_Dir}/300000014.css
	cp $< $@

${Dings_Day}/%.html: ${Work_Dir}/%.md
	$(call Markdown_to_Html, $<, $@)

${Dings_Day}/%.jpg: ${Work_Dir}/%.jpg
	$(call Render_Jpg_File, $<, $@)

clean:
	make -f 300000004.make clean
	rm -rf ${Target_File_List}

.PHONY: all clean
