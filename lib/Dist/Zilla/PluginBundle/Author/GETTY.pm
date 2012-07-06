package Dist::Zilla::PluginBundle::Author::GETTY;
BEGIN {
  $Dist::Zilla::PluginBundle::Author::GETTY::AUTHORITY = 'cpan:GETTY';
}
{
  $Dist::Zilla::PluginBundle::Author::GETTY::VERSION = '0.001';
}
# ABSTRACT: BeLike::GETTY when you build your dists

use Moose;
use Moose::Autobox;
use Dist::Zilla 2.100922; # TestRelease
with 'Dist::Zilla::Role::PluginBundle::Easy';


use Dist::Zilla::PluginBundle::Basic;
use Dist::Zilla::PluginBundle::Git;

has manual_version => (
  is      => 'ro',
  isa     => 'Bool',
  lazy    => 1,
  default => sub { $_[0]->payload->{manual_version} },
);

has major_version => (
  is      => 'ro',
  isa     => 'Int',
  lazy    => 1,
  default => sub { $_[0]->payload->{version} || 0 },
);

has is_task => (
  is      => 'ro',
  isa     => 'Bool',
  lazy    => 1,
  default => sub { $_[0]->payload->{task} },
);

has weaver_config => (
  is      => 'ro',
  isa     => 'Str',
  lazy    => 1,
  default => sub { $_[0]->payload->{weaver_config} || '@Author::GETTY' },
);

sub configure {
  my ($self) = @_;

  $self->log_fatal("you must not specify both weaver_config and is_task")
    if $self->is_task and $self->weaver_config ne '@Author::GETTY';

  $self->add_bundle('@Basic');

  unless ($self->manual_version) {
    if ($self->is_task) {
      my $v_format = q<{{cldr('yyyyMMdd')}}>
                   . sprintf('.%03u', ($ENV{N} || 0));

      $self->add_plugins([
        AutoVersion => {
          major     => $self->major_version,
          format    => $v_format,
        }
      ]);
    } else {
      $self->add_plugins([
        'Git::NextVersion' => {
          version_regexp => '^([0-9]+\.[0-9]+)$',
        }
      ]);
    }
  }

	$self->add_plugins(qw(
		PkgVersion
		MetaConfig
		MetaJSON
		PodSyntaxTests
		Repository
		GithubMeta
	));

	$self->add_plugins([
		'InstallRelease' => {
			install_command => 'cpanm .',
		}
	]);

	$self->add_plugins([
		'Authority' => {
			authority => 'cpan:GETTY',
			do_metadata => 1,
		}
	]);

  $self->add_plugins(
    [ Prereqs => 'TestMoreWithSubtests' => {
      -phase => 'test',
      -type  => 'requires',
      'Test::More' => '0.96'
    } ],
  );

  $self->add_plugins([
    'ChangelogFromGit' => {
      max_age => 99999,
      tag_regexp => '^v(.+)$',
      file_name => 'Changes',
      wrap_column => 74,
      debug => 0,
    }
  ]);

  if ($self->is_task) {
    $self->add_plugins('TaskWeaver');
  } else {
    $self->add_plugins([
      PodWeaver => { config_plugin => $self->weaver_config }
    ]);
  }

  $self->add_bundle('@Git' => {
    tag_format => '%v',
    push_to    => [ qw(origin) ],
  });
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__
=pod

=head1 NAME

Dist::Zilla::PluginBundle::Author::GETTY - BeLike::GETTY when you build your dists

=head1 VERSION

version 0.001

=head1 DESCRIPTION

This is the plugin bundle that GETTY uses.  It is equivalent to:

  [@Basic]

  [Git::NextVersion]
  [PkgVersion]
  [MetaConfig]
  [MetaJSON]
  [NextRelease]
  [PodSyntaxTests]
  [GithubMeta]
  [InstallRelease]
  install_command = cpanm .

  [Authority]
  authority = cpan:GETTY
  do_metadata = 1

  [PodWeaver]
  config_plugin = @GETTY

  [Repository]

  [@Git]
  tag_format = %v
  push_to = origin

If the C<task> argument is given to the bundle, PodWeaver is replaced with
TaskWeaver and Git::NextVersion is replaced with AutoVersion.  If the
C<manual_version> argument is given, AutoVersion is omitted. 

=head1 AUTHOR

Torsten Raudssus <torsten@raudss.us> L<http://www.raudss.us/>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Torsten Raudssus L<http://www.raudss.us/>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

