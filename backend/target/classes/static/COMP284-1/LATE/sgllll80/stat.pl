#!/usr/bin/perl
# Author: 
# ID:
# COMP284 Assignment 1: Perl and CGI 2016/2017

use CGI qw(:all);
use LWP::Simple qw(get);
use XML::Simple;
use Data::Dumper;
		
print header, "\n",
start_html({-title=>'COMP284 Assignment 1: Perl and CGI',
-author=>''}), "\n";

#Title
print h1("COMP284 Assignment 1: Perl and CGI"), "\n";

#Input query and maxHits
print h2("Please input your query and Maximal Number of Hits"), "\n";

print start_form(
{-action=>"http://cgi.csc.liv.ac.uk/cgi-bin/cgiwrap/x5zz2/stat.pl"});
#input query
print p("query:"), "\n";
print input(
{-type=>'text',
-name=>'query',
-size=>50}), "\n";
#input maxHits
print p("maximal Number of Hits:"), "\n";
print input(
{-type=>'text',
-name=>'maxHits',
-size=>50}),"\n";
print br(), "\n";
print br(), "\n";
print input(
{-type=>'submit',
-value=>'Submit'}), "\n";

#progress input data
if (param('query')&&param("maxHits")) {
	#get query and maxHits
	$query=param('query');
	print p("query: ".$query), "\n";
	$maxHits=param('maxHits');
	print p("maxHits: ".$maxHits), "\n";

	#check user's input
	$checkQuery=0;
	$checkMaxHits=0;
	if($query=~/\b\d+\b/){
		print p('Error, The query must be non-empty stinrg'), "\n";
		$checkQuery=0;
	}else{
		$checkQuery=1;
	}
	if($maxHits=~/^[0-9]*[1-9][0-9]*$/){
		$checkMaxHits=1
	}else{
		print p('Error, The maxHits is a natural number greater or equal to zero.'), "\n";
		$checkMaxHits=0;
	}
	if($checkQuery==1&&$checkMaxHits==1){

	#	$url='http://dblp.org/search/publ/api?q=couffignal&h=20&c=4&f=0&format=xml';
		$url='http://dblp.org/search/publ/api?q=';
		$url=$url.$query;
		$url=$url.'&h=';
		$url=$url.$maxHits;
		$url=$url.'&c=4&f=0&format=xml';
		
		print p("URL: ".$url), "\n";
		$xml = XMLin(get $url,ForceArray=>1);
	#	$xml = XMLin(get $url);
		print Dumper($xml);

	#	foreach $key (keys %$xml){
	#		print p("$key\n");}
	
	#	foreach $key (keys %$xml){
	#		print p("$key\n");
	#		$subXml=$xml{$key};
	#		foreach $subKey(keys %subXml){
	#			print p("$key\n");}}
		
	#	foreach $key (keys %$xml){
	#		print p($xml->{$key});}	

		foreach $key (keys %$xml){
			print p($xml->{$key});}
			
		foreach $key (keys %$xml){
			print p("$key");}
			
	#it seems $subXml=$xml->{$key} cannot work, assigning $key's value cannot work also			
	#	foreach $key (keys %$xml){
	#		print p("$key\n");
	#		$subXml=$xml->{$key};
	#		foreach $subKey(keys %subXml){
	#			print p("$key\n");}}
	
		#print output table
		$no=0;
		print p("The script is expected to show the XML data retrieved from the DBLP, an indication that this XML data contains ", $publications, " publications, and the following two tables:"), "\n";
		print table(
			{-style=>{-border-collapse=>collapse},
			-border=>1},
			caption('two tables'),
			Tr([
			td({-colspan=>"2"},['10 Authors with most publications' , '10 Authors with least publications']),		
			th(['Author' , 'No of publications', 'Author' , 'No of publications']),
			td(['AuthorX' , $no, 'AuthorX' , $no]),
			td(['AuthorX' , $no, 'AuthorX' , $no]),
			td(['AuthorX' , $no, 'AuthorX' , $no]),
			td(['AuthorX' , $no, 'AuthorX2' , $no]),
			])
			);
	}
		
}else{
	#Error message of empty input
	print p('The input field is empty now, please input vaild text'), "\n";
}

print end_form, end_html;