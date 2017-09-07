#!/usr/bin/env perl -w 

use strict; 
use warnings;

# Getting command line arguments:
use Getopt::Long;
# Documentation:
use Pod::Usage;
# I/O Handler
use IO::Handle;

my($test, $ref);

# Command line arguments
GetOptions( 'test|t=s'           => \$test,
            'ref|r=s'            => \$ref,
          ) || pod2usage(2);

pod2usage(2) unless ($test);
pod2usage(2) unless ($ref);

open(TEST, "<$test") or die "Error: Cannot open test file \'$test\': $!\n";
open(REF, "<$ref") or die "Error: Cannot open reference file \'$ref\': $!\n";

my $STOP = 0; 
my $HITS = 0; 
my $TOTAL = 0;
my @SEG;
while(my $o=<TEST>){
    my $SEGscore = 0;
    if (my $r=<REF>){
        chomp($o); chomp($r);
        my @lO = split(" ", $o);
        my %hO; foreach my $w (@lO) { $hO{$w}++; }
        my @lR = split(" ", $r);
        my %hR; foreach my $w (@lR) { $hR{$w}++; }
        my ($hits, $total) = compute_overlap(\%hO, \%hR, 1);
        $SEGscore = safe_division($hits, $total);
        $HITS += $hits;
        $TOTAL += $total;
      }
      else { print STDERR "[ERROR] number of lines differs <$test> vs <$ref>\n"; $STOP = 1; }
      print "$SEGscore\n";
   }
my $SYS = safe_division($HITS, $TOTAL);

sub compute_overlap {
   #description _ computes overlap between elems in candidate and reference hash of features
   #param1 _ candidate hash of features
   #param2 _ reference hash of features
   #param3 _ do_lower_case matching (1:yes->case_insensitive :: 0:no->case_sensitive)

   my $h_candidate = shift;
   my $h_reference = shift;
   my $LC = shift;

   my $hits = 0; my $total = 0;

   my ($terms_candidate, $terms_reference, $termsTot) = extract_terms ($h_candidate, $h_reference, $LC);
   my %terms_candidate = %$terms_candidate;
   my %terms_reference = %$terms_reference;
   my %termsTot = %$termsTot;

   if ((scalar(keys %{$h_candidate}) > 0) and (scalar(keys %{$h_reference}) > 0)) {
      foreach my $term (keys %termsTot){
         if ($terms_candidate{$term} && $terms_reference{$term}) {
            if ($terms_candidate{$term} > $terms_reference{$term}) {
               $hits += $terms_reference{$term};
               $total += $terms_candidate{$term};
            }
            else {
               $hits += $terms_candidate{$term};
               $total += $terms_reference{$term};
            }
         }
         else {
            if ($terms_candidate{$term}) { $total += $terms_candidate{$term}; }
            elsif ($terms_reference{$term}) { $total += $terms_reference{$term}; }
            }
      }
   }
   else { foreach my $term (keys %termsTot) { $total += $termsTot{$term}; } }

   return ($hits, $total);
}

sub extract_terms{
   #description _ extract the hash-counts of features
   #param1 _ candidate hash of features
   #param2 _ reference hash of features
   #param3 _ do_lower_case matching (1:yes->case_insensitive :: 0:no->case_sensitive)

   my $h_candidate = shift;
   my $h_reference = shift;
   my $LC = shift;

   my %terms_candidate; my %terms_reference; my %termsTot;

   if (scalar(keys %{$h_candidate}) > 0) {
      foreach my $W (keys %{$h_candidate}) {
         my $t;
         if ($LC) { $t = lc($W); }
         else { $t = $W; }
         $terms_candidate{$t} += $h_candidate->{$W};
         $termsTot{$t} += $h_candidate->{$W};
      }
   }
   if (scalar(keys %{$h_reference}) > 0) {
      foreach my $W (keys %{$h_reference}) {
         my $t;
         if ($LC) { $t = lc($W); }
         else { $t = $W; }
         $terms_reference{$t} += $h_reference->{$W};
         $termsTot{$t} += $h_reference->{$W};
      }
   }
   return (\%terms_candidate,\%terms_reference,\%termsTot);
}

sub safe_division {
    #description _ if denominator is different from 0 returns regular division; otherwise returns default value (0 if not specified)
    #param1  _ numerator
    #param2  _ denominator
    #param3  _ default value
    #@return _ safe division

    my $numerator = shift;
    my $denominator = shift;
    my $default = shift;

    if (!defined($default)) { $default = 0; }

    if (!defined($denominator)) { $denominator = 0; }

    if ($denominator == 0) { return $default; }

    return $numerator / $denominator;
}
