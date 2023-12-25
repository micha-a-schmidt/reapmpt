#!/usr/bin/perl

#################################################################################################
# The package `REAP' is written for Mathematica 7 and is distributed under the
# terms of GNU Public License http://www.gnu.org/copyleft/gpl.html
#################################################################################################




use strict;

my $file=shift @ARGV;


sub process($$) {
    my $code=shift @_;
    my $tag=shift @_;
    our $level;
    our %optiondata;
    my $match;
    if ($level=~/$optiondata{"level"}/) {$match=1} else {$match=0};
    if ($tag eq "PERL") {
	if( $match ) {
	    eval $code;
	    warn $@ if $@;
	};
    } elsif ($tag eq "REMOVE") {
	if (!$match ) {
		print $code;
	    };
    } elsif ($tag eq "INCLUDE") {
	if ($match ) {
	    local *INCLUDE;
	    open(INCLUDE,$code);
	    while(<INCLUDE>) {print $_;};
	    close(INCLUDE);
	};
    } else {
	print "An error occured: $tag does not exist.";
    };
};
sub parse($) {
    my $file=shift(@_);
    my $code="";  # these variables are used only in process
    my $reading=0;
    my $tag="";
    our %optiondata;
    my $remain;
    my $options;
    my @tokens;
    my $key;
    my $value;
    our $tag;
    local *FILE;
    open(FILE,$file);

    while(<FILE>) {
        if($reading&&/(.*)\<\/$tag\>(.*)/) {
	    $code.=$1;
	    $remain=$2;
	    $reading=0;
#					       print "(* inserting output of \n$code\n ... *)\n";
	    process($code,$tag);
#					       print "(* ... end of insertion *)\n";
	    $code="";
	    $tag="";
	    print $remain;
	}
	
	elsif(!$reading&&/(.*)\<(\w*)\s*?(.*?)\>(.*)/) {
	    print $1;
	    $options=$3;
	    $code=$4;
	    $tag=$2;
	    chomp($tag);

	    @tokens=split(/\ /,$options);
	    $optiondata{"level"}=".*";
	    foreach (@tokens) { ($key,$value)=split (/=/,$_);
				$optiondata{$key}=$value;
			    };
	    if ($code=~/(.*)\<\/$tag\>(.*)/) {
		$code=$1;
		$remain=$2;
		process($code,$tag);
		$tag="";
		$code="";
		
		print $remain;
	    } else {
	    $reading=1;
	};
	}
	
	
	
# reading code between tags
	elsif($reading) {$code.=$_;}
# otherwise	
	else {print};
    };
    close(FILE);
};

    
sub RegisterModel($\%\%) {
    my $name=shift(@_);
    my $outref=shift(@_);
    my $transref=shift(@_);
    
    my $key;
    my $value;
    my $lauf;
    print "(* register $name *)\n";
    print "RGERegisterModel[\"$name\",\"REAP`RGE$name`\",
	`Private`GetParameters,
        `Private`SolveModel,
        {";
    $lauf=0;
    while (($key,$value)=each %$outref) { if ($lauf) {print ",";}; $lauf++;print "$key->`Private`$value"};
    print "},\n{";
    $lauf=0;
    while (($key,$value)=each %$transref) { if ($lauf) {print ",";}; $lauf++; print "{\"$key\",`Private`$value}"};
    print "},
        `Private`GetInitial,
        `Private`ModelSetOptions,
        `Private`ModelGetOptions
         ];\n";
};

sub OutputFunctions($$\%) {
    my $model=shift @_;
    my $file=shift @_;
    my $outref=shift @_;
    my $key;
    my $value;
    my %functiondata=();
    my %codedata=();
    my $code;
    my $function="";
    my $reading=0;
    my $options;
    my @tokens;
    my $match=0;
    my $find=0;
    local *FILE;
    open(FILE,$file);
    while(<FILE>) {
#	s/\#.*//;
	if(/\<function(.*?)\>(.*)/) { $options=$1;$function.=$2; $reading=1; }
	elsif($reading&&/(.*)\<\/function\>/) {$function.=$1;$reading=0;
					       @tokens=split(/\ /,$options);
					       foreach (@tokens) { ($key,$value)=split (/=/,$_);
								 $functiondata{$key}=$value;
							       };
					       $find=0;
					       foreach $value (values(%$outref)) { if ($value eq $functiondata{'name'}) { $find=1;}};
#					       if (values(%$outref)=~/$functiondata{"name"}/) {
					       if ($find) {
						   while ($function=~/\<code(.*?)\>(.*?)\<\/code\>/gs) {
						   @tokens=split(/\ /,$1);
						   $code=$2;
						   foreach (@tokens) { ($key,$value)=split (/=/,$_);
								       $codedata{$key}="$value";
								   };
						   
						   @tokens=split(/,/,$codedata{"model"});
						   $match=0;
						   foreach (@tokens) {
						       if($model=~/^$_$/) {
							   if (!$match) {
							       print "ClearAll[$functiondata{'name'}];",$code,"\n";
							       $match=1;

							   } else { print "(* there is already a function $functiondata{'name'} *)\n";
								};
						       };
						   };
					       };
					       } else {print "(* $functiondata{'name'} is not a function of $model *)\n";
						   };
					       $function="";
					   }
	elsif($reading) {$function.=$_};
    };
    close(FILE);
};


