package Array::Reform;

use strict;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK);

use Carp;

require Exporter;

our @ISA = qw(Exporter DynaLoader);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Array::Reform ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
                                   reform
                                   dissect
                                  ) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw();

our $VERSION = '1.04';

# Preloaded methods go here.
sub reform {
  my ($size, $r_list) = &_validate_params;

  my @list = @{$r_list};
  my @lol;

  push @lol, [splice @list, 0, $size] while @list;

  return wantarray ? @lol : \@lol;
}

sub dissect {
  my ($size, $r_list) = &_validate_params;

  my @lol;
  my ($i, $j) = (0, 0);

  foreach (@$r_list) {
    $lol[$i]->[$j] = $_;
    $i = 0, $j++ unless (++$i % $size);
  }

  return wantarray ? @lol : \@lol;
}


# Internal parameter validation function
sub _validate_params {
  # Check we've been called with at least one argument
  Carp::croak( "Called with no arguments" ) if $#_ == -1;

  # First param might be a class (if invoked as a class method). Discard it if so.
  shift if $_[0] =~ /^[a-zA-Z0-9]+ (?: :: [a-zA-Z0-9]+ )$/x;

  # Check we have at least 2 arguments remaining
  Carp::croak( "Called with insufficient arguments" ) if( $#_ < 1 );

  # Next argument is size. check it is a valid positive integer.
  my $size = shift;
  if( $size !~ /^+?\d+$/ ) {
    Carp::croak( "Size '$size' is not a valid positive integer" );
  } elsif( $size == 0 ) {
    Carp::croak( "'$size' is an invalid array size" );
  }

  # If only one argument remains, check to see if it is an arrayref, otherwise, reate a reference to it
  my $r_list;
  if( ($#_ == 0) &&
      (ref($_[0]) eq 'ARRAY') ) {
    $r_list = $_[0];
  } else {
    $r_list = \@_;
  }

  return $size, $r_list;
}

# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__
# Below is the stub of documentation for your module. You better edit it!

=head1 NAME

Array::Reform - Convert an array into N-sized array of arrays.

=head1 SYNOPSIS

  use Array::Reform qw( :all );

  @sample = ( 1 .. 10 );
  $rowsize = 3;

  reform( $rowsize, @sample );
      =>
         (
            [   1,   2,   3   ],
            [   4,   5,   6   ],
            [   7,   8,   9   ],
            [   10   ]
          );

  dissect( $rowsize, @sample );
      =>
         (
            [   1,   5,   9   ],
            [   2,   6,  10   ],
            [   3,   7   ],
            [   4,   8   ]
          );


=head1 DESCRIPTION

Both these methods are designed to reformat a list into a list of
lists. It is often used for formatting data into HTML tables, amongst
other things.

The key difference between the two methods is that C<dissect()> takes
elements from the start of the list provided and pushes them onto each
of the subarrays sequentially, rather than simply dividing the list
into discrete chunks.
As a result C<dissect()> returns a list of lists where the first
element of each sublist will be one of the first elements of the
source list, and the last element will be one of the last.
This behaviour is much more useful when the input list is sorted.

Both methods can be called as either functions or class methods (to
ensure compatibility with previous releases), and the array to be
reformed can be passed as a reference.

=head1 AUTHOR

The original code was written by the Perl Monks user lhoward, with
contributions by adam, swiftone, and crystalflame.

This version was written by kilinrax, with contributions from davorg.

=head1 SEE ALSO

http://perlmonks.org/ --- quick answers to your Perl questions.

=cut
