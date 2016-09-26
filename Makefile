all: source/* config.pl
	make pubs
	make site

site: source/* config.pl
	perl gen.pl config.pl

pubs: bib-piotrm/mardziel.bib config.pl
	perl autopub/gen.pl config.pl

clean:
	rm -Rf build

copy:
	cp -R build/* ../piotrm0.github.io

upload:
	make all
	make copy
	cd ../piotrm0.github.io; \
	git stage -u; \
	git commit . -m "updating website"; \
	git push
