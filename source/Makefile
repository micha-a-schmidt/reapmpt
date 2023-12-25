# Generic make file for LaTeX: requires GNU make

MATHLIB=RGESolver.m RGEMSSM.m RGEMSSM0N.m RGEMSSMTriplet.m RGEMSSMTriplet0N.m RGESM.m RGESM0N.m RGESMTriplet.m RGESMTriplet0N.m RGEUtilities.m RGEFusaoka.m RGEInitial.m RGEParameters.m RGESymbol.m RGEMSSMDirac.m RGESMDirac.m RGEToyModel.m RGE2HDM.m RGE2HDM0N.m RGE2HDMDirac.m RGEPlotUtilities.m RGELRDoublet.m RGETakagi.m

INCOUTPUT=RGEOutput.cxml

INCFUNCTION=RGEFunctions.cxml

INC=$(INCFUNCTION) $(INCOUTPUT) RGESolver.cxml RGEUtilities.cxml RGEFusaoka.cxml RGEInitial.cxml RGEParameters.cxml RGEModelInitial.cxml RGEModelOptions.cxml RGETakagi.cxml


SCRIPT = ../script
OUTPUT = ../Packages
INSTALL_DIR = ~/.Mathematica/Applications/REAP

%.m:	%.math $(INC) $(SCRIPT)/math2m.pl
	$(SCRIPT)/math2m.pl $< > $(<:.math=.m)	

.PHONY: all
all: mathlib install

.PHONY: clean
clean:	
	rm -f *.m

.PHONY: mrproper
mrproper:	
	rm -f *.m

.PHONY: mathlib
mathlib: $(MATHLIB)

.PHONY: install
install: $(MATHLIB)
	if ! [ -d $(OUTPUT) ]; then install -d $(OUTPUT); fi;
	cp -a $(MATHLIB) $(OUTPUT);
#	if ! [ -d $(INSTALL_DIR) ]; then install -d $(INSTALL_DIR); fi;
#	cp -a $(MATHLIB) $(INSTALL_DIR);
