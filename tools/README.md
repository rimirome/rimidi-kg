# Tooling

Helper scripts and notebooks for validating and exporting Rimidi KG assets.

## Contents
- `validator.py` - primary CLI for schema/data validation (`--schema`, `--data`).
- `auto_schema_diff.py` - compares regenerated schema YAML to highlight contract changes.
- `loader.py` / `load_context.py` - assemble prompts or datasets for local testing.
- `pipeline/` - stubs for integrating new data sources into the KG pipeline.
- `export.ipynb` - exploratory notebook for ad-hoc exports.

## Key Assumptions
- Validators must run cleanly before PRs merge; capture output when reviewing changes.
- Scripts are intended for local or CI use and should avoid hard-coded credentials.
- `load_context.py` emits Sunny's prompt payload and expects optional alias summaries from Skye.
- Extend notebooks judiciously - keep derived datasets under version control if they inform governance decisions.
