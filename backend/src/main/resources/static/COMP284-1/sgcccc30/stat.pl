#!/usr/bin/perl
# Author:
# Student No.
# Perl script for a web-based system that retrieves information from the DBLP Comp Sci Bibliography.

use CGI qw(:all);
use LWP::Simple;
print header, "\n",

#setting up the individual web page by associating it to the individuals email address.
start_html({-title=>'URL retrieval',
-author=>''}), "\n";

#Creating the header 'Environment Variables' when the 'submit' button has been hit
if (param('submit')) {
	print h1("Environment variables"), br(), "\n";
	#prints all of the environmental variables under the heading
	foreach $key (keys %ENV) {
		print "The value of $key is $ENV{$key}", br(), "\n";
	}
	
	
	#Creating the header 'Parameters' which outlines the users inputted requests
	print h1("Parameters"), br(), "\n";
	foreach $key (param()) {
		print "The value of $key is ",param($key), br(), "\n";
	}
	
	print h1("Content of ".param('')), "\n";
	
	# Create search outcome heading
	print h1("DBLP Computer Science Bibliography Search:"), "\n";
		
	#Create the table to display desired data
	print table({-border=>undef},
    Tr({-align=>'CENTER',-valign=>'TOP'},
    [
	td(['Author', '10 Authors with most publications' ,'Author', '10 Authors with least publications']),
	th(['Author' , 'No of publications', 'Author', 'No of publications']),
	td(['VAR NAME' , 'VAR No', 'VAR NAME 2',  'VAR No']),
	td(['VAR NAME'   , 'VAR No','VAR NAME 2', 'VAR No'])
    ]
        )
     );
		
	#Retrieve and Assign URL
	print start_form({-method=>"POST",
		-action=>"http://cgi.csc.liv.ac.uk/cgi-bin/cgiwrap/u4ccc/stat.pl"});
		
	#Assinging query input from user to the query parameter 
	$query = param(query);
	#Assinging ,maxHits input from user to the maxHits parameter 
	$maxHits = param(maxHits);
		
	#Allowing the query and max hits input to be run through the dbpl
	$URL=get("http://www.dblp.org/search/api/?q=$query&h=$maxHits&c=4&f=0&format=xml");
	%count = ();
	foreach $string (@strings) {
		$count{$string}++;
	}
	foreach $key (keys %count) {
		print $key, ": ", $count{$key}, br(), "\n";
	}
	print $URL, br(), "\n\n";
	}
	
	#Create heading for the main page of the input forms
	print h1("DBLP Computer Science Bibliography Search:"), "\n";
	#Starting the form that is associating the webpage to the user inputing
	print start_form({-method=>"POST",
		-action=>"http://cgi.csc.liv.ac.uk/cgi-bin/cgiwrap/u4amh/stat.pl"});
	
	#Create input field related to the query of the search
	print "Keyword: ";
	print textfield({-name=>'query',
		-size=>20}), "\n";
	print br(), "\n";
	
	#Create input field related to the maxHits of the search
	print "Maximum Hit Limit: ";
	print textfield({-name=>'maxHits',
		-size=>20}), "\n";
	print br(), "\n";
	
	#Create the submit button which confirms the data in the input fields
	print submit({-name=>'submit',
		-value=>'Process'}), "\n";
	print end_form, end_html;
	

 

	
	

	