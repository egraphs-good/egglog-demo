#!/usr/bin/env python3

import json
import sys
from pathlib import Path
import subprocess

metadata_process = subprocess.run(
    ["cargo", "metadata", "--format-version", "1", "-q"],  # noqa: S607
    capture_output=True,
    check=True,
)

root_paths = [
    Path(package["manifest_path"]).parent / "tests" / "web-demo"
    for package in json.loads(metadata_process.stdout)["packages"]
    if package["name"] in ["egglog", "egglog-experimental"]
]
root_paths.append(Path(__file__).parent / "tutorial-upstream")
egg_paths = [egg for path in root_paths for egg in path.glob("**/*.egg")]
result = {path.stem: path.read_text() for path in egg_paths}
json.dump(result, sys.stdout, indent=2)
