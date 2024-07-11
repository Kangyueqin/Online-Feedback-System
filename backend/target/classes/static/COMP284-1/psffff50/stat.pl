#!/usr/bin/perl
#Author: 
#COMP284 Assignment1 perl

use CGI qw(:all *table *Tr *td *th);
use LWP::Simple qw(get);
use XML::Simple;

#html design
print header,
	start_html({-title=>'The DBLP Computer Science Bibliography',-author=>''});
print start_form({-method=>"GET",
		-action=>"http://cgi.csc.liv.ac.uk/cgi-bin/cgiwrap/x6bb/stat.pl"});		
print h1("The DBLP Computer Science Bibliography"), "\n";			
print "Author or topic: ";
print textfield({-name=>'query',-value=>'',-size=>50}),"\n";						
print "MaxHits: ";
print textfield({-name=>'maxHits',-value=>'',-size=>50}), "\n";
print br(),"\n";		
print submit ({-name=>'submit',-value=>'Submit'}),"\n";
				
#check user's input
$q = param('query');
$m = param('maxHits');
if(param('submit')){
	if ($q !~/^[a-zA-Z0-9]+$/s){	
		print "The author or topic you input is invalid, please input again!";
	}elsif($m !~ /^[0-9]*[1-9][0-9]*$/){
		print "The maxhit must be a number over 0, please input again!";
	}else{

#get information from the resource website	
        $content = get("http://www.dblp.org/search/api/?q=$q&h=$m&c=4&f=0&format=xml");
		die "Couldn't get it!" unless defined $content;
   		@name = ($content=~/<author>([^\<]+?)</g);
        @hits = ($content=~/<hits total=\"([^\"]+)/);
        %auHash=(); 
        foreach $author(@name){
            $auHash{$author}++;
			}

#output		
        if(@hits[0] != 0) {
			$i=0;
			$j=0;

#positive order table         
            print start_table({-border=>1,-cellspacing=>1,-cellpadding=>2});
            print Tr(td({-colspan=>"2"},"Ten authors in positive sequence"));
            print Tr(th("Author"),th("Publications"));					
            @order1=sort{$auHash{$b}<=>$auHash{$a}} keys %auHash;
            $array1=$#order1;
			while($i<10){
				print Tr(td($order1[$i]),td($auHash{$order1[$i]}));
				$i++;
				}
            print end_table();
			print br(),"\n";

#inverted order table
            print start_table({-border=>1,-cellspacing=>1,-cellpadding=>2});
            print Tr(td({-colspan=>"2"},"Ten Authors in inverted order"));
            print Tr(th("Author"),th("Publications"));
            @order2=sort{$auHash{$a}<=>$auHash{$b}} keys %auHash;
            $array2=$#order2;
			while($j<10){
				print Tr(td($order2[$j]),td($auHash{$order2[$j]})); 
				$j++;
				}
            print end_table();			
        }
	}		
}
print end_form,end_html;

