# Makefile for egglog-demo web build and deploy

.PHONY: all build clean


all: build dist

build: egglog-upstream
	wasm-pack build --target no-modules --no-typescript

dist: static/examples.json
	mkdir -p  $@
	cp -rf static/*  $@
	cp -rf pkg/*  $@


egglog-upstream:
	git clone https://github.com/egraphs-good/egglog.git $@


static/examples.json: egglog-upstream
	./examples.py $(shell find egglog-upstream/tests -type f -name '*.egg' -not -name '*repro-*') > static/examples.json

clean:
	rm -rf pkg dist egglog-upstream
