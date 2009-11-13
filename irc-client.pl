#!/usr/bin/env perl
use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";

use YAML qw(LoadFile);
use Getopt::Std;

my %opts;
getopt('cph', \%opts);
die "Usage: $0 -c /path/to/config.yml\n" unless $opts{c};
require Social::Application;

my $app = Social::Application->app(config => LoadFile($opts{c}));

if ($0 eq __FILE__) {
    require Tatsumaki::Server;
    Tatsumaki::Server->new(
        port => $opts{p} || 9999,
        host => $opts{h},
    )->run($app);
}
else {
    return $app;
}
