use strict;

package Config;

our $URL_ROOT   = "file:///Users/piotrm/github/website/build";
our $SITE_TITLE = "Piotr (Peter) Mardziel";

our $DIR_BUILD  = "build";
our $DIR_SOURCE = "source";

package Autopub::Config;

#our $URL_ROOT   = "http://piotr.mardziel.com/pubs";
#our $URL_ROOT   = "";
our $URL_ROOT   = $Config::URL_ROOT . "/pubs/";
our $SITE_TITLE = $Config::SITE_TITLE;

our $DIR_TARGET        = $Config::DIR_BUILD . "/pubs/";
our $DIR_SOURCE        = "autopub/source";
our $DIR_SOURCE_COMMON = "autopub/source-common";

our $FILE_SOURCE_BIB   = "bib-piotrm/mardziel.bib";

our $DEFAULT_AUTHOR_ICON  = "$URL_ROOT/graphics/author.gif";
our $DEFAULT_PROJECT_ICON = "$URL_ROOT/graphics/project.png";
