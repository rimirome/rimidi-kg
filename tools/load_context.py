"""Utility to assemble Sunny's modular prompt from the repo."""

from __future__ import annotations

import argparse
from pathlib import Path
from typing import Iterable

ROOT = Path(__file__).resolve().parents[1]
BASE_PROMPT = ROOT / "ai" / "prompts" / "base_prompt_sunny.md"
CONTEXT_DIR = ROOT / "ai" / "context"
CONTEXT_MAP = {
    "product": CONTEXT_DIR / "product.md",
    "platform": CONTEXT_DIR / "platform_architecture.md",
    "platform_architecture": CONTEXT_DIR / "platform_architecture.md",
    "shared": CONTEXT_DIR / "shared_crm.md",
    "shared_crm": CONTEXT_DIR / "shared_crm.md",
}


def read_file(path: Path) -> str:
    try:
        return path.read_text(encoding="utf-8").strip()
    except FileNotFoundError as exc:
        raise SystemExit(f"Missing required prompt asset: {path}") from exc


def resolve_contexts(keys: Iterable[str]) -> list[str]:
    contents: list[str] = []
    seen: set[Path] = set()
    for key in keys:
        norm = key.lower().strip()
        path = CONTEXT_MAP.get(norm)
        if not path:
            available = ", ".join(sorted(CONTEXT_MAP))
            raise SystemExit(f"Unknown context '{key}'. Available: {available}")
        if path in seen:
            continue
        contents.append(read_file(path))
        seen.add(path)
    return contents


def load_history_text(history_path: str | None) -> str:
    if not history_path:
        return ""
    path = Path(history_path)
    try:
        text = path.read_text(encoding="utf-8").strip()
    except FileNotFoundError as exc:
        raise SystemExit(f"History file not found: {history_path}") from exc
    return text


def main() -> None:
    parser = argparse.ArgumentParser(description="Assemble Sunny prompt context")
    parser.add_argument(
        "--subgraph",
        dest="subgraphs",
        action="append",
        help="Subgraph context to include (product, platform, shared). Repeatable.",
    )
    parser.add_argument(
        "--history",
        dest="history_path",
        help="Optional path to a file containing serialized chat history.",
    )
    parser.add_argument(
        "--alias-summary",
        dest="alias_summary_path",
        help="Optional path to a file containing Lexi alias resolution notes.",
    )
    args = parser.parse_args()

    pieces: list[str] = [read_file(BASE_PROMPT)]
    if args.subgraphs:
        pieces.extend(resolve_contexts(args.subgraphs))
    history_text = load_history_text(args.history_path)
    if history_text:
        pieces.append(history_text)
    alias_summary = load_history_text(args.alias_summary_path)
    if alias_summary:
        pieces.append(alias_summary)

    output = "\n\n".join(segment for segment in pieces if segment)
    print(output)


if __name__ == "__main__":
    main()
