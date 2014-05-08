#!/usr/bin/perl
use warnings;
use strict;
use List::Util qw(sum);
use WWW::Mechanize;
#### Enter your credentials here ####
my $username = "XXXXX";
my $password = "Password";
my $regex = "Englisch";
my @matches;
#####################################
my $out;
print "Initialize WebAgent...\n";
my $mech = WWW::Mechanize->new();
$mech -> cookie_jar(HTTP::Cookies->new());
print "Loading CIS...\n";
$mech->get( "https://cis.nordakademie.de/startseite/" );
print "Trying to login...\n";
$mech -> field ('user' => $username);
$mech -> field ('pass' => $password);
$mech -> click ('submit');
print "Fetching results...\n";
$mech->get( "https://cis.nordakademie.de/pruefungsamt/pruefungsergebnisse/" );
$out = $mech->content;
@matches = $out =~ /value=\'([1-5].[0-7])\'/g;
if ($mech->content( format => 'text' ) =~ m/$regex/) {
  print "Die Note ist da!\n";
} else {
  print "Die Note ist noch nicht da!\n";
}
printf("Dein Durchschnitt liegt bei: %.3f!\nBisher wurden %d Klausuren geschrieben.\n", sum(@matches) / @matches, $#matches+1);
