console.log("I'm in the worker")
importScripts("egglog_demo.js");

let { run_program } = wasm_bindgen;
async function work() {
  await wasm_bindgen("egglog_demo_bg.wasm");

    // Set callback to handle messages passed to the worker.
    self.onmessage = async event => {
        try {
            logbuffer = [];
            let result = run_program(event.data);
            console.log("Got result from worker", result);
            // Can't send the result directly, since it contains a reference to the
            // wasm memory. Instead, we send the dot and text separately.
            self.postMessage({ dot: result.dot, text: result.text, log: logbuffer, json: result.json });
        } catch (error) {
            console.log(error);
            self.postMessage({ dot: "", text: "Something panicked! Check the console logs...", log: logbuffer, json: "{}" });
        }
    };
}

logbuffer = [];
function log(level, str) {
    logbuffer.push([level, str]);
}

work()
