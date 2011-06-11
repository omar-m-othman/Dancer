package Dancer::Serializer::Dumper;
# ABSTRACT: Data::Sumper serializer engine 

use strict;
use warnings;
use Carp;
use base 'Dancer::Serializer::Abstract';
use Data::Dumper;

sub from_dumper {
    my ($string) = @_;
    my $s = Dancer::Serializer::Dumper->new;
    $s->deserialize($string);
}

sub to_dumper {
    my ($data) = @_;
    my $s = Dancer::Serializer::Dumper->new;
    $s->serialize($data);
}

sub serialize {
    my ($self, $entity) = @_;
    {
        local $Data::Dumper::Purity = 1;
        return Dumper($entity);
    }
}

sub deserialize {
    my ($self, $content) = @_;
    my $res = eval "my \$VAR1; $content";
    croak "unable to deserialize : $@" if $@;
    return $res;
}

sub content_type {'text/x-data-dumper'}

1;
