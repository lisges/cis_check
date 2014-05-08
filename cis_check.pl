#!/usr/bin/perl
use warnings;
use strict;
use List::Util qw(sum);
use WWW::Mechanize;
binmode(STDOUT, ":utf8");
#### Enter your credentials here ####
my $username = "XXXXX";
my $password = "Password";
my $regex = "Englisch";
#####################################
my (%examsCredit, %examsGrade) = (); # Key: exam name, Value: cp - Key: exam name, Value: grade 
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
# Get all evaluated exams and grades:
$mech->get( "https://cis.nordakademie.de/pruefungsamt/pruefungsergebnisse/" );
$out = $mech->content;
@matches = $out =~ /value=\'([1-5].[0-7])\'/g;
# Get exams and cp:
$mech->get( "https://cis.nordakademie.de/pruefungsamt/studienplan/" );
$out = $mech->content;
# Regex exams and cp into array:
@matches2 = $out =~ /g'>&nbsp;&nbsp;(.*?)<\/td>.*?cp.*?<span>([1-9])</g;
# From array to hashmap
for ($i=0;$i<@matches2;$i+=2) {
	$examsCredit{ $matches2[$i] } = $matches2[$i+1];
	print "Set key $matches2[$i] to $matches2[$i+1]\n";
}

if ($mech->content( format => 'text' ) =~ m/$regex/) {
	print "Die Note ist da!\n";
} else {
	print "Die Note ist noch nicht da!\n";
}
printf("Dein Durchschnitt liegt bei: %.3f!\nBisher wurden %d Klausuren geschrieben.\n", sum(@matches) / @matches, $#matches+1);
