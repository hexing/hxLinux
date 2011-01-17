#!/usr/bin/perl

use Archive::Zip;
use Encode qw(decode encode);

sub usage {
    print <<USAGE;
USAGE: unzip.pl ZIPFILE [FROMCODE=utf-8 [TOCODE=utf-8]]
USAGE
    exit;
}

usage unless -e $ARGV[0];
$zip = Archive::Zip->new($ARGV[0]);
$from = $ARGV[1] || 'utf-8';
$to = $ARGV[2] || 'utf-8';

for ($zip->memberNames()) {
    $member = $zip->memberNamed($_);
    $_ = encode($to, decode($from, $_));
    $zip->extractMember($member, $_);
}
