
PAPERNAME=paper
TEXFILES=*.tex
BIBFILES=*.bib


$(PAPERNAME).pdf: $(TEXFILES) $(BIBFILES)

	pdflatex paper
	bibtex --min-crossrefs=100 paper
	pdflatex paper
	pdflatex paper

fastcompile:
	latex paper
	dvips -Ppdf -G0 -t letter -o $(PAPERNAME).ps paper
	ps2pdf -dCompatibilityLevel=1.3 $(PAPERNAME).ps

.PHONY: figs clean


gv: $(PAPERNAME).ps
	gv $(PAPERNAME).ps &

tar:
	tar -cvzf $(PAPERNAME).taz *.tex *.bib *.fig *.eps *.bst *.perl makefile

clean:
	rm -f $(PAPERNAME).ps $(PAPERNAME).pdf *.dvi *.aux *.log *.blg *.bbl *.eps *.out *~ figs/*-converted-to.pdf *.synctex.gz
