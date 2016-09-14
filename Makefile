all: source/* config.pl
	make pubs
	make site

site: source/* config.pl
	perl gen.pl config.pl

pubs: bib-piotrm/mardziel.bib config.pl
	perl autopub/gen.pl config.pl

clean:
	rm -Rf build

