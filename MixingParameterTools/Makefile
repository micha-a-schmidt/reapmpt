USERDOC = MPTdoc_p.ps.gz MPTdoc_p.pdf
DOC = MPTDocumentation.ps.gz MPTDocumentation.pdf

PACKAGE = MixingParameterTools
PACKAGE_MATH = ~/.Mathematica/Applications/MixingParameterTools

SCRIPT = .

.PHONY: package
package: $(USERDOC) $(DOC) install.sh selfextract.sh
	if ! [ -d $(PACKAGE_MATH) ]; then mkdir $(PACKAGE_MATH); fi; \
	cp -a MPT3x3.m $(PACKAGE_MATH); \
	if ! [ -d $(PACKAGE)Install ]; then mkdir $(PACKAGE)Install; fi; \
	if ! [ -d $(PACKAGE)Install/$(PACKAGE) ]; then mkdir $(PACKAGE)Install/$(PACKAGE); fi; \
	if ! [ -d $(PACKAGE)Install/Doc ]; then mkdir $(PACKAGE)Install/Doc; fi; \
	if ! [ -d $(PACKAGE)Install/Doc/MixingParameterTools ]; then mkdir $(PACKAGE)Install/Doc/MixingParameterTools; fi; \
	if ! [ -d $(PACKAGE)Install/Doc/MixingParameterTools/ps ]; then mkdir $(PACKAGE)Install/Doc/MixingParameterTools/ps; fi; \
	if ! [ -d $(PACKAGE)Install/Doc/MixingParameterTools/pdf ]; then mkdir $(PACKAGE)Install/Doc/MixingParameterTools/pdf; fi; \
	if ! [ -d $(PACKAGE)Install/Doc/MixingParameterTools/Notebooks ]; then mkdir $(PACKAGE)Install/Doc/MixingParameterTools/Notebooks; fi; \
	cp -a MPT3x3.m $(PACKAGE)Install/MixingParameterTools; \
	cp -a MPTdoc_p.ps.gz $(PACKAGE)Install/Doc/MixingParameterTools/ps; \
	cp -a MPTdoc_p.pdf $(PACKAGE)Install/Doc/MixingParameterTools/pdf; \
	cp -a MPTQuickStart.nb $(PACKAGE)Install/Doc/MixingParameterTools/Notebooks; \
	cp -a MPTdoc_p.ps.gz MPTdoc_p.pdf $(WWW)/doc; \
	cp -a install.sh $(PACKAGE)Install/install.sh; \
	tar -cvzf $(PACKAGE).tar.gz $(PACKAGE)Install; \
        makeself $(PACKAGE)Install $(PACKAGE).installer $(PACKAGE) ./install.sh; \
	rm -rf $(PACKAGE)Install;
#	cp -ab $(PACKAGE).tar.gz $(PACKAGE).installer $(WWW)/download; \
#	cat selfextract.sh $(PACKAGE).tar.gz > $(PACKAGE).installer; \
#	chmod 755 $(PACKAGE).installer; \

.PHONY: clean
clean:
	if [ -d $(PACKAGE)Install ]; then rm -rf $(PACKAGE)Install; fi; \
	rm -rf $(PACKAGE).tar.gz $(PACKAGE).installer; \
	rm -f *.aux *.blg *.bbl *.log *.out *.dvi *.ps *.pdf *.ps.gz *.glo *.idx *.toc *.thm;

%.dvi:	%.tex 
	perl $(SCRIPT)/tex2dvi.pl $<

%.ps:	%.dvi
	\dvips -q -t a4 $<

%.ps.gz:%.ps
	\gzip -cnf $< > $(<:.ps=.ps.gz)

%.pdf:	%.ps
	\ps2pdf -dPDFSETTINGS=/prepress $<



# alternative rule to clean Packages:
# cd $(OUTPUT) && rm `echo *|sed -e 's/CVS//'` -rf


