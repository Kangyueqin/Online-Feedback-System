#!/usr/bin/perl
# My first CGI Perl assignment
<a href="http://cgi.csc.liv.ac.uk/cgi-bin/cgiwrap/<u5aa>/stat.pl"> </a>


use CGI qw(:all);
local ($buffer, @pairs, $pair, $name, $value, %FORM);
# Read in text
$ENV{'REQUEST_METHOD'} =~ tr/a-z/A-Z/;
if ($ENV{'REQUEST_METHOD'} eq "GET")
{
   $buffer = $ENV{'QUERY_STRING'};
}
# Split information into name/value pairs
@pairs = split(/&/, $buffer);
foreach $pair (@pairs)
{
   ($name, $value) = split(/=/, $pair);
   $value =~ tr/+/ /;
   $value =~ s/%(..)/pack("C", hex($1))/eg;
   $FORM{$name} = $value;
}
$query = $FORM{query};
$maxHits  = $FORM{maxHits};

print "Content-type:text/html\r\n\r\n";
print "<html>";
print "<head>";
print "<title> Biblography </title>";
print "</head>";
print "<body>";
print "<h2>Biblography $query $maxHits </h2>";
print "</body>";
print "</html>";

<FORM action="/cgi-bin/assignment1.cgi" method="GET">
Author or Topic: <input type="text" name="query">  <br>

Number of Publications: <input type="text" name="maxHits">
<input type="submit" value="Submit">
</FORM>
