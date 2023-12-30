
INDEX_DOCS	:= $(wildcard HarmonyOwnersManual.md)
SOURCE_DOCS := $(wildcard *.md)
SOURCE_DOCS := $(filter-out README.md metadata.md, $(SOURCE_DOCS))

space := $() $()
escapews = $(subst $(space),+,$1)
unescapews = $(subst +,$(space),$1)
IMAGES = $(call escapews,$(wildcard *.png))

PANDOC_DOCS := $(INDEX_DOCS:.md=.pmd)

EXPORTED_DOCS=\
 $(SOURCE_DOCS:.md=.html) \
 $(SOURCE_DOCS:.md=.pdf) \
 $(SOURCE_DOCS:.md=.docx) \
 $(SOURCE_DOCS:.md=.rtf) \
 $(SOURCE_DOCS:.md=.odt) \
 $(SOURCE_DOCS:.md=.epub)

PDF_DOCS=\
 $(INDEX_DOCS:.md=.pdf)

define PANDOC_CMD
	docker run --rm --volume "`pwd`:/data" --user `id -u`:`id -g` dcoon/pandoc
endef
define PANDOC_OPTIONS
		-f markdown \
		--filter pandoc-include \
    --table-of-contents \
    --number-sections \
    --indented-code-classes='bash,numberLines html,numberLines javascript,numberLines go,numberLines' \
    --highlight-style=monochrome \
    -V fontsize="10pt" \
    -V documentclass=report \
    -V papersize=A5 \
    -V linestretch='0.85' \
    -V geometry:margin=0.5in \
    -V links-as-notes=true \
		-H disable_float.tex \
    --metadata-file=metadata.md
endef

PANDOC_HTML_OPTIONS=--to html5
PANDOC_PDF_OPTIONS=
PANDOC_DOCX_OPTIONS=
PANDOC_RTF_OPTIONS=
PANDOC_ODT_OPTIONS=
PANDOC_EPUB_OPTIONS=--to epub3

# Pattern-matching Rules

%.pdf : %.pmd
	 $(PANDOC_CMD) -s $< $(PANDOC_OPTIONS) $(PANDOC_PDF_OPTIONS) -o $@ 


# convert obsidian to pandoc markdown files

%.pmd : %.md
	-sed \
		-e 's/.*\[\[\(.*\)\]\]/\n!include\ \1.md\n/g' \
		 $< > $@

		# -e 's/\!\[\[\(.*\)\]\][ \t]*\(.*\)/\!\[\2\]\(\1\)\{width\=90\%\}/g' \

pdf : $(PDF_DOCS) 

# all : $(EXPORTED_DOCS)

clean:
	-rm -f $(EXPORTED_DOCS)
	-rm -f $(PANDOC_DOCS)

.PHONY: clean

debug : $(PDF_DOCS)
	-echo $(PDF_DOCS)
	-echo $(IMAGES)
