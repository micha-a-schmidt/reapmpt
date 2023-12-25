#!/bin/sh

#################################################################################################
# The package `REAP' is written for Mathematica 5 and is distributed under the
# terms of GNU Public License http://www.gnu.org/copyleft/gpl.html.
#################################################################################################

MATHEMATICA=~/.Mathematica;
MATHAPP=$MATHEMATICA/Applications;
MPT=$MATHAPP/MixingParameterTools;

if [ $1 ]; then REAPDOC="$1"; else REAPDOC=".."; fi;

echo;
echo;
echo "The package MixingParameterTools is written for Mathematica 5 and is distributed under the terms of GNU Public License http://www.gnu.org/copyleft/gpl.html .";
echo;
echo;

echo "Checking, whether all directories exist...";
# check dirs for Doc
#if [ -e $REAPDOC ]; then
#    echo "There already is a file which is called $REAPDOC. The file is moved to $REAPDOC.old";
#    echo;
#    if [ -e $REAPDOC.old ]; then rm -rf $REAPDOC.old; fi;
#    mv $REAPDOC $REAPDOC.old;
#fi;
#if ! [ -d $REAPDOC ]; then mkdir $REAPDOC; fi;

# check dirs in Mathematica dir
if ! [ -d $MATHEMATICA ]; then mkdir $MATHEMATICA; fi;
if ! [ -d $MATHAPP ]; then mkdir $MATHAPP; fi;

# check dirs of MPT
if [ -e $MPT ]; then
    echo "There already is a file which is called $MPT. The file is moved to $MPT.old";
    echo;
    if [ -e $MPT.old ]; then rm -rf $MPT.old; fi;
    mv $MPT $MPT.old;
fi;
if ! [ -d $MPT ]; then mkdir $MPT; fi;

echo "...done";

echo;
echo "Copying the Mathematica packages to $MPT...";
cp -a MixingParameterTools/* $MPT;
echo "...and the notebooks and documentation to $REAPDOC .";
cp -a Doc/* $REAPDOC;
echo;

exit 0
