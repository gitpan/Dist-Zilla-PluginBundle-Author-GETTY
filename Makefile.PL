
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "BeLike::GETTY when you build your dists",
  "AUTHOR" => "Torsten Raudssus <torsten\@raudss.us> L<http://www.raudss.us/>",
  "BUILD_REQUIRES" => {
    "Test::LoadAllModules" => "0.021",
    "Test::More" => "0.98"
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "Dist-Zilla-PluginBundle-Author-GETTY",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "Dist::Zilla::PluginBundle::Author::GETTY",
  "PREREQ_PM" => {
    "App::cpanminus" => "1.5021",
    "Dist::Zilla" => "1.092990",
    "Dist::Zilla::Plugin::Authority" => "1.006",
    "Dist::Zilla::Plugin::BumpVersionFromGit" => "0.009",
    "Dist::Zilla::Plugin::ChangelogFromGit" => "0.006",
    "Dist::Zilla::Plugin::GithubMeta" => "0.28",
    "Dist::Zilla::Plugin::InstallRelease" => "0.007",
    "Dist::Zilla::Plugin::MakeMaker::SkipInstall" => "1.100",
    "Dist::Zilla::Plugin::PodWeaver" => "3.101641",
    "Dist::Zilla::Plugin::Repository" => "0.19",
    "Dist::Zilla::Plugin::Run" => "0.014",
    "Dist::Zilla::Plugin::TaskWeaver" => "0.101624",
    "Dist::Zilla::Plugin::UploadToDuckPAN" => "0.001",
    "Dist::Zilla::PluginBundle::Git" => "2.008",
    "Pod::Elemental" => "0.092970",
    "Pod::Elemental::Transformer::List" => "0.101620",
    "Pod::Weaver" => "3.100310"
  },
  "VERSION" => "0.010",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



