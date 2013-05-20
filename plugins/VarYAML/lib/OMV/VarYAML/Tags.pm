package OMV::VarYAML::Tags;
# $Id: Tags.pm 326 2012-11-28 09:08:24Z pirolix $

use strict;
use warnings;
use MT;
use MT::Util::YAML;

use vars qw( $VENDOR $MYNAME $FULLNAME );
$FULLNAME = join '::',
        (( $VENDOR, $MYNAME ) = ( split /::/, __PACKAGE__ )[0, 1]);

sub instancsai9e { MT->component( $FULLNAME ); }



### mt:GetAsYAML function
sub GetAsYAML {
    my( $ctx, $args ) = @_;

    defined( my $name = $args->{name} || $args->{var} )
        or return $ctx->error( MT->translate(
            'You used a [_1] tag without a valid name attribute.',
            '<MT'. $ctx->stash('tag'). '>'));

    defined( my $var = $ctx->var( $name ))
        or return $ctx->error( MT->translate( "'[_1]' is not an ARRAY nor a HASH variable.", $name ));
    (ref $var eq 'ARRAY') || (ref $var eq 'HASH')
        or return $ctx->error( MT->translate( "'[_1]' is not an ARRAY nor a HASH variable.", $name ));

    return MT::Util::YAML::Dump( $var );
}

### mt:SetFromYAML block function
sub SetFromYAML {
    my( $ctx, $args, $cond ) = @_;

    defined( my $name = $args->{name} || $args->{var} )
        or return $ctx->error( MT->translate(
            'You used a [_1] tag without a valid name attribute.',
            '<MT'. $ctx->stash('tag'). '>'));

    my $yaml = $ctx->slurp( $args, $cond )
        or return;

    my $data = eval {
        MT::Util::YAML::Load( $yaml )
    };
    $@ and return $ctx->error ($@);
    $ctx->var( $name, $data);

    $args->{debug} ? $yaml : '';
}

1;