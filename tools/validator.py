"""Lightweight validation helpers for the Rimidi knowledge graph repository."""

from __future__ import annotations

import argparse
import pathlib
from typing import Iterable

ROOT = pathlib.Path(__file__).resolve().parents[1]


def ensure_exists(paths: Iterable[pathlib.Path]) -> None:
    missing = [path for path in paths if not path.exists()]
    if missing:
        joined = "\n".join(str(path) for path in missing)
        raise SystemExit(f"Missing required files:\n{joined}")


def validate_schema() -> None:
    ensure_exists(
        [
            ROOT / "schema" / "node_types.yaml",
            ROOT / "schema" / "relationships.yaml",
            ROOT / "schema" / "attributes.yaml",
        ]
    )


def validate_data() -> None:
    ensure_exists(
        [
            ROOT / "data" / "seed.cypher",
            ROOT / "data" / "business_logic.yaml",
            ROOT / "data" / "infra.yaml",
        ]
    )


def main() -> None:
    parser = argparse.ArgumentParser(description="Validate Rimidi KG repository structure")
    parser.add_argument("--schema", action="store_true", help="Validate schema artifacts")
    parser.add_argument("--data", action="store_true", help="Validate data artifacts")
    args = parser.parse_args()

    if not (args.schema or args.data):
        args.schema = True
        args.data = True

    if args.schema:
        validate_schema()
    if args.data:
        validate_data()

    print("Validation passed.")


if __name__ == "__main__":
    main()
