pubs: bib-piotrm/mardziel.bib autopub.config.pl
	perl autopub/gen.pl autopub.config.pl

clean:
	rm -Rf pubs
