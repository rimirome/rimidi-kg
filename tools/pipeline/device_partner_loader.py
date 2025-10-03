"""Stub pipeline for loading device partner metadata into the KG."""

from __future__ import annotations

import json
import pathlib
from typing import Dict, List

ROOT = pathlib.Path(__file__).resolve().parents[2]
DATA_OUT = ROOT / "data" / "sourced" / "device_partners.json"


def build_payload(partners: List[Dict[str, str]]) -> Dict[str, List[Dict[str, str]]]:
    """Return payload ready for downstream Cypher generation."""
    return {"integrations": partners}


def run(input_path: pathlib.Path) -> None:
    with input_path.open("r", encoding="utf-8") as handle:
        partners = json.load(handle)

    payload = build_payload(partners)
    DATA_OUT.parent.mkdir(parents=True, exist_ok=True)
    DATA_OUT.write_text(json.dumps(payload, indent=2), encoding="utf-8")
    print(f"Wrote device partner payload to {DATA_OUT}")


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description="Normalize device partner metadata")
    parser.add_argument("json", type=pathlib.Path, help="Path to a JSON partner listing")
    args = parser.parse_args()
    run(args.json)
