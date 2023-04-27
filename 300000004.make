# All_Things_Makefile_File
#

ifndef Dings_Day
$(error Error: Bash Variable "Dings_Day" not set)
endif

Md_File_List = $(wildcard *.md)
Html_File_List := $(subst .md,.html,$(Md_File_List)) index.html
Html_File_List := $(addprefix ${Dings_Day}/, $(Html_File_List))

define Markdown_to_Html
	pandoc --standalone --template 300000002.htm $(1) -o $(2)
	sed -i '' -E 's/(href="[0-9]+)\.md/\1\.html/g' $(2)
	sed -i '' -E 's#<body>#<body><pre class="console"><code>Warning: Although I give my very Best, Mistakes are still possible.</code></pre>#g' $(2)
endef

all: Git_Sub_Module_Init Html_Files
	echo "All_Things_Make_File:${Dings_Day}"

Html_Files: $(Dings_Day) $(Html_File_List)

Git_Sub_Module_Init:
	git submodule update --init

$(Dings_Day):
	mkdir $(Dings_Day)

## Web_Server_Directory_Index_Rule

${Dings_Day}/index.html: 300000006.md
	$(call Markdown_to_Html, $<, $@)

${Dings_Day}/%.html: %.md 300000004.make 300000013.css 300000002.htm
	$(call Markdown_to_Html, $<, $@)

clean:
	rm -f $(Html_File_List)

.PHONY: all clean
