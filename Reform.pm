package Array::Reform;

use strict;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK);

require Exporter;

@ISA = qw(Exporter AutoLoader);
# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.
@EXPORT = qw(
);
$VERSION = '1.0';


# Preloaded methods go here.
sub Reform {
  my $class=shift;
  my $size=shift;                   
  my @list=@_;                      
  my @nlist=();                     
  my $max=int(scalar(@list)/$size); 
  for (my $c=0;$c<=$max;$c++) {       
    my $a=$c*$size;                 
    my $b=($c+1)*$size-1;           
    if ($b>=scalar(@list)) {          
      $b=scalar(@list)-1;           
    }                               
    if ($a<=$b) {                     
      push @nlist,[@list[$a..$b]];  
    }                               
  }                                 
  return @nlist;                    
}
# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__
# Below is the stub of documentation for your module. You better edit it!

=head1 NAME

Array::Reform - Convert an array into N-sized array of arrays

=head1 SYNOPSIS

  use Array::Reform;

  Array::Reform->Reform( $size, (1..10) );
      => 
         (
            [              1,              2,              3            ],
            [              4,              5,              6            ],
            [              7,              8,              9            ],
            [              10            ]
          );


=head1 DESCRIPTION

Ever had a list of things you needed to neetly format into a set of 
HTML table rows? Well, look no further my friend. For the low, low price 
of 0.00 you too can reform you data into a neet set of lists and produce
tables from it.

=head1 AUTHOR

lhoward at www.perlmonks.org wrote this. I merely uploaded it. many thanks
to adam and swiftone for their solutions (also on Perl Monks).

=head1 SEE ALSO

http://www.perlmonks.org --- quick answers to your Perl questions.

=cut
