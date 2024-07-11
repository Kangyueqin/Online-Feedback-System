#!/usr/bin/perl

use strict;
use warnings;
use LWP::UserAgent;

use CGI;
use CGI::Carp qw/fatalsToBrowser/;

my $q = CGI->new;

print $q->header;
print $q->start_html;

if ( $q->request_method eq 'POST' ) {
    get_and_display_result($q);
}
else {
    output_form($q);
}

print $q->end_html;

###################################################
#  This will create input form for user type in search keywords and max number of publications 
#################################################### 

sub output_form {
    my ( $q, $errmsg ) = @_;

    print $q->h2($errmsg) if $errmsg;

    print $q->start_form( -name => 'query_form', -method => 'POST' );
    print $q->start_table;
    print $q->Tr( $q->td('Keywords'),                   $q->td( $q->textfield( -name => 'query' ) ), );
    print $q->Tr( $q->td('Max Number of Publications'), $q->td( $q->textfield( -name => 'maxHits' ) ), );
    print $q->Tr( $q->td( $q->submit( -value => 'Submit' ) ), $q->td(''), );
    print $q->end_table;
    print $q->end_form;
}

###########################################
#  This function will do:
#  1: Check the validation of the input
#  2：  Build search url
#  3: Get xml data from url
#  4: Retrive total publications and authors information and save authors information into a hash
#  5: Display the results according to given requirements
#############################################

sub get_and_display_result {
    my $q       = shift;
    my $query   = $q->param('query');
    my $maxHits = $q->param('maxHits');

# check if query keywords are empty
    unless ( defined $query && length($query) > 0 ) {
        return output_form( $q, 'keyword should be NON EMPTY' );
    }

# check if maxHits is a 0 or positive integer
    unless ( $maxHits =~ /^\d+$/ ) {
        return output_form( $q, 'Max Number of Publications should be 0 or positive integer' );
    }

# build URL to retrive xml data
    my $ua = LWP::UserAgent->new;
    my $res = $ua->get( sprintf 'http://www.dblp.org/search/api/?q=%s&h=%s&c=4&f=0&format=xml', $query, $maxHits );

    unless ( $res && $res->is_success ) {
        return output_form( $q, 'Query url fail!' );
    }

    output_form($q);
    print "<hr>";

#   Process xml data using module XML::Simple
    require XML::Simple;
    my $xs = XML::Simple->new;

    my $ref = $xs->XMLin( $res->content );

    my $items = 0;
    my $authors = {};
    foreach my $hit ( keys %{ $ref->{hits}->{hit} } ) {
        my $book = $ref->{hits}->{hit}->{$hit};
        $items++;
        if ( ref $book->{info}->{authors}->{author} eq 'ARRAY' ) {
            map { $authors->{$_}++ } @{ $book->{info}->{authors}->{author} };
        }
        else {
            $authors->{ $book->{info}->{authors}->{author} }++;
        }
    }

    my @sorted;
    map { push @sorted, { author => $_, books => $authors->{$_} } } ( sort { $authors->{$b} <=> $authors->{$a} || $a cmp $b } ( keys %$authors ) );

    my $result_rows = scalar @sorted;

    print $q->h2( sprintf 'Your search contains %s publications', $items );
    return unless $items;

#  Display results in required format
    print qq~
<table style="width:100%" border="1">
  <tr>
    <td colspan="2">10 Authors with most publications</th>
    <td colspan="2">10 Authors with least publications</th>
  </tr>
~;

    print qq~
<tr>
    <th>Author</th>
    <th>No of publications</th>
    <th>Author</th>
    <th>No of publications</th>
</tr>
~;

    my ( $top_index, $least_index, $max_rows ) = ( 0, -10, 9 );
    if ( $result_rows < $max_rows ) {
        $max_rows    = $result_rows - 1;
        $least_index = -($result_rows);
    }

    while ( $top_index <= $max_rows ) {
        print qq~<tr>~;
        print sprintf( '<td>%s</td><td>%s</td>', $sorted[$top_index]->{author},   $sorted[$top_index]->{books} );
        print sprintf( '<td>%s</td><td>%s</td>', $sorted[$least_index]->{author}, $sorted[$least_index]->{books} );
        print qq~</tr>~;
        $top_index++;
        $least_index++;
    }

    print qq~</table>~;
}
