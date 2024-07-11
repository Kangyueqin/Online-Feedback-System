#!/usr/bin/perl
use CGI qw(:all);
use LWP::Simple qw(get);
use POSIX;
# This is the HTML form, which is used for user to input information 
print header, "\n", 
   start_html({-title=>'Search in DBLP Computer Science Bibliography'
                  -author=>''}), "\n";
print h1("DBLP Computer Science Bibliography "), "\n";
print start_form({-method=>"POST", 
       -action=>"http://cgi.csc.liv.ac.uk/cgi-bin/cgiwrap/x6cc1/stat.pl"});
print "query: ";
print br(),"\n";
print textfield({-name=>'query',-size=>50}), "\n"; print br(), "\n"; 
print "maxHits:";
print br(),"\n";
print textfield({-name=>'max',-size=>50}), "\n"; print br(), "\n"; 
print submit({-name=>'submit', -value=>'Process'}), "\n";
print end_form;


$query=param('query'); #assign the value of parameter 'query' to the variable 'query'.
$max=param('max');    #assign the value of parameter 'max' to the variable 'query'.
$answer = "http://www.dblp.org/search/api/?q=$query&h=$max&c=4&f=0&format=xml";
#$answer is a website address, which will be used to extract information, variable '$query' and variable 'max' have been put into the URL

if($query eq " "){ #judge whether the $query is an empty string
print "Sorry, the query is empty","\n";
}
$temp=floor($max);  #round up to an integer

 if($max<0){  #make sure $max is greater than or equal to 0
print"Sorry, the maxHits should be greater than or equal to 0","\n";
} elsif($temp!=$max){ #make sure the $max is an integer
print "Sorry, the maxHits should be a integer","\n";
}else{ 
$text=escapeHTML(get($answer));#get all the contents from the URL
$text =~ s/&lt;/</g;  #dispose of '<' from the XML form
$text =~ s/&gt;/>/g; #dispose of '>' from the XML form

@arr;
while ($text=~ /<author>(.*?)<\/author>/g){ #extract names of authors from the $text
  push(@arr,$1);       #put the names into an array
  
}

$size=scalar(@arr);  #$size is the length of array

for($i=0; $i<$size; $i+=1){ #count the number of replication for each name, and then store name and related number into a hash the 'key' is the name, the 'value' is the number  
  $temp=$arr[$i];
  $num=0;
for($j=0; $j<$size; $j+=1){
  $temp2=$arr[$j];
  if($temp eq $temp2){
   $num+=1;
}
  $hash{$arr[$i]}=$num;
}
}
#sort the hash in descending order  according to the value of 'value'
@keys = sort { $hash{$b} <=> $hash{$a} } keys %hash;
$keysSize=@keys-1;# $keysSize is the length of array @keys

if($max!=0){ #insert HTML code to build two tables to hold results of sorting
print <<eof ;
<HTML>
<HEAD>
<TITLE>Title</TITLE>
</HEAD>
<TABLE border=1>
 <TR>
   <TH>authors with most publications</TH><TH>authors with last publications</TH>
 </TR>
 <TR>
   <TD><TABLE border=1>
          <TR><TH>author</TH><TH>number of publications</TH></TR>
          <TR><TD>$keys[0]</TD><TD>$hash{$keys[0]}</TD></TR>
          <TR><TD>$keys[1]</TD><TD>$hash{$keys[1]}</TD></TR>
          <TR><TD>$keys[2]</TD><TD>$hash{$keys[2]}</TD></TR>
          <TR><TD>$keys[3]</TD><TD>$hash{$keys[3]}</TD></TR>
          <TR><TD>$keys[4]</TD><TD>$hash{$keys[4]}</TD></TR>
          <TR><TD>$keys[5]</TD><TD>$hash{$keys[5]}</TD></TR>
          <TR><TD>$keys[6]</TD><TD>$hash{$keys[6]}</TD></TR>
          <TR><TD>$keys[7]</TD><TD>$hash{$keys[7]}</TD></TR>
          <TR><TD>$keys[8]</TD><TD>$hash{$keys[8]}</TD></TR>
          <TR><TD>$keys[9]</TD><TD>$hash{$keys[9]}</TD></TR>
        </TABLE>
   </TD>
   <TD><TABLE border=1>
             <TR><TH>author</TH><TH>number of publications</TH></TR>
             <TR><TD>$keys[$keysSize]</TD><TD>$hash{$keys[$keysSize]}</TD></TR>
             <TR><TD>$keys[$keysSize-1]</TD><TD>$hash{$keys[$keysSize-1]}</TD></TR>
             <TR><TD>$keys[$keysSize-2]</TD><TD>$hash{$keys[$keysSize-2]}</TD></TR>
             <TR><TD>$keys[$keysSize-3]</TD><TD>$hash{$keys[$keysSize-3]}</TD></TR>
             <TR><TD>$keys[$keysSize-4]</TD><TD>$hash{$keys[$keysSize-4]}</TD></TR>
             <TR><TD>$keys[$keysSize-5]</TD><TD>$hash{$keys[$keysSize-5]}</TD></TR>
             <TR><TD>$keys[$keysSize-6]</TD><TD>$hash{$keys[$keysSize-6]}</TD></TR>
             <TR><TD>$keys[$keysSize-7]</TD><TD>$hash{$keys[$keysSize-7]}</TD></TR>
             <TR><TD>$keys[$keysSize-8]</TD><TD>$hash{$keys[$keysSize-8]}</TD></TR>
             <TR><TD>$keys[$keysSize-9]</TD><TD>$hash{$keys[$keysSize-9]}</TD></TR>
        </TABLE>
   </TD> 
<TR>
</TABLE>
</BODY>
</HTML>

eof

}else{
    print"No result","\n";#if the $query is 0
}
}

print end_html; 

