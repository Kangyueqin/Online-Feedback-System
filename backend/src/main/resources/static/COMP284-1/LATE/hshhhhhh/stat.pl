#!/usr/bin/perl

use CGI qw(:all);
use LWP::Simple qw(get);
use utf8;
use Unicode::Normalize;
use XML::LibXML;

print header, "\n",
	start_html({-title=>'DBLP Computer Science Bibliography', -author=>''}), "\n";


#Input validation, Couldn't figure the query out
if(param('query') or param('maxHits')){
if (param('query')) {
	$query = param($query);
	$validate = 1;
}
if (param('maxHits')) {
	$maxHits = param('maxHits');
	if($maxHits =~ /^[0-9]+$/){ #Only positive natural numbers
		$validMaxHits = 1;
		if($maxHits eq 0){
			print "Your query is " . $query . ". There are 0 publications.", br(), "\n";
		}
	}
	else{
		$validMaxHits = 0;
		print font({-color=>'red'},"Please enter a valid number(greater than 0)."), br(),"\n";
	}
}

#retrieve stuff
if(($validMaxHits == 1) and ($validate == 1)){
	
	$query = param('query');
	$maxHits = param('maxHits');
	#Concatenate the url to get the XML file
	$URL = "http://www.dblp.org/search/api/?q=" . $query . "&h=" . $maxHits . "&c=4&f=0&format=xml;";
	my $parser = XML::LibXML->new;
	$doc = $parser->parse_file($URL);
	
	my @hits = $doc->findnodes("/result/hits/hit/info/authors/author");
	my @numberhits = $doc->findnodes("/result/hits/hit"); #Every occurance is a publication
	
	
	print "Your query is " . $query . ". There are ". scalar @numberhits . " publications.\n";
	
	#Extract data in xml format into array
	@trueHits = ();
	foreach $thing (@hits){
		push(@trueHits, $thing->firstChild->data);
	}
	
	#Get unique list of authors
	%seen = ();
	@uniq = ();
	foreach $item (@trueHits) {
		unless ($seen{$item}) {
			$seen{$item} = 1;
			push(@uniq, $item);
		}
	}
	
	
	#Count the number of publications of each author and put them into a hash
	%Author_Publications = (); #Initialize hash
	foreach $author (@uniq){
		my $temp = 0;
		for (@trueHits) {
			$temp++ if /^$author$/; #Only exact matches
		}
		$Author_Publications{$author} = $temp;
	}
	
	#get 10 authors with most publications sorted
	my @keys = sort {$Author_Publications{$b} <=> $Author_Publications{$a}} keys %Author_Publications;
	my @highest = @keys[0..9];
	
	#get 10 authors with least publications
	my @keys2 = sort {$Author_Publications{$a} <=> $Author_Publications{$b}} keys %Author_Publications;
	my @lowest = @keys2[0..9];
	
	
	#Printing out the table
	print '<table><tbody><tr>';
		print '<td>';
			print '<table border = "1">';
				print '<caption>10 Authors with least publications</caption>'.
					'<th>Author</th><th>No of publications</th>';
					foreach my $loopyland2 (@highest){
						print '<tr><td>'.
						$loopyland2 . '</td><td>'.
						$Author_Publications{$loopyland2}
						.'</td></tr>';
					}
			print '</table>';
		print '</td>';
	
		print '<td>';
			print '<table border = "1">';
				print '<caption>10 Authors with least publications</caption>'.
					'<th>Author</th><th>No of publications</th>';
					foreach my $loopyland (@lowest){
						print '<tr><td>'.
						$loopyland . '</td><td>'.
						$Author_Publications{$loopyland}
						.'</td></tr>';
					}
					
			print '</table>';
		print '</td>';
	print '</tr></tbody></table>';
	
	
}
}
print h1("DBLP Computer Science Bibliography"), "\n";

#The script should display a web page that contains a form with two text fields and a `Submit' button. The first text field should allow a user to enter keywords that describe an author or topic, called query in the following.
#The second text field should allow a user to enter a number that specifies the maximal number of publications that should be included in the statistics that the system will produce, called maxHits in the following
print start_form({-method=>"POST", -action=>"http://cgi.csc.liv.ac.uk/cgi-bin/cgiwrap/u4aa/stat.pl"});
print "Query: ";
print textfield({-name=>'query',-size=>200}), br(), "\n";
print "Number: ";
print textfield({-name=>'maxHits',-size=>200}), br(),"\n";
print submit({-name=>'submit',-value=>'Submit'}), "\n";
print end_form, end_html;
