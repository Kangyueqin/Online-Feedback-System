#!/usr/bin/perl --
# Author:
# Words.pl

#these are the modules that will be used
	use CGI qw(:all);
	use LWP::Simple qw(get);
	use XML::Simple;
	use Data::Dumper;
	use XML::LibXML;
	
	
	#Gets what the user has inputed and assigns it to a variable
	$query=param('query');
	$maxHits=param('maxHits');

	#This now fetches the url and appends it to what the user has inputed
	$URL = "http://www.dblp.org/search/api/?q=".$query."&h=".$maxHits."&c=4&f=0&format=xml";
	
	#Creates an object
	$XML = new XML::Simple (KeyAttr=>[]);
	
	#This will get the document from the obtained URL and assigns it to a variable
	my $recieved = get($URL);
	
	#Will now read the XML data and assign it to a varaible data
	$data = $XML->XMLin($recieved);
	
	#This is now where the handling of the array is sorted
	my @statement = split /[>]/, $recieved;
	
	#a varaible for the array to be called
	my $statement1 = $statement[0];
	

	
#this will print the header, providing the Keywords and declaring the author also

print header, "\n",start_html({-title=>'Keywords retrieval',-author=>''}), "\n";

#starts the header of the page
print "<html> <head>\n";

#prints a header
print "<title>Search Author & Number Of Publications</title>";

print "</head>\n";

print "<body>\n";

print "<h1>Search Author & Number Of Publications</h1>\n";

print "</body> </html>\n";

#If the user submits then this method will take action
#This creates a table that includes the authors 
#To add the authors into the table, this will fetch them from a particular position within the HTML doc.

if (param('submit')) 
	{
	print table({-border=>undef},
           caption('Top 5'),
           Tr({-align=>'Left',-valign=>'TOP'},
           [
              th(['Author', 'No Publications','Author','No Publications']),
              td([$statement[10], '', '', '']),
              td([$statement[19], '', '',  '']),
              td([$statement[21], '','', '']),
			  td([$statement[23], '','', '']),
			  td([$statement[25], '','', ''])
           ]
           )
        );
		
	#this was used for testing purposes to work with the data
	
	#print Dumper($data);

	}
	
	
	
#if user submits a query
#Returns what the user searches as a point of reference 
if (param('submit')) 
	{

	print h1("You Searched"), "\n";
	foreach $key (param()) 
		{
	print "$key is : ",param($key), br(), "\n";
		}
	}
	
#prints the headere Form
print h1("Form"), "\n";

#Submits query to webpage
print start_form({-method=>"POST",-action=>"words.pl"});

#Takes input from the end user for the author
print "Keywords: ";
print textfield({-name=>query,-value=>'',-size=>100}), "\n";

print "Number of Publications: ";
print textfield({-name=>maxHits,-value=>'',-size=>100}), "\n";

#Submit button
print submit({-type=>'submit',-name=>'submit',-value=>'Submit'}), "\n";

#End of page
print end_form, end_html;