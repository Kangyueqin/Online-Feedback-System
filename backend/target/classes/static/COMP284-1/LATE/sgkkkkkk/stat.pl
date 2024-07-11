#!/usr/bin/perl
# Author: Matthew Linnell
# Email: m.t.linnell@student.liverpool.ac.uk

use CGI qw(:all);
use LWP::Simple qw(get);
use warnings;
use utf8;
binmode(STDOUT, ":utf8");

header{charset => "UTF-8"};

print header, start_html({-title => 'Assignment 1'});
print start_form({-method => "GET", -action => "http://cgi.csc.liv.ac.uk/cgi-bin/cgiwrap/u5ml/stat.pl"});

# Form displayed on the screen, consisting of three components
print p("Key words: ");
print textfield({-name => 'query', -size => 100});
print p("Max hits: ");
print textfield({-name => 'maxHits', -size => 50});
print br();
print br();
print submit({-name => 'submit', -value => 'Submit'});

print end_form, end_html;

# Check if user has made entries to both textfields
if (param('query') && param('maxHits')){
	# Check if this these entries are valid
	if(param('maxHits') !~ /^[0-9]+$/s){
		# If entries invalid, inform the user
		print br();
		print "Invalid input!";
	} elsif(param('query') !~ /^[a-zA-Z]+$/si){
		print br();
		print "Invalid input!";
	} else{
		# If entries valid, get the URL, using the 'query' and 'hits' values 
		$maxHits = escapeHTML(param('maxHits'));
		$query = escapeHTML(param('query'));
		print br();
		
		# XML retrieved from the query displayed to the user
		print 'XML:';
		print br();
		print '<pre>', escapeHTML(get("http://www.dblp.org/search/api/?q=$query&h=$maxHits&c=4&f=0&format=xml")), '</pre>';
		print br();
		
		$_ = (get("http://www.dblp.org/search/api/?q=$query&h=$maxHits&c=4&f=0&format=xml"));
		$hitCount = 0;
		# Number of publications counted
		foreach(/<hit[^s][^<]*[\/>]/gs){
			$hitCount++;
		}

		# Number of publications recieved displayed to user
		print 'Publications found: ' . $hitCount;
		print br();
		print br();
		
		%authors = ();
		$authorCount = 0;
		
		# Author names retrieved
		foreach(/<author>[^<]*<\/author>/gs){
			$authorCount++;
			$authors[$authorCount] = $_; 
			print 'Author found: ' . $authors[$authorCount];
			print br();
		}
		
		%count = ();
		
		# Data put into array and displayed to user
		foreach $string(@authors){
			$count{$string}++;
		}
		
		foreach $key (keys %count){
			print $key, ": ", $count{$key}, br();
		}
	}
}