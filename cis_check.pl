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
my @sanitizeMe;
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
@sanitizeMe = $mech->content =~ /450><p class='noten_noten'>(.*?)<.*?value='([1-5]\.[0-7])/sg;
# Unfortunately the exam names differ, e.g. "Programmierung1" vs. "Programmierung 1"
for (my $i=0; $i <= $#sanitizeMe; $i++)
{
	$sanitizeMe[$i] =~ s/(\S)([1-2])/$1 $2/;
}
%examsGrade = @sanitizeMe;

$mech->get( "https://cis.nordakademie.de/pruefungsamt/studienplan/" );
%examsCredit = $mech->content =~ /g'>&nbsp;&nbsp;(.*?)<\/td>.*?cp.*?<span>([1-9])</g;
printf("Dein simpler Durchschnitt liegt bei: %.3f!\nBisher wurden %d Klausuren geschrieben.\n\nDeine Noten im Detail:\n\n", sum(values(%examsGrade)) / keys( %examsGrade ), keys( %examsGrade )+0);
printf "%-56s %-12s %s\n", "Fach:", "Note:", "Credits:";
foreach my $gradeKey ( keys %examsGrade )
{
	my $credit = 0;
	if (exists $examsCredit{$gradeKey})
	{	
		$credit = $examsCredit{$gradeKey};
	}
	printf "%-56s %-12.1f %d\n", $gradeKey, $examsGrade{$gradeKey},$credit;
}
