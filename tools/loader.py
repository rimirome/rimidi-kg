"""Utility to transform YAML schema/data files into Cypher statements."""

from __future__ import annotations

import argparse
import json
import pathlib
from typing import Any, Dict

ROOT = pathlib.Path(__file__).resolve().parents[1]


def load_yaml(path: pathlib.Path) -> Dict[str, Any]:
    import yaml  # Local import to avoid hard dependency if unused.

    with path.open("r", encoding="utf-8") as handle:
        return yaml.safe_load(handle)


def main() -> None:
    parser = argparse.ArgumentParser(description="Generate Cypher from Rimidi KG YAML sources")
    parser.add_argument("--schema", action="store_true", help="Include schema definitions in output")
    parser.add_argument("--data", action="store_true", help="Include data payloads in output")
    args = parser.parse_args()

    if not (args.schema or args.data):
        parser.error("Specify at least one of --schema or --data")

    payload: Dict[str, Any] = {}
    if args.schema:
        payload["node_types"] = load_yaml(ROOT / "schema" / "node_types.yaml")
        payload["relationships"] = load_yaml(ROOT / "schema" / "relationships.yaml")
        payload["attributes"] = load_yaml(ROOT / "schema" / "attributes.yaml")
    if args.data:
        payload["business_logic"] = load_yaml(ROOT / "data" / "business_logic.yaml")
        payload["infra"] = load_yaml(ROOT / "data" / "infra.yaml")

    print(json.dumps(payload, indent=2, default=str))


if __name__ == "__main__":
    main()
