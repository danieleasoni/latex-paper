
PAPERNAME := paper
FIGS := figs
SECTIONS := sections
SETUPFILES := extrapackages.tex macrosetup.tex
CLSFILE :=
STYFILES :=

TEXFILES := $(wildcard $(PAPERNAME).tex $(SETUPFILES) $(SECTIONS)/*.tex)
BIBFILES := $(wildcard *.bib)
FIGFILES := $(wildcard $(FIGS)/*.eps $(FIGS)/*.png $(FIGS)/*.jpg)


all: $(PAPERNAME).pdf
.PHONY: figs clean


$(PAPERNAME).pdf: $(TEXFILES) $(BIBFILES) $(FIGFILES) $(CLSFILE) $(STYFILES)
	pdflatex paper
	bibtex --min-crossrefs=100 paper
	pdflatex paper
	pdflatex paper

clean:
	-rm -f $(PAPERNAME).pdf *.aux *.log *.blg *.bbl *.out *~ $(FIGS)/*-converted-to.pdf *.synctex.gz
