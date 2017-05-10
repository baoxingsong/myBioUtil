#!perl -w
use strict;


## %unliableNumber should be sequening quality related things, here we do not have sequencing related things,
## so assign a quality randomly. Set the line number as quality
my %unliableNumber;
my %individuals;
my $id=0;
open INPUT, "plink.mibs.id";
while( my $line=<INPUT> ){
	if( $line=~/^(\S+)/ ){
		$individuals{$id}=$1;
		$unliableNumber{$1}=$id;
		$id++;
	}
}
close INPUT;

my $lineNumber=0;
open INPUT, "plink.mibs";
while( my $line=<INPUT> ){
	my @cells=split(" ", $line);
	my $lineSize = @cells;

	my $i=0;
	while( $i < $lineSize ){
		if( $cells[$i]>0.9 && $lineNumber<$i ){
			if( !exists $unliableNumber{$individuals{$lineNumber}} ){
				print "no $individuals{$lineNumber}\n";
			}elsif(! exists $unliableNumber{$individuals{$i}}){
				print "no $individuals{$i}\n";
			}else{
				if( $unliableNumber{$individuals{$lineNumber}} > $unliableNumber{$individuals{$i}} ){
					print "$individuals{$lineNumber}\t$individuals{$lineNumber}\n";
				}else{
					print "$individuals{$i}\t$individuals{$i}\n";
				}
			}
		}
		$i++;
	}
	$lineNumber++;
}
close INPUT;
