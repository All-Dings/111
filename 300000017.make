# # Dings-Generate-Make-File

# The Dings-Generate-Make-File is a [Make-File](9000159.md).

# ## Python-Files
Python_File_List := $(wildcard *.py)
Python_File_List := $(filter-out Dings_Lib.py,$(Python_File_List))
Python_File_List := $(subst .py,.md,$(Python_File_List))

# ## Perl-Files
Perl_File_List := $(wildcard *.pl)
Perl_File_List := $(subst .pl,.md,$(Perl_File_List))

# ## Css-Files
Css_File_List := $(wildcard *.css)
Css_File_List := $(subst .css,.md,$(Css_File_List))

Generate_File_List := \
	${Python_File_List} \
	${Perl_File_List} \
	${Css_File_List} \

all: ${Generate_File_List}

# ## Generation-Rules
%.md: %.py
	./dings generate $<
%.md: %.pl
	./dings generate $<
%.md: %.css
	./dings generate $<

clean:
	rm -f ${Generate_File_List}

