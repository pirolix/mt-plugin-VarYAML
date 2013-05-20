package MT::Plugin::Util::OMV::VarYAML;
# VarYAML (C) 2013 Piroli YUKARINOMIYA (Open MagicVox.net)
# This program is distributed under the terms of the GNU Lesser General Public License, version 3.
# $Id: PluginTemplate.pl 339 2013-05-19 08:50:29Z pirolix $



use strict;
use warnings;
use MT 5;

use vars qw( $VENDOR $MYNAME $FULLNAME $VERSION );
$FULLNAME = join '::',
        (($VENDOR, $MYNAME) = (split /::/, __PACKAGE__)[-2, -1]);
(my $revision = '$Rev: 339 $') =~ s/\D//g;
$VERSION = 'v0.10'. ($revision ? ".$revision" : '');

use base qw( MT::Plugin );
my $plugin = __PACKAGE__->new ({
    # Basic descriptions
    id => $FULLNAME,
    key => $FULLNAME,
    name => $MYNAME,
    version => $VERSION,
    author_name => 'Open MagicVox.net',
    author_link => 'http://www.magicvox.net/',
    plugin_link => 'http://www.magicvox.net/archive/2013/05202107/', # Blog
    doc_link => "http://lab.magicvox.net/trac/mt-plugins/wiki/$MYNAME", # tracWiki
    description => <<'HTMLHEREDOC',
<__trans phrase="Supply template tags for conversions between a variable and YAML data stream.">
HTMLHEREDOC
    l10n_class => "${FULLNAME}::L10N",

    # Registry
    registry => {
        tags => {
            help_url => "http://lab.magicvox.net/trac/mt-plugins/wiki/$MYNAME#tag-%t",
            function => {
                GetAsYAML => "${FULLNAME}::Tags::GetAsYAML",
            },
            block => {
                SetFromYAML => "${FULLNAME}::Tags::SetFromYAML",
            },
        },
    },
});
MT->add_plugin ($plugin);

sub instance { $plugin; }

1;
