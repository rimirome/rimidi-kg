"""Lightweight validation helpers for the Rimidi knowledge graph repository."""

from __future__ import annotations

import argparse
import pathlib
from typing import Iterable

try:
    import yaml  # type: ignore
except ImportError:
    yaml = None

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


def validate_infra_structure() -> None:
    if yaml is None:
        raise SystemExit("PyYAML not installed. Run `pip install pyyaml` before validating data.")

    path = ROOT / "data" / "infra.yaml"
    ensure_exists([path])
    payload = yaml.safe_load(path.read_text())

    required_sections = [
        "use_cases",
        "services",
        "infra_services",
        "domains",
        "collections",
        "feeders",
        "analytics_surfaces",
        "seeds",
        "relationships",
    ]
    missing_sections = [section for section in required_sections if section not in payload]
    if missing_sections:
        joined = ", ".join(missing_sections)
        raise SystemExit(f"data/infra.yaml missing sections: {joined}")

    def collect_ids(section: str) -> set[str]:
        return {item["id"] for item in payload.get(section, []) if "id" in item}

    id_map = {
        "use_cases": collect_ids("use_cases"),
        "services": collect_ids("services"),
        "infra_services": collect_ids("infra_services"),
        "domains": collect_ids("domains"),
        "collections": collect_ids("collections"),
        "feeders": collect_ids("feeders"),
        "analytics_surfaces": collect_ids("analytics_surfaces"),
        "seeds": collect_ids("seeds"),
    }

    domain_ids = id_map["domains"]
    for collection in payload.get("collections", []):
        domain_ref = collection.get("domain")
        if domain_ref and domain_ref not in domain_ids:
            raise SystemExit(
                f"Collection {collection.get('id')} references unknown domain {domain_ref}"
            )

    known_ids = set().union(*id_map.values())
    for rel in payload.get("relationships", []):
        source = rel.get("source")
        target = rel.get("target")
        if source not in known_ids:
            raise SystemExit(f"Relationship {rel} has unknown source {source}")
        if target not in known_ids:
            raise SystemExit(f"Relationship {rel} has unknown target {target}")


def validate_data() -> None:
    ensure_exists(
        [
            ROOT / "data" / "seed.cypher",
            ROOT / "data" / "business_logic.yaml",
            ROOT / "data" / "infra.yaml",
        ]
    )
    validate_infra_structure()


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
