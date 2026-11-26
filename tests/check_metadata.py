#!/usr/bin/env python3
"""Validate the multivitamin metadata and the highlighting markers.

Checks, for the whole catalog:
  - multivitamin.json, every feature.json, and every lesson.json against schema/
  - every feature listed in multivitamin.json exists, and its feature.json id
    matches the folder name
  - every example has exactly one script, a lesson.json naming it, expected.txt,
    and a README.md
  - `# region: x` / `# endregion: x` markers are balanced, not nested, and unique
  - each `# focus: expr` sits inside a region, and expr appears on a code line
    of that region
  - every region a lesson names exists in the source, and every region in the
    source is used by some step
  - every step api is in the feature's covers, and every covers entry is used

Usage: python3 tests/check_metadata.py   (needs `pip install jsonschema`)
"""

import json
import re
import sys
from pathlib import Path

from jsonschema import Draft202012Validator

ROOT = Path(__file__).resolve().parent.parent
MARKER = re.compile(r"^\s*#\s*(region|endregion|focus):\s*(.*?)\s*$")
SCRIPT_SUFFIXES = {".zsh", ".sh", ".bash"}

errors: list[str] = []


def fail(where: Path, message: str) -> None:
    errors.append(f"{where.relative_to(ROOT)}: {message}")


def load(path: Path, schema_name: str):
    schema = json.loads((ROOT / "schema" / schema_name).read_text())
    try:
        document = json.loads(path.read_text())
    except (OSError, json.JSONDecodeError) as problem:
        fail(path, f"cannot read JSON ({problem})")
        return None
    for issue in Draft202012Validator(schema).iter_errors(document):
        location = "/".join(str(part) for part in issue.absolute_path) or "(root)"
        fail(path, f"{location}: {issue.message}")
    return document


def parse_regions(script: Path) -> dict[str, list[str]]:
    """Return {region name: code lines inside it} and record marker errors."""
    regions: dict[str, list[str]] = {}
    pending_focus: dict[str, list[str]] = {}
    open_name = None
    for number, line in enumerate(script.read_text().splitlines(), start=1):
        marker = MARKER.match(line)
        if not marker:
            if open_name is not None:
                regions[open_name].append(line)
            continue
        kind, value = marker.groups()
        where = f"line {number}"
        if kind == "region":
            if open_name is not None:
                fail(script, f"{where}: region {value!r} opens inside {open_name!r}")
            if value in regions:
                fail(script, f"{where}: region {value!r} is defined twice")
            open_name = value
            regions[value] = []
            pending_focus[value] = []
        elif kind == "endregion":
            if value != open_name:
                fail(script, f"{where}: endregion {value!r} does not close {open_name!r}")
            open_name = None
        else:
            if open_name is None:
                fail(script, f"{where}: focus {value!r} is outside any region")
            else:
                pending_focus[open_name].append(value)
    if open_name is not None:
        fail(script, f"region {open_name!r} is never closed")
    for name, focuses in pending_focus.items():
        for focus in focuses:
            if not any(focus in code for code in regions[name]):
                fail(script, f"focus {focus!r} does not appear in region {name!r}")
    for name, code in regions.items():
        if not any(line.strip() for line in code):
            fail(script, f"region {name!r} has no code")
    return regions


def check_example(example: Path, covers: set[str], used_apis: set[str]) -> None:
    scripts = [p for p in example.iterdir() if p.suffix in SCRIPT_SUFFIXES]
    if len(scripts) != 1:
        fail(example, f"expected exactly one script, found {[p.name for p in scripts]}")
        return
    script = scripts[0]
    for required in ("expected.txt", "README.md", "lesson.json"):
        if not (example / required).is_file():
            fail(example, f"missing {required}")
    lesson = load(example / "lesson.json", "lesson.schema.json")
    if lesson is None:
        return
    if lesson.get("source") != script.name:
        fail(example / "lesson.json", f"source is {lesson.get('source')!r}, script is {script.name!r}")
    regions = parse_regions(script)
    referenced = set()
    for index, step in enumerate(lesson.get("steps", []), start=1):
        api = step.get("api")
        used_apis.add(api)
        if api not in covers:
            fail(example / "lesson.json", f"step {index} api {api!r} is not in feature.json covers")
        for region in step.get("regions", []):
            name = region["name"].split("#")[-1]
            referenced.add(name)
            if name not in regions:
                fail(example / "lesson.json", f"step {index} names region {name!r}, not in {script.name}")
    for unused in sorted(set(regions) - referenced):
        fail(script, f"region {unused!r} is not used by any lesson step")


def main() -> int:
    manifest = load(ROOT / "multivitamin.json", "multivitamin.schema.json")
    if manifest is None:
        return report()
    on_disk = sorted(p.name for p in (ROOT / "features").iterdir() if p.is_dir())
    if on_disk != sorted(manifest["features"]):
        fail(ROOT / "multivitamin.json", f"features {manifest['features']} do not match folders {on_disk}")
    for folder in manifest["features"]:
        feature_dir = ROOT / "features" / folder
        feature = load(feature_dir / "feature.json", "feature.schema.json")
        if feature is None:
            continue
        if feature["feature"] != folder[3:]:
            fail(feature_dir / "feature.json", f"feature {feature['feature']!r} should be {folder[3:]!r}")
        if feature["covers"] != sorted(feature["covers"]):
            fail(feature_dir / "feature.json", "covers should be sorted")
        covers = set(feature["covers"])
        used_apis: set[str] = set()
        examples = sorted(p for p in feature_dir.iterdir() if p.is_dir())
        for example in examples:
            check_example(example, covers, used_apis)
        for unused in sorted(covers - used_apis):
            fail(feature_dir / "feature.json", f"covers {unused!r} but no step teaches it")
    return report()


def report() -> int:
    if errors:
        print("\n".join(errors))
        print(f"\n{len(errors)} metadata problem(s)")
        return 1
    print("metadata ok")
    return 0


if __name__ == "__main__":
    sys.exit(main())
