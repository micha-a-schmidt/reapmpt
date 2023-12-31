#!/bin/sh

#################################################################################################
# The package `REAP' is written for Mathematica 7 and is distributed under the
# terms of GNU Public License http://www.gnu.org/copyleft/gpl.html.
#################################################################################################
MATHEMATICA=~/.Mathematica; 
if [[ `grep -s Linux /proc/sys/kernel/ostype` ]]; then MATHEMATICA=~/.Mathematica; 
elif [[ $VENDOR == apple ]]; then MATHEMATICA=~/Library/Mathematica;
elif [ `cat /proc/sys/kernel/ostype |grep darwin` ]; then MATHEMATICA=~/Library/Mathematica;else echo; echo "As we have not been able to determine the operating system, we assume that Mathematica expects its files in the directory $MATHEMATICA" ; echo; fi;

MATHAPP=$MATHEMATICA/Applications;
REAP=$MATHAPP/REAP;

if [ $1 ]; then REAPDOC="$1"; else REAPDOC=".."; fi;

echo;
echo;
echo "The packages REAP are written for Mathematica 7 and are distributed under the terms of GNU Public License http://www.gnu.org/copyleft/gpl.html .";
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
if ! [ -d $MATHAPP ]; then install -d $MATHAPP; fi;

# check dirs of REAP
if [ -e $REAP ]; then
    echo "There already is a file which is called $REAP. The file is moved to $REAP.old";
    echo;
    if [ -e $REAP.old ]; then rm -rf $REAP.old; fi;
    mv $REAP $REAP.old;
fi;
if ! [ -d $REAP ]; then mkdir $REAP; fi;

echo "...done";

echo;
echo "Copying the Mathematica packages to $REAP ...";
cp -a REAP/* $REAP;
echo "...and the notebooks and documentation to $REAPDOC .";
cp -a Doc/* $REAPDOC;
echo;

echo;
echo "Make sure that you also install MixingParameterTools.";
echo;

exit 0
