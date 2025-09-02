# Makefile for egglog-demo web build and deploy

.PHONY: all build clean


all: build dist

build: egglog-upstream experimental-upstream tutorial-upstream
	RUSTFLAGS='--cfg getrandom_backend="wasm_js"' wasm-pack build --target no-modules --no-typescript

dist: static/examples.json static/ pkg/
	mkdir -p  $@
	cp -rf static/*  $@
	cp -rf pkg/*  $@


egglog-upstream:
	git clone https://github.com/egraphs-good/egglog.git --depth 1 $@

experimental-upstream:
	git clone https://github.com/egraphs-good/egglog-experimental.git --depth 1 $@

tutorial-upstream:
	git clone https://github.com/egraphs-good/egglog-tutorial.git --depth 1 $@

static/examples.json: egglog-upstream experimental-upstream tutorial-upstream
	./examples.py \
		$(shell find       egglog-upstream/tests/web-demo -type f -name '*.egg') \
		$(shell find experimental-upstream/tests/web-demo -type f -name '*.egg') \
		$(shell find     tutorial-upstream                -type f -name '*.egg') \
		> static/examples.json

clean:
	rm -rf pkg dist egglog-upstream experimental-upstream tutorial-upstream
