package Koha::Plugin::Com::BibLibre::IntranetVersionInHeader;

use Modern::Perl;

use base qw(Koha::Plugins::Base);

use C4::Context;

our $VERSION = '1.0';

our $metadata = {
    name   => 'Intranet version in header',
    author => 'BibLibre',
    description => 'Display Koha version in staff interface header',
    date_authored   => '2021-01-13',
    date_updated    => '2021-01-13',
    minimum_version => '18.11',
    maximum_version => undef,
    version         => $VERSION,
};

sub new {
    my ( $class, $args ) = @_;

    $args->{'metadata'} = $metadata;
    $args->{'metadata'}->{'class'} = $class;

    my $self = $class->SUPER::new($args);

    return $self;
}

# Mandatory even if does nothing
sub install {
    my ( $self, $args ) = @_;
 
    return 1;
}
 
# Mandatory even if does nothing
sub upgrade {
    my ( $self, $args ) = @_;
 
    return 1;
}
 
# Mandatory even if does nothing
sub uninstall {
    my ( $self, $args ) = @_;
 
    return 1;
}

sub intranet_js {
    my ( $self ) = @_;

    my $kohaversion = Koha::version();
    my $link='https://koha-community.org/category/release/';
    my $content = qq|<li id='koha-plugin-src-version'><a target='_blank' href='$link' style='color:#538200'>Koha $kohaversion</a></li>|;
    return q|
<script>
    $(document).ready(function(){
        $("#header #toplevelmenu").append("|.$content.q|");
    });
</script>
|;
}

1;