sub GetSymbols {
    my $file;
    my $key;
    my $value;
    my %functiondata=();
    my $function="";
    my $reading=0;
    my $options;
    my @tokens;
    my @RGEsymbols=();
    my @files=@_;
    my $nomatch=0;
    foreach (@files) {
	my $file=$_;
	print "(* Symbols in $file *)\n";
	local *FILE;
	open(FILE,$file);
	while(<FILE>) { 
	    if(/\<function(.*?)\>(.*)/) { $options=$1;$function.=$2; $reading=1; }
	    elsif($reading&&/(.*)\<\/function\>/) {$function.=$1;$reading=0;
						   @tokens=split(/\ /,$options);
						   foreach (@tokens) { ($key,$value)=split (/=/,$_);
								       $functiondata{$key}=$value;
								   };
						   $nomatch=1;
						   foreach (@RGEsymbols) { if($functiondata{'name'} eq $_) {$nomatch=0;};};
						   if ($nomatch) { push(@RGEsymbols,$functiondata{'name'});};
					       }
	    elsif($reading) {$function.=$_};
	};
	close(FILE);
    };
    foreach(sort(@RGEsymbols)){ $key=$_;print "ClearAll[$key]; $key; Protect[$key];\n";};
};

sub Functions($$) {
    my $model=shift @_;
    my $file=shift @_;
    my $key;
    my $value;
    my %functiondata=();
    my %codedata=();
    my $code;
    my $function="";
    my $reading=0;
    my $options;
    my @tokens;
    my $match=0;
    local *FILE;
    open(FILE,$file);
    while(<FILE>) {
#	s/\#.*//;
	if(/\<function(.*?)\>(.*)/) { $options=$1;$function.=$2; $reading=1; }
	elsif($reading&&/(.*)\<\/function\>/) {$function.=$1;$reading=0;
					       @tokens=split(/\ /,$options);
					       foreach (@tokens) { ($key,$value)=split (/=/,$_);
								   $functiondata{$key}=$value;
							       };
					       while ($function=~/\<code(.*?)\>(.*?)\<\/code\>/gs) {
						   @tokens=split(/\ /,$1);
						   $code=$2;
						   foreach (@tokens) { ($key,$value)=split (/=/,$_);
								       $codedata{$key}="$value";
								   };
						   
						   @tokens=split(/,/,$codedata{"model"});
						   $match=0;
						   foreach (@tokens) {
						       if($model=~/^$_$/) {
							   if (!$match) {
							       if ($functiondata{'name'} ne "Definitions") {print "ClearAll[$functiondata{'name'}];";};
							       print $code,"\n";
							       $match=1;
							       
							   } else { print "(* there is already a function $functiondata{'name'} *)\n";
								};
						       };
						   };
					       };
					       $function="";
					   }
	elsif($reading) {$function.=$_};
    };
    close(FILE);
};


sub Package($$) {
    my $file=shift @_;
    my $loadPackages=shift @_;
    my $key;
    my $value;
    my %functiondata=();
    my @functions;
    my $code;
    my $function="";
    my $reading=0;
    my $options;
    my @tokens;
    my $private="";
    my $public="";
    local *FILE;
    open(FILE,$file);
    while(<FILE>) {
#	s/\#.*//;
	if(/\<function(.*?)\>(.*)/) { $options=$1;$function.=$2; $reading=1; }
	elsif($reading&&/(.*)\<\/function\>/) {$function.=$1;$reading=0;
					       @tokens=split(/\ /,$options);
					       foreach (@tokens) { ($key,$value)=split (/=/,$_);
								   $functiondata{$key}=$value;
							       };
					       $function=~/\<head\>(.*?)\<\/head\>/gs;
					       $code=$1;
					       if ($functiondata{'name'} eq "Definitions") {
						   $public=$code.$public;
					       } else {
						   $public=$public."ClearAll[$functiondata{'name'}];\n$code\n\n";
						   push @functions, $functiondata{'name'};
					       };
					       $function=~/\<code\>(.*?)\<\/code\>/gs;
					       $private=$private.$1."\n";
					       $function="";
					   }
	elsif($reading) {$function.=$_};
    };
    print $public;
    print "\n Begin[\"`Private`\"];\n";
    if ($loadPackages ne "") {
	print "\n Map[Needs,";
	print $loadPackages;
	print "];";
    };
    print $private;
    print "\n End[];\n\n Protect[";
    $function=shift @functions;
    print $function;
    foreach (@functions) {print ",",$_; };
    print "];\n\n EndPackage[];";					    
    close(FILE);
};

parse($file);

exit; 
