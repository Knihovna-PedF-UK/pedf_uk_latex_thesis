pkgname = pedfukthesis
doc_name = ${pkgname}-doc
doc_source = ${doc_name}.tex
doc_file = ${doc_name}.pdf

ifeq ($(strip $(shell git rev-parse --is-inside-work-tree 2>/dev/null)),true)
	VERSION:= $(shell git --no-pager describe --abbrev=0 --tags --always )
	DATE:= $(firstword $(shell git --no-pager show --date=format:'%d. %m. %Y' --name-only))
endif


all: doc

doc: ${doc_file}

${doc_file}: ${doc_source}
	latexmk -pdf -pdflatex='lualatex "\def\version{${VERSION}}\def\gitdate{${DATE}}\input{%S}"' $<	
