# Makefile for egglog-demo web build and deploy

.PHONY: all build clean


all: build dist

build: upstream
	RUSTFLAGS='--cfg getrandom_backend="wasm_js"' wasm-pack build --target no-modules --no-typescript

dist: static/examples.json
	mkdir -p  $@
	cp -rf static/*  $@
	cp -rf pkg/*  $@

upstream:
	git clone https://github.com/egraphs-good/egglog.git              --depth 1 egglog-upstream
	git clone https://github.com/egraphs-good/egglog-experimental.git --depth 1 experimental-upstream

static/examples.json: upstream
	./examples.py \
		$(shell find egglog-upstream/tests/web-demo -type f -name '*.egg') \
		$(shell find experimental-upstream/tests    -type f -name '*.egg') \
		> static/examples.json

clean:
	rm -rf pkg dist egglog-upstream experimental-upstream
