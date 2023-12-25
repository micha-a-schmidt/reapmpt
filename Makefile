DOC = doc
SOURCE = source
NOTEBOOKS = Notebooks
SCRIPT = script
PACKAGE = REAP

SUBDIRS = source doc
OUTPUT = Packages
USERNOTEBOOKS = RGEPlots.nb RGEHowTo.nb RGETemplate.nb
USERDOC = RGEDocumentation.ps.gz RGEUsersGuide.ps.gz
USERDOCPDF = RGEDocumentation.pdf RGEUsersGuide.pdf
MPT = MixingParameterTools
PACKAGE_DIRNAME = REAP_incl_MPT
PACKAGE_NAME = REAP_incl_MPT-`cat RGEVersion`
PACKAGEREAP = REAP-`cat RGEVersion`
REAPdoc=REAP-Documentation-`cat RGEVersion`.pdf
REAPUserdoc=REAP-UserGuide-`cat RGEVersion`.pdf

.PHONY: package
package: subdirs script/selfextract.sh script/install.sh script/makeself.sh
	if ! [ -d $(PACKAGE)Install/$(PACKAGE) ]; then install -d $(PACKAGE)Install/$(PACKAGE); fi; \
	if ! [ -d $(PACKAGE)Install/Doc/$(PACKAGE)/Notebooks ]; then install -d $(PACKAGE)Install/Doc/$(PACKAGE)/Notebooks; fi; \
	cp -a ChangeLog $(PACKAGE)Install/Doc/$(PACKAGE); \
	cp -a $(OUTPUT)/* $(PACKAGE)Install/$(PACKAGE); \
	cp -a $(DOC)/RGEDocumentation.pdf $(REAPdoc) && cp -a $(DOC)/RGEUsersGuide.pdf $(REAPUserdoc) && cp -a $(REAPdoc) $(REAPUserdoc) $(PACKAGE)Install/Doc/$(PACKAGE); \
	cd $(NOTEBOOKS); cp -a $(USERNOTEBOOKS) ../$(PACKAGE)Install/Doc/$(PACKAGE)/Notebooks; cd ..; \
	cp -a $(SCRIPT)/install.$(PACKAGE).sh $(PACKAGE)Install/install.sh; \
	tar -cvzf $(PACKAGEREAP).tar.gz $(PACKAGE)Install; \
	script/makeself.sh $(PACKAGE)Install $(PACKAGEREAP).installer.sh $(PACKAGEREAP) ./install.sh; \
	mv $(PACKAGE)Install $(PACKAGE_DIRNAME)Install; \
	if ! [ -d $(PACKAGE_DIRNAME)Install/Doc/MixingParameterTools ]; then mkdir $(PACKAGE_DIRNAME)Install/Doc/MixingParameterTools; fi; \
	if ! [ -d $(PACKAGE_DIRNAME)Install/Doc/MixingParameterTools/Notebooks ]; then mkdir $(PACKAGE_DIRNAME)Install/Doc/MixingParameterTools/Notebooks; fi; \
	if ! [ -d $(PACKAGE_DIRNAME)Install/MixingParameterTools ]; then mkdir $(PACKAGE_DIRNAME)Install/MixingParameterTools; fi; \
	$(MAKE) -C $(MPT); \
	cp -a $(MPT)/MPT3x3.m $(PACKAGE_DIRNAME)Install/MixingParameterTools; \
	cp -a $(MPT)/MPT-Documentation-1.1.pdf $(PACKAGE_DIRNAME)Install/Doc/MixingParameterTools; \
	cp -a $(MPT)/MPT-Documentation-1.1.pdf .; \
	cp -a $(SCRIPT)/install.sh $(PACKAGE_DIRNAME)Install/install.sh; \
	cp -a $(MPT)/MPT-1.1.installer.sh $(MPT)/MPT-1.1.tar.gz .; \
	tar -cvzf $(PACKAGE_NAME).tar.gz $(PACKAGE_DIRNAME)Install; \
	script/makeself.sh $(PACKAGE_DIRNAME)Install $(PACKAGE_NAME).installer.sh $(PACKAGE_NAME) ./install.sh; \
	rm -rf $(PACKAGE_DIRNAME)Install; \
	tar -czvf web-install-`cat RGEVersion`.tar.gz *.pdf $(PACKAGEREAP).installer.sh $(PACKAGEREAP).tar.gz $(PACKAGE_NAME).installer.sh $(PACKAGE_NAME).tar.gz MPT-1.1.installer.sh MPT-1.1.tar.gz; 



.PHONY: subdirs $(SUBDIRS)

subdirs: $(SUBDIRS) script/tex2dvi.pl script/math2m.pl script/ctex2tex.pl

$(SUBDIRS):
	$(MAKE) -C $@


.PHONY: clean
clean:
	$(MAKE) -C $(SOURCE) clean && $(MAKE) -C $(DOC) clean && if [ -d $(PACKAGE) ]; then rm -rf $(PACKAGE); fi;

.PHONY: mrproper
mrproper:
	$(MAKE) -C $(SOURCE) mrproper && $(MAKE) -C $(DOC) mrproper; \
	if [ -d $(OUTPUT) ]; then rm -rf $(OUTPUT); fi; \
	if [ -d $(PACKAGE_DIRNAME)Install ]; then rm -rf $(PACKAGE_DIRNAME)Install; fi; \
	if [ -d $(PACKAGE)Install ]; then rm -rf $(PACKAGE)Install; fi; \
	rm -rf $(PACKAGE_NAME).tar.gz $(PACKAGE_NAME).installer.sh $(PACKAGEREAP).tar.gz $(PACKAGEREAP).installer.sh;



# alternative rule to clean Packages:
# cd $(OUTPUT) && rm `echo *|sed -e 's/CVS//'` -rf


