# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $| = 1; print "1..1\n"; }
END {print "not ok 1\n" unless $loaded;}
use Array::Reform;
$loaded = 1;
print "ok 1\n";

######################### End of black magic.

# Insert your test code below (better if it prints "ok 13"
# (correspondingly "not ok 13") depending on the success of chunk 13
# of the test code):

@orig = ( 1 .. 16 );
$size = 8;
@new = Array::Reform->reform( $size, \@orig );
if ( scalar @new == 2 ) {
  print "ok 2\n";
} else {
  print "not ok 2\n";
}

$size = 4;
@new = Array::Reform->reform( $size, \@orig );
if ( scalar @new == 4 ) {
  print "ok 3\n";
} else {
  print "not ok 3\n";
}

@orig = ( 1 .. 5 );
$size = 2;
@new = Array::Reform->reform( $size, \@orig );
if ( $new[0][1] == 2 && $new[2][0] == 5 ) {
  print "ok 4\n";
} else {
  print "not ok 4\n";
}
