
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "BeLike::GETTY when you build your dists",
  "AUTHOR" => "Torsten Raudssus <torsten\@raudss.us> L<http://www.raudss.us/>",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "Dist-Zilla-PluginBundle-Author-GETTY",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "Dist::Zilla::PluginBundle::Author::GETTY",
  "PREREQ_PM" => {
    "App::cpanminus" => "1.6002",
    "Dist::Zilla" => "4.300030",
    "Dist::Zilla::Plugin::Alien" => "0.007",
    "Dist::Zilla::Plugin::Authority" => "1.006",
    "Dist::Zilla::Plugin::BumpVersionFromGit" => "0.009",
    "Dist::Zilla::Plugin::ChangelogFromGit" => "0.006",
    "Dist::Zilla::Plugin::Git::CheckFor::CorrectBranch" => "0.006",
    "Dist::Zilla::Plugin::GithubMeta" => "0.28",
    "Dist::Zilla::Plugin::InstallRelease" => "0.008",
    "Dist::Zilla::Plugin::MakeMaker::SkipInstall" => "1.100",
    "Dist::Zilla::Plugin::PodWeaver" => "3.101641",
    "Dist::Zilla::Plugin::Repository" => "0.19",
    "Dist::Zilla::Plugin::Run" => "0.018",
    "Dist::Zilla::Plugin::TaskWeaver" => "0.101624",
    "Dist::Zilla::Plugin::TravisCI" => 0,
    "Dist::Zilla::Plugin::UploadToDuckPAN" => "0.002",
    "Dist::Zilla::PluginBundle::Git" => "2.009",
    "Pod::Elemental" => "0.102362",
    "Pod::Elemental::Transformer::List" => "0.101620",
    "Pod::Weaver" => "3.101638"
  },
  "TEST_REQUIRES" => {
    "Test::LoadAllModules" => "0.021",
    "Test::More" => "0.96"
  },
  "VERSION" => "0.015",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  my $tr = delete $WriteMakefileArgs{TEST_REQUIRES};
  my $br = $WriteMakefileArgs{BUILD_REQUIRES};
  for my $mod ( keys %$tr ) {
    if ( exists $br->{$mod} ) {
      $br->{$mod} = $tr->{$mod} if $tr->{$mod} > $br->{$mod};
    }
    else {
      $br->{$mod} = $tr->{$mod};
    }
  }
}

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



