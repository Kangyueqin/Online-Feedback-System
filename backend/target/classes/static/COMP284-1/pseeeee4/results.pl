#!/usr/bin/perl
use CGI qw(:all);
use XML::LibXML;
use LWP::Simple;
use utf8;

#Begin HTML file
print header, start_html({-title=>"Search Results", -author=>''});

#Set incorrect to 1 (true). Will be set to 0 (false) if query and/or maxHits do not have the proper format
$incorrect=1;

#If the Submit button has been clicked
if(param('submit')){
    
    #Store the values in the query and maxHits textfields in variables
	$query=param('query');
	$maxHits=param('maxHits');

    #If the query textfield is empty or only contains whitespaces
	if($query eq "" || $query =~/^\s+$/){
        #Display an error message
		print "Query field is empty. Please enter a query.";
		print br();
		print br();
        #Set incorrect to false
		$incorrect=0;
	}
    
    #If the query does not contain the proper format as specified by http://dblp.org/search/
	elsif($query =~ /[^a-zA-Z\$\.\|\- ]+/){
        #Display an error message
		print "Invalid query. Please enter a new query.\n";
		print br();
		print br();
        #Set incorrect to false
		$incorrect=0;
	}
    
    #If the maxHits textfield is empty
	if($maxHits eq ""){
        #Display an error message
		print "Number of results field is empty. Please enter a natural number greater than or equal to 0.\n";
		print br();
		print br();
        #Set incorrect to false
		$incorrect=0;
	}
    
    #If maxHits is not a number greater than 0
	elsif($maxHits !~ /\d+/ || $maxHits < 0){
        #Display an error message
		print "Invalid number of hits. Please enter a  natural number greater than or equal to 0.\n";
		print br();
		print br();
        #Set incorrect to false
		$incorrect=0;
	}
	
    #If query and/or maxHits does not have the proper format
	if($incorrect==0){
        #Display a button that redirects to stat.pl, the previous page,
        #where the user can reenter values for query and maxHits
		print start_form({-method=>"POST", -action=>"stat.pl"});
		print submit({-name=>'return',-value=>'Return to search page.'});
		print end_form;
	}
    
	else{
       
        #The URL for retrieving the results using query and maxHits
		$url="http://www.dblp.org/search/api/?q=$query&h=$maxHits&c=4&f=0&format=xml";
        
        #Stores total number of publications retrieved from the URL
        $totalCount=0;
        
        #Hash to hold each author and the associated count
		my %counts;
        
        #Parse the XML from the URL using LibXML
		my $parser = XML::LibXML->new();
		my $data = $parser->parse_file($url);
        
        #For each author in the XML
		foreach my $author ($data->findnodes('//author')) {
            #Retrieve the author in literal form
			$myAuthor=$author->to_literal;
            #Increment the count for the author in the hash counts
			$counts{$myAuthor}++;
   			
		}
        #For each publication found in the XML
		foreach my $hit ($data->findnodes('//hit')) {
            #Increment the totalCount variable
			$totalCount++;
		}
	
        #Display the value of query and maxHits
		print b("Query: $query; Maximal Number of Hits: $maxHits"),br(),br();
        
        #Display the total number of publications retrieved from the XML
		print "The XML data contains ";
		print b($totalCount);
		print " publications. ", br(), br();
        
        #If the total number of publications is 0, display a message indicating that
		if($totalCount == 0){
			print " Since the number of publications is 0, there are no results to display.", br();
		}

		else{
		
            #Create two hashes, and set each equal to the counts hash
            #Hash for the authors with most publications
			@countsAsc{ keys %counts } = @counts{ keys %counts };
            #Hash for the authors with least publications
			@countsDes{ keys %counts } = @counts{ keys %counts };

            #Sort the hash in ascending order by value of count
            #Store the corresponding keys in one array and the values in another
			my @keysAsc = sort { $countsAsc{$a} <=> $countsAsc{$b} } keys(%countsAsc);
			my @valsAsc = @countsAsc{@keysAsc};
		
            #If there are more than 10 elements in the arrays, delete the extra elements
            #in both arrays
			$start=10;
			while(defined($keysAsc[$start])){
				delete $keysAsc[$start];
				delete $valsAsc[$start];
				$start++;
			}
			
            #Sort the hash in descending order by value of count
            #Store the corresponding keys in one array and the values in another
			my @keysDes = sort { $countsDes{$b} <=> $countsDes{$a} } keys(%countsDes);
			my @valsDes = @countsDes{@keysDes};
            
            #If there are more than 10 elements in the arrays, delete the extra elements
            #in both arrays
			$start=10;
			while(defined($keysDes[$start])){
				delete $keysDes[$start];
				delete $valsDes[$start];
				$start++;
			}
            
            #Create two dynamic tables, one for 10 authors with most publications,
            #and the other for 10 authors with least publications
            
            #Create a table header that spans two columns
            #firstTable represents the table for 10 authors with most publications
			$firstTable=[th({-colspan=>'2'},["10 Authors with most publications"])];
            #Add the header to the table along with the column headings for Author
            #and Number of Publications
			push @$firstTable, th(["Author","Number of publications"]);
            
            #For each author in the keysDes array
			foreach $i (0...$#keysDes)
			{
                #Add a row to the table containing the author and associated count
  				push  @$firstTable, td([$keysDes[$i], $valsDes[$i]]);
			}
			
            #Display the first table on the webpage
			print table({-border=>1, cellpadding=>3},
			Tr($firstTable));
            
            #Create a table header that spans two columns
            #secondTable represents the table for 10 authors with least publications
			$secondTable=[th({-colspan=>'2'},["10 Authors with most publications"])];
            #Add the header to the table along with the column headings for Author
            #and Number of Publications
			push @$secondTable, th(["Author","Number of publications"]);
            
            #For each author in the keysDes array
			foreach $i (0...$#keysAsc)
			{
                #Add a row to the table containing the author and associated count
  				push  @$secondTable, td([$keysAsc[$i], $valsAsc[$i]]);
			}
            #Display the second table on the webpage
			print table({-border=>1, cellpadding=>3},
			Tr($secondTable));
 				 
		}
		
		#Subroutine for escaping the XML so that it's displayed with the tags
		#Written with help from http://www.perlmonks.org/?node_id=601014
		sub escapeXML($) {
			my $xml=shift;
			$xml =~ s/</&lt;/g;
			$xml =~ s/ < >/&gt;/g;
			return $xml;
		}
	
		print br(), "XML data:", br();
        #Display the XML data retrieved from the URL
		
		#Create temporary file with XML data from the url
		my $file = 'temp.xml';
		open FILE, $file;
		getstore($url, $file);

		#Open file and print XML contents
		open XML, '<', 'temp.xml' or die $!;
		print "<pre>\n";
		#Call escapeXML subroutine to display XML in proper format
		print escapeXML($_) while <XML>;
		print "\n</pre>";
		#Close and delete the file
		close $file;
		unlink $file;

	}

}
#End the HTML page
print end_html;