#!/usr/bin/env perl

use Expect;

use strict;

my $tools_dir = config()->{dir};



my $exp = Expect->new;

$exp->spawn("$tools_dir/currency/currency") 
  or die "Cannot spawn command: bash $tools_dir/currency/currency: $!\n";


$exp->expect(120,
           [
                qr/What is the base currency/ => sub {
                     my $exp = shift;
                     $exp->send("USD\n");
                     exp_continue;
                }
           ],
           [
                qr/What currency to exchange to/ => sub {
                     my $exp = shift;
                     $exp->send("RUB\n");
                     exp_continue;
                }
           ],
           [
                qr/What is the amount being exchanged/ => sub {
                     my $exp = shift;
                     $exp->send("0\n");
                     exp_continue;
                }
           ],
          );


$exp->hard_close();


