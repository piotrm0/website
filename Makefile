site: source/* config.pl
	perl gen.pl config.pl
	make pubs

pubs: bib-piotrm/mardziel.bib config.pl
	perl autopub/gen.pl config.pl

clean:
	rm -Rf build

