#!/usr/bin/perl

#################################################################################################
# The package `REAP' is written for Mathematica 7 and is distributed under the
# terms of GNU Public License http://www.gnu.org/copyleft/gpl.html
#################################################################################################




#use strict;

my $latex=shift @ARGV;
$latex=~/(.*)\.tex/;

my $log="$1.log";
my $bib=$1;
my $undefref=1;
my $LOOP=0;
system latex, $latex;

while ($undefref && $LOOP<3) {
	print "-----------------------\n Run $LOOP because of undefined references.\n-------------------\n\n";
	open(LOG,$log);
	while(<LOG>) {
		if  (! /There were undefined references/) {
			$undefref= 0;
			last; 
		};

	};
	close(LOG);
	
	$LOOP++;
	system bibtex, $bib;
	system latex, $latex;
	system latex, $latex;
};

$undefref=1;
$LOOP=0;
while ($undefref && $LOOP<3) {
	print "-----------------------\n Run $LOOP because of cross-references.\n-------------------\n\n";
	open(LOG,$log);
	while(<LOG>) {
		if ( ! /Rerun to get cross-references right/) { 
			$undefref= 0;
			last; 
		};

	};
	close(LOG);
	
	$LOOP++;
	system latex, $latex;
};
