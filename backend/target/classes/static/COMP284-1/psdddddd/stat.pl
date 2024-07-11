#!/usr/bin/perl
#
#COMP 284 - Assignment 1

use LWP::Simple;
use CGI qw(:standard);
use utf8;

print header, "\n", start_html({-title=>'COMP 284 - Assignment 1'}); #start html
print h1("COMP 284 - Assignment 1"); #printing the header
if (param()) {
	my $query = param("query"); #variable for keywords
	my $maxHits = param("maxHits"); #variable for number of publications
	my $count = 0; #variable to count number of matches
	my $pubs = 0; #variable to count number of publications returned
	if ($query eq '') { #if query is empty
		checkQuery(); #calling method to print that there is a problem with query
	}
	if($maxHits eq '') { #if maxHits is empty
		checkMaxHits(); #calling method to print that there is a problem with maxHits
	}
	if ($maxHits =~ /\D/) { #if maxHits is not an integer or not whole
		checkMaxHits(); #calling method to print that there is a problem with maxHits
	}
	elsif (param('query') && param('maxHits')) { #if query and maxHits are not empty
		my $url = "http://www.dblp.org/search/api/?q=$query&h=$maxHits&c=4&f=0&format=xml"; #set xml page to url
		my $content = get($url); #get the xml from url and set it to content
		@strings = split(/</, $content); #splitting all the values content to string	
		foreach $string (@strings) { #loop for every string that is in the array
			if (($string =~ /author>(.*)/) && $string !~ /\/author>(.*)/) { #if value is an author
				push(@mostAuthors, $1); #push to mostAuthors array
			}
		}
		foreach $string (@strings) { #loop for every string that is in the array
			if (($string =~ /title>(.*)/) && $string !~ /\/title>(.*)/) { #if value is a title
				$pubs++; #increment pubs
			}
		}
		print h2("Search for $query within $maxHits publications"); #print query that has been submitted
		print "Number of publications returned: $pubs", br(), br(); #print number of publications returned
		print "<table border=5>"; #start of table
			print "<tr>"; #new table row
				print "<th>10 Authors with most publications</th>"; #table header
			print "</tr>"; #end table row
			print "<tr>"; #new table row
				print "<th>Author</th>"; #table header
				print "<th>No of publications</th>"; #table header
			print "</tr>"; #end table row
			%count = ();
			foreach $mostAuthor (@mostAuthors) { #loop for each string in mostAuthors
				$count{$mostAuthor}++; #increment count if string is matched in array
			}
			my $c = 0; #variable to count number of print in the table
			foreach my $key (sort {$count{$b} <=> $count{$a}} keys%count) { #loop for each key and sort by count
				print "<tr>"; #new table row
					print "<td>"; #new table data
						print $key, br(); #print key
					print "</td>"; #end of table data
					print "<td>"; #new table data
					print $count{$key}, br(); #printing number of matches for each element of string
						print "</td>"; #end of table data
				print "</tr>"; #end of table row
				$c++; #increment c
				if ($c == 10) { #if 10 instances of key have been printed
					last; #break from loop
				}
			}
			print "</table>", br(); #end of table
		print "<table border=5>"; #start of table
			print "<tr>"; #new table row
				print "<th>10 Authors with least publications</th>"; #table header
			print "</tr>"; #end of table row
			print "<tr>"; #new table row
				print "<th>Author</th>"; #table header
				print "<th>No of publications</th>"; #table header
			print "</tr>"; #end of table row
			foreach $string (@strings) { #loop for every string that is in the array
				if (($string =~ /author>(.*)/) && $string !~ /\/author>(.*)/) { #if value is an author
					push(@leastAuthors, $1); #push to Authors array
				}
			}
			%count = ();
			foreach $leastAuthor (@leastAuthors) { #loop for each string in leastAuthors
				$count{$leastAuthor}++; #count if string is matched in array
			}
			my $c = 0; #variable to count number of print in the table
			foreach my $key (sort {$count{$a} <=> $count{$b}} keys%count) { #loop for each key and sort by count
				print "<tr>"; #new table row
					print "<td>"; #new table data
						print $key, br(); #print key
					print "</td>"; #end of table data
					print "<td>"; #new table data
					print $count{$key}, br(); #printing number of matches for each element of string
						print "</td>"; #end of table data
				print "</tr>"; #end of table row
				$c++; #increment c
				if ($c == 10) { #if 10 instances of key have been printed
					last; #break from loop
				}
			}
		print "</table>\n"; #end of table
	}	
		
}
else {
	form(); #calling method to print form
}

sub form {
	print start_form({-method=>"GET", -action=>"http://cgi.csc.liv.ac.uk/cgi-bin/cgiwrap/u5dd2/stat.pl"}); #start of form
	print "Enter a keyword: ";
	print textfield({-name=>'query', -size=>50, -maxlength=>30}), br(), br(); #textfield for query
	print "Enter the maximal number of publications: ";
	print textfield({-name=>'maxHits', -size=>5, -maxlength=>5}), br(), br(); #textfield for maxHits
	print submit({-name=>'submit', -value=>'Submit'}); #submit button
	print end_form, end_html; #end of form and html
}

sub checkQuery {
	print "Please enter a keyword", br(), br(); #printing if problem with query
}

sub checkMaxHits {
	print "Please enter a whole number greater than 0", br(), br(); #printing if problem with maxHits
}