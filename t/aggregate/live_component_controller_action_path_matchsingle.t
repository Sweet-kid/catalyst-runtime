#!perl

use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../lib";

our $iters;

BEGIN { $iters = $ENV{CAT_BENCH_ITERS} || 1; }

use Test::More tests => 2*$iters;
use Catalyst::Test 'TestAppMatchSingleArg';

if ( $ENV{CAT_BENCHMARK} ) {
    require Benchmark;
    Benchmark::timethis( $iters, \&run_tests );
}
else {
    for ( 1 .. $iters ) {
        run_tests();
    }
}

sub run_tests {
    {
        is(get('/foo/bar'), 'Path', 'multiple args matched :Path');
        is(get('/foo'), 'Path Args(1)', 'single arg matched :Path Args(1)');
    }
}