package Array::Reform;

use strict;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK);

use Carp qw( croak );

require Exporter;

@ISA = qw(Exporter AutoLoader);
# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.
@EXPORT_OK = qw(
	reform
);

$VERSION = '1.03';

# Preloaded methods go here.
sub reform ($$\@) {
  my ($class, $size, $r_list) = @_;
  croak "Invalid array size" if $size < 1;

  my @list = @{$r_list};
  my @lol;

  push @lol, [splice @list, 0, $size] while @list;

  return wantarray ? @lol : \@lol;
}

sub dissect ($$\@) {
  my ($class, $size, $r_list) = @_;
  croak "Invalid array size" if $size < 1;

  my @lol;
  my ($i, $j) = (0, 0);

  foreach (@$r_list) {
    $lol[$i]->[$j] = $_;
    $i = 0, $j++ unless (++$i % $size);
  }

  return @lol;
}

# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__
# Below is the stub of documentation for your module. You better edit it!

=head1 NAME

Array::Reform - Convert an array into N-sized array of arrays

=head1 SYNOPSIS

  use Array::Reform;

  @sample = ( 1 .. 10 );
  $rowsize = 3;

  Array::Reform->reform( $rowsize, \@sample );
      =>
         (
            [   1,   2,   3   ],
            [   4,   5,   6   ],
            [   7,   8,   9   ],
            [   10   ]
          );

  Array::Reform->dissect( $rowsize, \@sample );
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

The key difference between the two methods is that T<dissect()> takes
elements from the start of the list provided and pushes them onto each
of the subarrays sequentially, rather than simply dividing the list
into discrete chunks.
As a result T<dissect()> returns a list of lists where the first
element of each sublist will be one of the first elements of the
source list, and the last element will be one of the last.
This behaviour is much more useful when the input list is sorted.

=head1 AUTHOR

The original code was written by the Perl Monks user L<lhoward|LHOWARD>, with
contributions by adam, swiftone, and crystalflame. It was uploaded by
L<princepawn|TBONE>.

This version was written by L<kilinrax|KILINRAX>, with contributions from L<davorg|DAVECROSS>.

=head1 SEE ALSO

http://perlmonks.org/ --- quick answers to your Perl questions.

=cut
