sub run_cmd {
  my ($cmd) = @_;
  print "running: $cmd\n";
  return `$cmd`;
}

sub write_file {
  my ($filename, $content) = @_;

  my ($name, $path, $suffix) = fileparse($filename);

  if (! -e $path) {
    run_cmd("mkdir $path");
  }

  print "writing $filename ...\n";

  open (my $fh, ">$filename") or die ("cannot open $filename for writing\n");
  print $fh $content;
  close ($fh);
}

sub make_dir {
  my ($dirname) = @_;
  run_cmd("mkdir -p $dirname");
}

sub get_template {
  my ($filename, $url_root, $site_title) = @_;
  my $template = HTML::Template->new(filename => $filename,
                                     die_on_bad_params => 0,
                                     global_vars       => 1,
                                     loop_context_vars => 1,
                                    );

  $template->param(root      => $url_root,
                   sitetitle => $site_title,
                  );


  return $template;
}

1;
