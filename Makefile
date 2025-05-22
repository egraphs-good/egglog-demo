# Makefile for egglog-demo web build and deploy

.PHONY: all build copy-static clean


all: build copy-static static/examples.json

build: egglog-upstream
	wasm-pack build --target no-modules --no-typescript

copy-static:
	mkdir -p dist
	cp -rf static/* dist/
	cp -rf pkg/* dist/


egglog-upstream:
	git clone https://github.com/egraphs-good/egglog.git $@


static/examples.json: egglog-upstream
	./examples.py $(shell find egglog-upstream/tests -type f -name '*.egg' -not -name '*repro-*') > static/examples.json

clean:
	rm -rf pkg dist egglog-upstream
