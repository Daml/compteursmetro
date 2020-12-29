SOURCES=$(shell cat sources.geojson | jq .features[].properties.id)
SERIES=$(addprefix data/, $(SOURCES))
CHECKS=$(addsuffix .check.png, $(SERIES))
YEARS=$(addsuffix .years.png, $(SERIES))

all: $(YEARS) $(CHECKS) data/summary.png

data/%.years.png: series/%/daily.csv
	gnuplot -e "filename='$<'" graphs/years.gp > $@

data/%.check.png: series/%/daily.csv
	gnuplot -e "filename='$<'" graphs/check.gp > $@

data/%.summary.csv: series/%/daily.csv
	php scripts/summary.php < $< > $@

data/summary.png: $(addsuffix .summary.csv, $(SERIES))
	gnuplot graphs/summary.gp > $@

clean:
	rm -rf data/*

.PHONY: clean
