package Koha::Plugin::Com::BibLibre::IntranetVersionInHeader;

use Modern::Perl;

use base qw(Koha::Plugins::Base);

use C4::Context;

our $VERSION = '1.2';

our $metadata = {
    name   => 'Intranet version in header',
    author => 'BibLibre',
    description => 'Display Koha version and search engine in staff interface header',
    date_authored   => '2021-01-13',
    date_updated    => '2022-11-29',
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

    my $version_string = Koha::version();
    my ( $major, $minor, $maintenance, $development ) = split( '\.', $version_string );
    $maintenance .= q|.| . $development unless $development eq '000';

    my $searchengine = C4::Context->preference('SearchEngine');

    # <li><a> is for styling like other links in header
    my @content = (
        q|<li id="koha-plugin-version-in-header"><a href="#">|,
        qq|<span>$major.$minor</span>|,
        qq|<span style="color:#777777;font-weight:normal">.$maintenance</span>|,
        qq|</span> - $searchengine</span>|,
        q|</a></li>|
    );
    return q|
<script>
    $(document).ready(function(){
        $("#header #toplevelmenu").append('|.join(q||,@content).q|');
    });
</script>
|;
}

1;
