"""Stub pipeline for ingesting Jira issues into the Rimidi KG."""

from __future__ import annotations

import csv
import pathlib
from typing import Iterable, Dict

ROOT = pathlib.Path(__file__).resolve().parents[2]
DATA_OUT = ROOT / "data" / "sourced" / "jira_issues.csv"


def transform(rows: Iterable[Dict[str, str]]) -> Iterable[Dict[str, str]]:
    """Translate Jira export rows into KG-ready payloads.

    Expected CSV columns: key, summary, labels, status, component, updated.
    """

    for row in rows:
        yield {
            "id": row["key"].lower(),
            "summary": row["summary"],
            "labels": row.get("labels", ""),
            "status": row.get("status", ""),
            "component": row.get("component", ""),
            "updated": row.get("updated", ""),
        }


def run(input_path: pathlib.Path) -> None:
    with input_path.open("r", encoding="utf-8") as handle:
        reader = csv.DictReader(handle)
        rows = list(transform(reader))

    DATA_OUT.parent.mkdir(parents=True, exist_ok=True)
    with DATA_OUT.open("w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=rows[0].keys() if rows else [])
        writer.writeheader()
        writer.writerows(rows)
    print(f"Wrote {len(rows)} Jira rows to {DATA_OUT}")


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description="Ingest Jira export into KG staging")
    parser.add_argument("csv", type=pathlib.Path, help="Path to Jira CSV export")
    args = parser.parse_args()
    run(args.csv)
