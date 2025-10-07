"""Compare schema files across git references and emit a JSON diff summary."""

from __future__ import annotations

import argparse
import json
import subprocess
from dataclasses import dataclass
from pathlib import Path
from typing import Dict, List
import difflib

REPO_ROOT = Path(__file__).resolve().parents[1]
SCHEMA_FILES = [
    "docs/ontology.md",
    "schema/node_types.yaml",
    "schema/relationships.yaml",
    "schema/attributes.yaml",
]


def run_git_show(ref: str, path: str) -> str:
    result = subprocess.run(
        ["git", "show", f"{ref}:{path}"],
        cwd=REPO_ROOT,
        check=False,
        capture_output=True,
        text=True,
    )
    if result.returncode != 0:
        raise SystemExit(result.stderr.strip() or f"Failed to read {path} at {ref}")
    return result.stdout


@dataclass
class BlockDiff:
    added: List[str]
    removed: List[str]
    modified: List[str]


def extract_blocks(text: str, key: str) -> Dict[str, str]:
    """Extract top-level list blocks keyed by ``key`` (e.g., ``name`` or ``type``)."""

    blocks: dict[str, str] = {}
    current_name: str | None = None
    current_lines: list[str] = []
    block_indent: int | None = None
    key_prefix = f"- {key}:"

    def flush() -> None:
        nonlocal current_name, current_lines, block_indent
        if current_name is not None:
            blocks[current_name] = "\n".join(current_lines).strip()
        current_name = None
        current_lines = []
        block_indent = None

    for line in text.splitlines():
        stripped = line.lstrip()
        indent = len(line) - len(stripped)

        if stripped.startswith(key_prefix) and indent <= 2:
            flush()
            current_name = stripped.split(":", 1)[1].strip()
            block_indent = indent if indent else 0
            continue

        if stripped.startswith("- ") and indent <= (block_indent if block_indent is not None else 2) and not stripped.startswith(key_prefix):
            flush()
            continue

        if current_name is None:
            continue

        if stripped == "":
            current_lines.append(line)
            continue

        if indent <= (block_indent if block_indent is not None else 0):
            flush()
            continue

        current_lines.append(line)

    flush()
    return blocks


def extract_node_entries(text: str) -> Dict[str, str]:
    return extract_blocks(text, "name")


def extract_relationship_entries(text: str) -> Dict[str, str]:
    return extract_blocks(text, "type")


def extract_attribute_names(text: str) -> Dict[str, str]:
    sections: dict[str, str] = {}
    current_section: str | None = None
    current_lines: list[str] = []
    for line in text.splitlines():
        if line.startswith("  ") and not line.startswith("    ") and line.strip().endswith(":"):
            if current_section is not None:
                sections[current_section] = "\n".join(current_lines).strip()
                current_lines = []
            current_section = line.strip().rstrip(":")
        elif current_section is not None:
            current_lines.append(line)
    if current_section is not None:
        sections[current_section] = "\n".join(current_lines).strip()
    return sections


def diff_blocks(before: Dict[str, str], after: Dict[str, str]) -> BlockDiff:
    before_keys = set(before)
    after_keys = set(after)
    added = sorted(after_keys - before_keys)
    removed = sorted(before_keys - after_keys)
    modified = sorted(name for name in before_keys & after_keys if before[name] != after[name])
    return BlockDiff(added, removed, modified)


def ontology_diff(text_a: str, text_b: str) -> str:
    diff_lines = list(
        difflib.unified_diff(
            text_a.splitlines(),
            text_b.splitlines(),
            fromfile="ontology-ref-a",
            tofile="ontology-ref-b",
            lineterm="",
            n=2,
        )
    )
    if not diff_lines:
        return ""
    snippet = diff_lines[:400]
    return "\n".join(snippet)


def main() -> None:
    parser = argparse.ArgumentParser(description="Emit JSON summary of schema differences between refs")
    parser.add_argument("--ref-a", required=True, help="Base git ref (e.g., main)")
    parser.add_argument("--ref-b", required=True, help="Comparison git ref (e.g., schema-dev)")
    parser.add_argument("--output", help="Optional file to write the JSON to")
    args = parser.parse_args()

    node_before = extract_node_entries(run_git_show(args.ref_a, "schema/node_types.yaml"))
    node_after = extract_node_entries(run_git_show(args.ref_b, "schema/node_types.yaml"))
    node_diff = diff_blocks(node_before, node_after)

    rel_before = extract_relationship_entries(run_git_show(args.ref_a, "schema/relationships.yaml"))
    rel_after = extract_relationship_entries(run_git_show(args.ref_b, "schema/relationships.yaml"))
    rel_diff = diff_blocks(rel_before, rel_after)

    attr_before = extract_attribute_names(run_git_show(args.ref_a, "schema/attributes.yaml"))
    attr_after = extract_attribute_names(run_git_show(args.ref_b, "schema/attributes.yaml"))
    attr_diff = diff_blocks(attr_before, attr_after)

    ontology_before = run_git_show(args.ref_a, "docs/ontology.md")
    ontology_after = run_git_show(args.ref_b, "docs/ontology.md")

    payload = {
        "ref_a": args.ref_a,
        "ref_b": args.ref_b,
        "node_types": {
            "added": node_diff.added,
            "removed": node_diff.removed,
            "modified": node_diff.modified,
        },
        "relationships": {
            "added": rel_diff.added,
            "removed": rel_diff.removed,
            "modified": rel_diff.modified,
        },
        "attributes": {
            "added": attr_diff.added,
            "removed": attr_diff.removed,
            "modified": attr_diff.modified,
        },
        "ontology_diff": ontology_diff(ontology_before, ontology_after),
    }

    output_text = json.dumps(payload, indent=2)
    if args.output:
        Path(args.output).write_text(output_text, encoding="utf-8")
    print(output_text)


if __name__ == "__main__":
    main()
