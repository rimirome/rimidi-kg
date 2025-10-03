# Contributing to Rimidi KG

## Schema Changes
1. Propose updates in `schema/` (node types, relationships, or attributes).
2. Update `schema/changelog.md` with the rationale and version bump.
3. Run `tools/validator.py --schema` to confirm consistency.

## Data Updates
1. Modify `data/seed.cypher` for structural changes, or add new YAML data sources.
2. Ensure identifiers follow slug-style conventions.
3. Validate with `tools/validator.py --data` before opening a pull request.

## AI Context
1. Keep `ai/prompt_context.md` aligned with the latest schema terminology.
2. Add representative examples to `ai/examples.md` when introducing new intents.
3. Update `ai/rules.json` if agent guardrails need to shift.
