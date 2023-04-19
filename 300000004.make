# All-Things-Makefile-File
#

ifndef Dings_Day
$(error Error: Bash Variable "Dings_Day" not set)
endif

Md-File-List = $(wildcard *.md)
Html-File-List := $(subst .md,.html,$(Md-File-List)) index.html
Html-File-List := $(addprefix ${Dings_Day}/, $(Html-File-List))

define Markdown_to_Html
	pandoc --standalone --template 300000002.htm $(1) -o $(2)
	sed -i '' -E 's/(href="[0-9]+)\.md/\1\.html/g' $(2)
	sed -i '' -E 's#<body>#<body><pre class="console"><code>Warning: Although I give my very Best, Mistakes are still possible.</code></pre>#g' $(2)
endef

all: Git-Sub-Module-Init Html-Files
	echo "All-Things-Make-File:${Dings_Day}"

Html-Files: $(Html-File-List)

Git-Sub-Module-Init:
	git submodule update --init

## Web-Server-Directory-Index-Rule

${Dings_Day}/index.html: 300000006.md
	$(call Markdown_to_Html, $<, $@)

${Dings_Day}/%.html: %.md
	$(call Markdown_to_Html, $<, $@)

clean:
	rm -f $(Html-File-List)

.PHONY: all clean
