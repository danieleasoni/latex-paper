MAIN := paper
FIGS := figs
SECTIONS := sections
SETUPFILES := extrapackages.tex macrosetup.tex
CLSFILE :=
STYFILES :=

LATEX := pdflatex
BIBTEX := bibtex
RM := rm -f
LATEXFLAGS :=
BIBTEXFLAGS := "--min-crossrefs=100"

TEXFILES := $(wildcard $(MAIN).tex $(SETUPFILES) $(SECTIONS)/*.tex)
BIBFILES := $(wildcard *.bib)
FIGFILES := $(wildcard $(FIGS)/*.eps $(FIGS)/*.png $(FIGS)/*.jpg $(FIGS)/*.pdf)

SVN_REV := $(shell ./print_svn_revision.sh)
MAIN_WITH_OPT := "\def\svnrevisionnumber{$(SVN_REV)} \input{$(MAIN).tex}"


all: $(MAIN).pdf
.PHONY: clean all force


$(MAIN).pdf: $(TEXFILES) $(BIBFILES) $(FIGFILES) $(CLSFILE) $(STYFILES)
	$(LATEX) $(LATEXFLAGS) -jobname=$(MAIN) $(MAIN_WITH_OPT)
	$(BIBTEX) $(BIBTEXFLAGS) paper
	$(LATEX) $(LATEXFLAGS) -jobname=$(MAIN) $(MAIN_WITH_OPT)
	$(LATEX) $(LATEXFLAGS) -jobname=$(MAIN) $(MAIN_WITH_OPT)

clean:
	-$(RM) $(MAIN).pdf *.aux *.log *.blg *.bbl *.out *~ $(FIGS)/*-converted-to.pdf *.synctex.gz

force:
	make -B
