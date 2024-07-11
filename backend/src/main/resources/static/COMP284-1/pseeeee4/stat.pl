#!/usr/bin/perl

use CGI qw(:all);

#begin HTML file
print header, start_html({-title=>"Search DBLP", -author=>''});

print b("Search DBLP");

#Begin HTML form, which directs to results.pl when the Submit button is clicked
print start_form({-method=>"GET", -action=>"results.pl", -accept-charset=>"utf-8"});

#Break statement
print br();

print "Enter query: ";
#Textfield for entering the query
print textfield({-name=>'query', -size=>40});

print br();
print br();

print "Enter maximal number of results: ";
#Display textfield for entering the maximal number of publications to include
print textfield({-name=>'maxHits', -size=>10});

print br();
print br();

#Display button for submitting the provided information
print submit({-name=>'submit',-value=>'Submit'});

#End of form and HTML document
print end_form, end_html;
