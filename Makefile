# Makefile for egglog-demo web build and deploy

.PHONY: all build clean

all: build dist

build: tutorial-upstream
	RUSTFLAGS='--cfg getrandom_backend="wasm_js"' wasm-pack build --target no-modules --no-typescript

dist: static/examples.json static/ pkg/
	mkdir -p  $@
	cp -rf static/*  $@
	cp -rf pkg/*  $@

tutorial-upstream:
	git clone https://github.com/egraphs-good/egglog-tutorial.git --depth 1 $@

static/examples.json: tutorial-upstream
	./examples.py  > $@

clean:
	rm -rf pkg dist tutorial-upstream static/examples.json
