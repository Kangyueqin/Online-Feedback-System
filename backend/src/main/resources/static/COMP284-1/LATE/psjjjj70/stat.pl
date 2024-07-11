#!/usr/bin/perl
use CGI qw(:all);
use CGI qw/:standard *table start_ul/;
use LWP::Simple;
use strict;
#use utf8;
#binmode(STDOUT, ":utf8");
#use Unicode::Normalize;

print header, "\n",
start_html({-title=>'My HTML Form',
-author=>''}), "\n";

# -----Form------- #
#create form
print start_form({-method=>"GET",
-action=>"http://cgi.csc.liv.ac.uk/cgi-bin/cgiwrap/u5ab2/stat.pl"}), "\n";

#create textfield for keyword
print "Enter Author or Topic : ";
print textfield({-name=>'query',
-value=>'',
-size=>100}), "\n";
print br();

#create textfield for quantity
print "Enter max number of publications : ";
print textfield({-name=>'maxHits',
-value=>'',
-size=>100}), "\n";
print br(), "\n";

#create submit button
print submit({-name=>'submit',
-value=>'Click for response'}), br(), br(), "\n";

print end_form;
# -----End of Form------- #

# -----Validate Form Input------- #
my $query;
my $maxHits;
if(param('submit'))
{
	#check query field, if invalid print an error message, 
	#else store input 
	if(param('query')!~/[a-zA-Z0-9]/s)
	{
		print "Invalid query input.", br(), "\n";
	}
	else
	{
		$query = escapeHTML(param('query'));
	}

	#check quantity field, if invalid print an error message, 
	#else store input
	if(param('maxHits')!~(/\d+/g) || param('maxHits')<0)
	{
		print "Invalid number of publications input", 
		br(), br(), "\n";
	}
	else
	{
		$maxHits = $&;
	}
}
# -----End of Validate Form Input------- #


#if input is validated continue to process data
if(defined($query) && defined($maxHits))
{	


# -----Retrieve XML------- #
#retrieve query from database
my $dblp;
my $result;

$dblp = "http://www.dblp.org/search/api/?q=$query&h=$maxHits&c=4&f=0&format=xml;";
$result = get($dblp);
die "Couldn't retrive XML" unless defined $result;

# -----End of Retrieve XML------- #

# -----Process XML------- #
#calculate number of publications
my $numOfPub;
$numOfPub = 0;
$_ = $result;

while(/<title>/g)
{
	$numOfPub++;
}

#store authors in array
my @authors;
$_ = $result;

while(/<author>(\w*.?){0,5}<\/author>/g)
{
	push(@authors,$&);
}
# -----End of Process XML------- #

# -----Process Authors------- #
#remove author tags from each author
my $author;
foreach $author (@authors)
{
	$author =~ s![<author>]+!!;	#opening tag
	$author =~ s![<]/[author>]+!!;	#closing tag
}

#for each author, count the number of publications and store in hash
my $authorCount;
my %authorCount;
my $key;
my $value;

++$authorCount{$_} foreach (@authors);
# -----End of Process Authors------- #


# -----Print Query Results------- #
print "Query: $query; Maximal Number of Hits: $maxHits", 
		br(), br(), "\n";
print $result;

print br(), br(), "Total number of publications retrieved: ",
		$numOfPub, br(), br(), "\n";

# -----End Print Query Results------- #


# -----Sorting Subroutines------- #
#Author count descending 
sub byCountDescending
{
	$authorCount{$b} <=> $authorCount{$a}
}

#Author count ascending
sub byCountAscending
{
	$authorCount{$a} <=> $authorCount{$b}
}
# -----End of Sorting Subroutines------- #


# -----Create Table------- #
my $rowCount = 0;
if($numOfPub != 0)
{
#Descending order
print start_table({-border=>'2px'});
print Tr([
			td({colspan=>'2'},
			['10 Authors with the most publications']),
			th(['Author', 'No of publications'])
	]);

	#create 10 rows with author and number of publications
	foreach $key (sort byCountDescending keys %authorCount)
	{
		if($rowCount<10)
		{
		print Tr({-border_spacing=>'10px', -padding=>'20px'},
			[	td([$key, $authorCount{$key}])
			]);
		$rowCount++;
		}
	}
	
print end_table;

#Ascending order
$rowCount = 0;
print start_table({-border=>'2px'});
print Tr([
			td({colspan=>'2'},
			['10 Authors with the least publications']),
			th(['Author', 'No of publications'])
	]);
	
	#create 10 rows with author and number of publications
	foreach $key (sort byCountAscending keys %authorCount)
	{
		if($rowCount<10)
		{
		print Tr({-border_spacing=>'10px', -padding=>'20px'},
			[	td([$key, $authorCount{$key}])
			]);
		$rowCount++;
		}
	}
print end_table;
}

print "", br(), "\n";
# -----End of Create Table------- #

#end of input validated statements
}

#close html tag
print end_html;
print "\n";

# -----Sources------- #

#How to sort Hash:
#R.L Schwartz, Brian D Foy, T. Phoenix: 
#Learning Perl. O'Reily,2011. ISBN: 978-0-596-52010-6
#http://www.geos.ed.ac.uk/~bmg/software/Perl%20Books/learning_perl.pdf

#How to generate a table:
#Perl: Perl 5 version 20.1 documentation - CGI
#http://perldoc.perl.org/CGI.html#CREATING-THE-HTML-DOCUMENT-HEADER

#How to use CGI
#TutorialsPoint: Perl - CGI Programming. 2017
#https://www.tutorialspoint.com/perl/perl_cgi_programming.htm

# -----End of Sources------- #
