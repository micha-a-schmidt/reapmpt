# Generic make file for LaTeX: requires GNU make

#FILE = get-pdf
#TEXFILE = ${FILE}.tex
#.PHONY:	dvi ps pdf clean

#pdf:	$(TEXFILE:.tex=.pdf)
#ps:	$(TEXFILE:.tex=.ps)
#dvi:	$(TEXFILE:.tex=.dvi)
#bib:	$(TEXFILE:.tex=.bib)

OUTPUT = ../Packages
SCRIPT = ../script
SOURCE = ../source
CXML = $(SOURCE)/RGEParameters.cxml  $(SOURCE)/RGEFusaoka.cxml  $(SOURCE)/RGESolver.cxml  $(SOURCE)/RGEInitial.cxml  $(SOURCE)/RGEUtilities.cxml $(SOURCE)/RGEModelInitial.cxml $(SOURCE)/RGEModelOptions.cxml $(SOURCE)/RGEOutput.cxml 
DOC= RGEDocumentation.ps.gz RGEUsersGuide.ps.gz RGEInternalDoc.ps.gz RGEDocumentation.pdf RGEUsersGuide.pdf RGEInternalDoc.pdf
INCLUDES = RGEDocPreamble.tex RGEHowTo.tex RGEInstallation.tex RGENewModelHowTo.tex RGEIntroduction.tex RGEFAQ.tex RGELicense.tex $(CXML) RGEReference.cmtex RGEModels.cmtex


.PHONY: all
all: doc

.PHONY: clean
clean:	
	rm -f *.aux *.blg *.bbl *.log *.out *.dvi *.ps *.glo *.idx *.toc *.thm RGEUsersGuide.tex RGEDocumentation.tex RGEInternalDoc.tex

.PHONY: mrproper
mrproper:	
	rm -f *.aux *.blg *.bbl *.log *.out *.pdf *.dvi *.ps *.ps.gz *.glo *.idx *.toc *.thm RGEUsersGuide.tex RGEDocumentation.tex RGEInternalDoc.tex

.PHONY: doc
doc: $(DOC)

.PHONY: install
install: $(DOC)
	cp -a $(DOC) $(OUTPUT)

RGEDocumentation.dvi: RGEDocumentation.tex $(INCLUDES) $(SCRIPT)/tex2dvi.pl
	perl $(SCRIPT)/tex2dvi.pl $<

RGEUsersGuide.dvi: RGEUsersGuide.tex $(INCLUDES) $(SCRIPT)/tex2dvi.pl
	perl $(SCRIPT)/tex2dvi.pl $<

%.tex:	%.ctex $(INCLUDES) $(SCRIPT)/ctex2tex.pl
	perl $(SCRIPT)/ctex2tex.pl $< > $(<:.ctex=.tex)

%.dvi:	%.tex $(SCRIPT)/tex2dvi.pl
	perl $(SCRIPT)/tex2dvi.pl $<

#	( \
#	latex $<; \
#	LAUF=0; \
#	while [ `grep -q "There were undefined references." $(<:.tex=.log)`!="" && LAUF<3  ]; \
#	do \
#		LAUF++; \
#		bibtex $(<:.tex=); \
#		latex $<; \
#		latex $<; \
#	done; \
#	LAUF=0;
#	while [ `grep -q "Rerun to get cross-references right." $(<:.tex=.log)`!=""  &&  LAUF<3 ]; \
#	do \
#		LOOP++; \
#		latex $<; \
#	done \
#	)
%.bib:	%.dvi
	bibtex $<

%.ps:	%.dvi
	\dvips -q -t a4 $<

%.ps.gz:%.ps
	\gzip -cnf $< > $(<:.ps=.ps.gz)

%.pdf:	%.ps
	\ps2pdf -dPDFSETTINGS=/prepress $<

# %.pdf:	%.tex
# 	pdflatex $<
