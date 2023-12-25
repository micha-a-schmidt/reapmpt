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
sub parse {
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
		$code.=$1;
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

sub SimpleDoc($) {
    my $file=shift @_;
    my $model=0;
    my $key;
    my $value;
    my %functiondata=();
    my %codedata=();
    my $code;
    my $function="";
    my $reading=0;
    my $options;
    my @tokens;
    my $fname;
    my %doc;
    my $repl;
    my $match;
    local *FILE;
    open(FILE,$file);
    while(<FILE>) {
	if(/\<function(.*?)\>(.*)/) { $options=$1;$function.=$2; $reading=1; }
	elsif($reading&&/(.*)\<\/function\>/) {$function.=$1;$reading=0;
					       @tokens=split(/\ /,$options);
					       foreach (@tokens) { ($key,$value)=split (/=/,$_);
								   $functiondata{$key}=$value;
					       };
					       while ($function=~/\<doc(.*?)\>(.*?)\<\/doc\>/gs) {
						   @tokens=split(/\ /,$1);
						   $code=$2;
						   $codedata{"model"}=".*";
						   foreach (@tokens) { ($key,$value)=split (/=/,$_);
								       $codedata{$key}="$value";
								   };
						   if(! $model && $model=~/$codedata{"model"}/ && "simple"=~/$codedata{"level"}/) {
							   $code=~s/\<implementation\>.*\<\/implementation\>//gs;
#						       $code=~s/\<\/implementation\>//gs;
							   $code=~s/\<example\>//gs;
							   $code=~s/\<\/example\>//gs;
							   $fname=$functiondata{'name'};
							   while($fname=~/\\\[(\w*)\]/gs){
							       $match=$1;
							       if($match=~/Capital(\w*)/) {
								   $repl=$1; 
							       } else {
								   $repl=lc($match);
							       };
							       $fname=~s/\\\[$match\]/\$\\$repl\$/gs;
							   };
#						       $doc{$functiondata{'name'}}="\\subsubsection{".$fname."}\n".$code."\n";
							   chomp($code);
							   $doc{$functiondata{'name'}}.=$code;
							   
						       };
						   };
					       $function="";
					   }
	elsif($reading) {$function.=$_};
    };
    foreach (sort(keys(%doc))) {
	   $fname=$_;
           while($fname=~/\\\[(\w*)\]/gs){
	       $match=$1;
	       $repl=lc($1);
	       $fname=~s/\\\[$match\]/\$\\$repl\$/gs;
	   };
	   print "\\subsubsection{".$fname."}\n".$doc{$_}."\n\n";};
};


sub AdvancedDoc($) {
    my $file=shift @_;
    my $model=shift @_;
    my $key;
    my $value;
    my %functiondata=();
    my %codedata=();
    my $code;
    my $function="";
    my $reading=0;
    my $options;
    my @tokens;
    my $fname;
    my %doc;
    my $repl;
    my $match;
    local *FILE;
    open(FILE,$file);
    while(<FILE>) {
	if(/\<function(.*?)\>(.*)/) { $options=$1;$function.=$2; $reading=1; }
	elsif($reading&&/(.*)\<\/function\>/) {$function.=$1;$reading=0;
					       @tokens=split(/\ /,$options);
					       foreach (@tokens) { ($key,$value)=split (/=/,$_);
								   $functiondata{$key}=$value;
							       };
					       while ($function=~/\<doc(.*?)\>(.*?)\<\/doc\>/gs) {
						   @tokens=split(/\ /,$1);
						   $code=$2;
#						   print $code;
						   $codedata{"model"}=".*";
						   foreach (@tokens) { ($key,$value)=split (/=/,$_);
								       $codedata{$key}="$value";
								   };
						   if(! $model && $model=~/$codedata{"model"}/&& "advanced simple"=~/$codedata{"level"}/) {
						       $code=~s/\<implementation\>.*\<\/implementation\>//gs;
#						       $code=~s/\<implementation\>/\\begin{implementation}/gs;
#						       $code=~s/\<\/implementation\>/\\end{implementation}/gs;
						       $code=~s/\<example\>//gs;
						       $code=~s/\<\/example\>//gs;
						       $fname=$functiondata{'name'};
						       while($fname=~/\\\[(\w*)\]/gs){
							   $match=$1;
							   if($match=~/Capital(\w*)/) {
							       $repl=$1; 
							   } else {
							       $repl=lc($match);
							   };
							   $fname=~s/\\\[$match\]/\$\\$repl\$/gs;
						       };
#						       $doc{$functiondata{'name'}}="\\subsubsection{".$fname."}\n".$code."\n";
						       chomp($code);
						       $doc{$functiondata{'name'}}.=$code;
						       

						   };
					       };
					       $function="";
					   }
	elsif($reading) {$function.=$_};
    };
    foreach (sort(keys(%doc))) {
	   $fname=$_;
           while($fname=~/\\\[(\w*)\]/gs){
	       $match=$1;
	       $repl=lc($1);
	       $fname=~s/\\\[$match\]/\$\\$repl\$/gs;
	   };
	   print "\\subsubsection{".$fname."}\n".$doc{$_}."\n\n";};
};

sub InternalDoc($) {
    my $file=shift @_;
    my $model=shift @_;
    my $key;
    my $value;
    my %functiondata=();
    my %codedata=();
    my $code;
    my $function="";
    my $reading=0;
    my $options;
    my @tokens;
    my $fname;
    my %doc;
    my $repl;
    my $match;
    local *FILE;
    open(FILE,$file);
    while(<FILE>) {
	if(/\<function(.*?)\>(.*)/) { $options=$1;$function.=$2; $reading=1; }
	elsif($reading&&/(.*)\<\/function\>/) {$function.=$1;$reading=0;
					       @tokens=split(/\ /,$options);
					       foreach (@tokens) { ($key,$value)=split (/=/,$_);
								   $functiondata{$key}=$value;
							       };
					       while ($function=~/\<doc(.*?)\>(.*?)\<\/doc\>/gs) {
						   @tokens=split(/\ /,$1);
						   $code=$2;
						   $codedata{"model"}=".*";
						   foreach (@tokens) { ($key,$value)=split (/=/,$_);
								       $codedata{$key}="$value";
								   };
						   
						   if(! $model && $model=~/$codedata{"model"}/&& "internal advanced simple"=~/$codedata{"level"}/) {
#						       $code="\internal{$code}";
#						   };
						   $code=~s/\<implementation\>/\\begin{implementation}/gs;
						   $code=~s/\<\/implementation\>/\\end{implementation}/gs;
						   $code=~s/\<example\>//gs;
						   $code=~s/\<\/example\>//gs;
#						       $doc{$functiondata{'name'}}="\\subsubsection{".$fname."}\n".$code."\n";
						       chomp($code);
						       $doc{$functiondata{'name'}}.=$code;

						   };
					       };
					       $function="";
					   }
    elsif($reading) {$function.=$_};
    };
    foreach (sort(keys(%doc))) {
	$fname=$_;
	while($fname=~/\\\[(\w*)\]/gs){
	    $match=$1;
	    if($match=~/Capital(\w*)/) {
		$repl=$1; 
	    } else {
		$repl=lc($match);
	    };
	    $fname=~s/\\\[$match\]/\$\\$repl\$/gs;
	};
	print "\\subsubsection{".$fname."}\n".$doc{$_}."\n\n";};
};

sub Doc($$) {
    my $argdata=shift @_;
    my $loclevel=shift @_;
#    print "XXXXX".$loclevel;
    if ($loclevel=~/internal/) {InternalDoc($argdata);}
    elsif ($loclevel=~/advanced/) { AdvancedDoc($argdata);}
    elsif ($loclevel=~/simple/) { SimpleDoc($argdata);}
    else { print "$loclevel is not a valid name for the level of documentation";};
};
			 
sub ModelDoc($$$) {
    my $file=shift @_;
    my $model=shift @_;
    my $maxlevel=shift @_;
    my $level="";
    if ($maxlevel=~/internal/) {$level="simple advanced internal";}
    elsif ($maxlevel=~/advanced/) { $level="simple advanced";}
    elsif ($maxlevel=~/simple/) { $level="simple";}
    else { print "$maxlevel is not a valid name for the level of documentation";};
    my $key;
    my $value;
    my %functiondata=();
    my %codedata=();
    my $code;
    my $function="";
    my $reading=0;
    my $options;
    my @tokens;
    my $fname;
    my %doc;
    my $repl;
    my $match;
    local *FILE;
    open(FILE,$file);
    while(<FILE>) {
	if(/\<function(.*?)\>(.*)/) { $options=$1;$function.=$2; $reading=1; }
	elsif($reading&&/(.*)\<\/function\>/) {$function.=$1;$reading=0;
					       @tokens=split(/\ /,$options);
					       foreach (@tokens) { ($key,$value)=split (/=/,$_);
								   $functiondata{$key}=$value;
							       };

					       while ($function=~/\<doc(.*?)\>(.*?)\<\/doc\>/gs) {
						   @tokens=split(/\ /,$1);
#						   print "$1\n";
						   $code=$2;
						   $codedata{"model"}=".*";
						   foreach (@tokens) { ($key,$value)=split (/=/,$_);
								       $codedata{$key}="$value";
								   };
						   
						   if($model && $model=~/$codedata{"model"}/ && $level=~/$codedata{"level"}/) {
						       $fname=$functiondata{'name'};
						       while($fname=~/\\\[(\w*)\]/gs){
							   $match=$1;
							   if($match=~/Capital(\w*)/) {
							       $repl=$1; 
							   } else {
							       $repl=lc($match);
							   };
							   $fname=~s/\\\[$match\]/\$\\$repl\$/gs;
						       };

						       chomp($code);
						       $code=~s/^\n*(.*)/$1/gs;
						       $doc{$functiondata{'name'}}.=$code;
							   
						       };
						   };
					       $function="";
					   }
	elsif($reading) {$function.=$_};
    };
# Suchalgorithmus
#{ my $mya=$a; my $myb=$b;
# $mya=s/curly|capital|\\|[|]//;
# $myb=s/curly|capital|\\|[|]//;
# $mya cmp $myb }    
    print "\\begin{itemize}\n";
    foreach (sort(keys(%doc))) {
	   $fname=$_;
	   while($fname=~/\\\[(\w*)\]/gs){
	       $match=$1;
	       if($match=~/Capital(\w*)/) {
		   $repl=$1; 
	       } else {
		   $repl=lc($match);
	       };
	       $fname=~s/\\\[$match\]/\$\\$repl\$/gs;
	   };
	   $fname=~s/\\curly(.*)/\\var$1/gs;
	   ##########################3edit
           # while($fname=~/\\\[(\w*)\]/gs){
	   #     $match=$1;
	   #     $repl=lc($1);
	   #     $fname=~s/\\\[$match\]/\$\\$repl\$/gs;
	   #     $fname=~s/\\curly(.*)/\\var$1/gs;
	   #     $fname=~s/\\capitaldelta/\\Delta/gs;
	   # };
#	   $/ = "";
	   chomp($fname);
	   chomp($fname);
	   print "\\item ".$fname.$doc{$_}."\n";
       };
    print "\n\\end{itemize}\n";
};

sub ModelOutputDoc($$$) {
    my $file=shift @_;
    my $model=shift @_;
    my $maxlevel=shift @_;
    my $level="";
    if ($maxlevel=~/internal/) {$level="simple advanced internal";}
    elsif ($maxlevel=~/advanced/) { $level="simple advanced";}
    elsif ($maxlevel=~/simple/) { $level="simple";}
    else { print "$maxlevel is not a valid name for the level of documentation";};
    my $key;
    my $value;
    my %functiondata=();
    my %codedata=();
    my $code;
    my $function="";
    my $reading=0;
    my $options;
    my @tokens;
    my $fname;
    my %doc;
    my $repl;
    my $match;
    local *FILE;
    open(FILE,$file);
    while(<FILE>) {
	if(/\<function(.*?)\>(.*)/) { $options=$1;$function.=$2; $reading=1; }
	elsif($reading&&/(.*)\<\/function\>/) {$function.=$1;$reading=0;
					       @tokens=split(/\ /,$options);
					       foreach (@tokens) { ($key,$value)=split (/=/,$_);
								   $functiondata{$key}=$value;
							       };

					       while ($function=~/\<doc(.*?)\>(.*?)\<\/doc\>/gs) {
						   @tokens=split(/\ /,$1);
#						   print "$1\n";
						   $code=$2;
						   $codedata{"model"}=".*";
						   foreach (@tokens) { ($key,$value)=split (/=/,$_);
								       $codedata{$key}="$value";
								   };
						   
						   if($model && $model=~/$codedata{"model"}/ && $level=~/$codedata{"level"}/) {
							   $fname=$functiondata{'name'};
							   chomp($code);
							   $doc{$functiondata{'name'}}.=$code;
							   
						       };
						   };
					       $function="";
					   }
	elsif($reading) {$function.=$_};
    };
    print "\\begin{itemize}\n";
    foreach (sort(keys(%doc))) {
	   print "\\item ".$doc{$_}."\n";
       };
    print "\n\\end{itemize}\n";
};

parse($file);

exit; 
