SOURCES=$(addsuffix .csv, $(addprefix data/, $(shell grep '_' sources.dat | cut -d ' ' -f 1)))

all: combined.csv

data/%.raw:
	./fetch.sh $(shell basename $(@F) | cut -d'_' -f 1) $(shell basename $(@F) | cut -d'_' -f 2|cut -d'.' -f 1) > $@

data/%.csv: data/%.raw
	php parse.php < $< > $@

combined.csv: $(SOURCES)
	php combine.php $^ > $@
