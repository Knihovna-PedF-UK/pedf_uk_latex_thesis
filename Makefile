pkgname = pedfukthesis
doc_name = ${pkgname}-doc
doc_source = ${doc_name}.tex
doc_file = ${doc_name}.pdf
example_dir = example
basic_example_src = ${example_dir}/basic.tex

ifeq ($(strip $(shell git rev-parse --is-inside-work-tree 2>/dev/null)),true)
	VERSION:= $(shell git --no-pager describe --abbrev=0 --tags --always )
	DATE:= $(firstword $(shell git --no-pager show --date=short --format="%ad" --name-only))
endif


all: doc

doc: ${doc_file}

${doc_file}: ${doc_source} ${basic_example_src} 
	latexmk -pdf -pdflatex='lualatex -shell-escape "\def\version{${VERSION}}\def\gitdate{${DATE}}\input{%S}"' $<	
