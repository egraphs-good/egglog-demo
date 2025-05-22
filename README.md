# egglog-demo

This repository contains the web demo for [egglog](https://github.com/egraphs-good/egglog), a e-graph library for equality saturation and term rewriting. The web demo allows users to interactively run and visualize egglog programs in the browser.

## Features

- Run egglog programs in your browser
- Visualize e-graphs and outputs interactively
- No server required—everything runs client-side via WebAssembly

## Building and Running Locally

### Prerequisites

- [Rust](https://www.rust-lang.org/tools/install)
- [wasm-pack](https://rustwasm.github.io/wasm-pack/)

### Steps

1. **Clone the repository** (if you haven’t already):

   ```fish
   git clone https://github.com/egraphs-good/egglog-demo.git
   cd egglog-demo
   ```

2. **Install wasm-pack** (if not already installed):

   ```fish
   curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh
   ```

3. **Build the WebAssembly package and copy static files:**

   ```fish
   make all
   ```

   This will generate the necessary `.wasm` and JS files in the `pkg/` directory and copy everything to `dist/`.

4. **Serve the static files:**

   You can use any static file server. For example, with Python:

   ```fish
   cd dist
   python3 -m http.server 8080
   ```

   Then open [http://localhost:8080](http://localhost:8080) in your browser.

## Repository Structure

- `src/` — Rust source code for the WebAssembly module
- `static/` — Static files for the web demo (HTML, JS, CSS)
- `examples.py` — Script to bundle example `.egg` files as JSON for the demo
- `egglog-upstream/` — Local clone of the upstream [egglog](https://github.com/egraphs-good/egglog) repo (ignored by git)

## Examples

The web demo loads its example programs from the `tests` directories of the upstream [egglog](https://github.com/egraphs-good/egglog). These are automatically downloaded and bundled into a JSON file (`static/examples.json`) by running:

```fish
make static/examples.json
```

This ensures the demo always uses the latest official and experimental egglog examples. If you want to add or update examples, edit them in the upstream repos and re-run the above command.

## License

This project is licensed under the MIT License.
