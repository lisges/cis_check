#!/usr/bin/perl
use warnings;
use strict;
use List::Util qw(sum);
use WWW::Mechanize;
binmode(STDOUT, ":utf8");
#### Enter your credentials here ####
my $username = "XXXXX";
my $password = "Password";
#####################################
my (%examsCredit, %examsGrade) = ();
# %examsCredit: Key: exam name, Value: cp
# %examsGrade: Key: exam name, Value: grade 
my (@matches, @matches2);
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
# Get data and regex pairs into hash map:
$mech->get( "https://cis.nordakademie.de/pruefungsamt/pruefungsergebnisse/" );
%examsGrade = $mech->content =~ /450><p class='noten_noten'>(.*?)<.*?value='([1-5]\.[0-7])/sg;
$mech->get( "https://cis.nordakademie.de/pruefungsamt/studienplan/" );
%examsCredit = $mech->content =~ /g'>&nbsp;&nbsp;(.*?)<\/td>.*?cp.*?<span>([1-9])</g;
printf("Dein Durchschnitt liegt bei: %.3f!\nBisher wurden %d Klausuren geschrieben.\n", sum(values(%examsGrade)) / keys( %examsGrade ), keys( %examsGrade )+0);
