#!/usr/bin/perl
use strict;
use warnings;
use POSIX qw(strftime);
use Getopt::Std;
use File::Basename;

###############################################################################
#Get the parameter and provide the usage.
###############################################################################
my %opts;
getopts( 'i:o:d:p:', \%opts );
&usage unless ( exists $opts{i} && exists $opts{o} );
my $start_time=time;
print strftime("Start time is %Y-%m-%d %H:%M:%S\n", localtime(time));


###############################################################################
#Main text.
###############################################################################
my @filelist=glob "$opts{i}";
for (0..$#filelist){
	my $basename=basename($filelist[$_]);
	my $output=$opts{o}.$basename;
	print "$opts{p} -a $filelist[$_] -b $opts{d} -wo>$output\n";
	`$opts{p} -a $filelist[$_] -b $opts{d} -wo>$output`;
}
print scalar @filelist," files have been treated.\n";


###############################################################################
#Record the program running time!
###############################################################################
my $duration_time=time-$start_time;
print strftime("End time is %Y-%m-%d %H:%M:%S\n", localtime(time));
print "This compute totally consumed $duration_time s\.\n";

###############################################################################
#Scripts usage and about.
###############################################################################
sub usage {
    die(
        qq/
Usage:    batch_intersect.pl -i inpute_file_list -o output_file_directory -d database_filename -p call program
Function: batch call program have one input, and one output, and an database according with input
		  default include double strand, at least 1bp overlap
Command:  -i inpute_file_list (Must)
          -o output_file_directory
          -d call program
Author:   Liu Yong-Xin, woodcorpse\@163.com, QQ:42789409
Version:  v1.0
Update:   2013-05-15
Notes:    
\n/
    )
}
