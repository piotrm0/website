use Cwd;
use lib cwd;

if (scalar(@ARGV) != 1) {
  die "Configuration file not specified."
} else {
  require $ARGV[0];
}

my $URL_ROOT   = $Autopub::Config::URL_ROOT;
my $SITE_TITLE = $Autopub::Config::SITE_TITLE;

my $DIR_TARGET = $Config::DIR_BUILD;
my $DIR_SOURCE = $Config::DIR_SOURCE;

use HTML::Template;
use File::Basename;
use YAML;

use Data::Dumper;
use strict;

require 'util.pl';

setup_dirs();

my @files = @{gen_from_templates()};

foreach my $pair (@files) {
  my $filename = $pair->{filename};
  my $content  = $pair->{content};
  write_file($filename, $content);
}

sub gen_from_templates {
  opendir(my $dir, $DIR_SOURCE);
  my @files = grep(/\.html\.tmpl$/, readdir($dir));
  closedir($dir);

  my $ret = [];

  foreach my $file (@files) {
    my $basename = ($file =~ m/^(.*?)\.html\.tmpl$/)[0];

    my $t = get_template($DIR_SOURCE . "/" . $file,
                         $URL_ROOT,
                         $SITE_TITLE);

    for my $par ($t->param()) {
	if ($par =~ m/^data_(.*?)$/i) {
	    my $data = $1;
	    my $dfile = "$data.yaml";
	    if (-e $dfile) {
		my $params = YAML::LoadFile($dfile);
		print "filling parameter $par from $dfile ...\n";
		print "  read a/an " . ref($params) . "...\n";
		$t->param($par => $params);
	    } else {
		die("cannot find datafile $dfile needed for generating $file\n")
	    }
	}
    }

    push (@$ret, {filename => "$DIR_TARGET/$basename.html",
                  content  => $t->output()});
  }

  return $ret;
}

sub rel_url {
  my ($loc) = @_;

  if ($URL_ROOT eq "") {
    return $loc;
  } elsif ($URL_ROOT =~ m/^.+\/$/) {
    return $URL_ROOT . $loc;
  } else {
    return $URL_ROOT . "/" . $loc;
  }
}

sub setup_dirs {
  my @dirs = ($DIR_TARGET,
              $DIR_TARGET . "/images",
              $DIR_TARGET . "/docs",
              $DIR_TARGET . "/css");

  foreach my $dir (@dirs) {
    if (! -e $dir) {
      make_dir($dir);
    }
  }

  foreach my $dir ("images", "css", "docs") {
    run_cmd("cp -R $DIR_SOURCE/$dir/* $DIR_TARGET/$dir/");
  }

}
