# Contributing to Rimidi KG

## Schema Changes
1. Propose updates in `schema/` (node types, relationships, attributes) and capture rationale in `schema/changelog.md` with a version bump.
2. Run `tools/validator.py --schema` to confirm the structure remains consistent.
3. When introducing new relationship verbs, update `ai/prompt_context.md` and `ai/examples.md` so Skye/Sunny know how to reference them.
4. Update `docs/ontology.md` with definitions for new labels or relationship types, and record responsible teams/owners.

## Data Updates
1. Modify `data/infra.yaml`, `data/business_logic.yaml`, or supporting files to add services, domains, integrations, feeders, analytics surfaces, release-note components, or governance tags.
2. Ensure identifiers follow slug-style conventions (for example, `service-rimidi-container`).
3. When mapping product release notes, include `release_date` metadata so downstream automations trace source material.
4. Validate with `tools/validator.py --data` before opening a pull request.
5. Record notable data ecosystem changes in `docs/CHANGELOG.md` for downstream consumers.
6. Include provenance metadata (`source_system`, `jira_id`, `release_note`) where applicable so temporal and policy reasoning remains auditable.

## AI Context & Automation
1. Keep `ai/prompt_context.md` aligned with the latest schema terminology and guardrails across Skye, Sunny, and Luna.
2. Add representative examples to `ai/examples.md` when introducing new intents or node types so Skye/Sunny stay calibrated.
3. Update `ai/faq.md` with guidelines for Skye’s alias coverage, Sunny’s Cypher guardrails, and Luna’s documentation follow-ups (human reviewers still own PR creation).
4. When automations require additional Cypher snippets, store them in `queries/` for review.

## Working with Seeds & Governance
1. Include PHI sensitivity, access role, access mode, and data purpose tags for domains, collections, feeders, seeds, and analytics surfaces.
2. If tags fall outside the enumerations in `schema/attributes.yaml`, document the addition and update the allowed lists.
3. Reference the source-of-truth documentation (runbooks, diagrams) in descriptions so future contributors can trace the rationale.

## Ontology Governance
- Review ontology changes (`docs/ontology.md`) during the monthly Product/Engineering sync to keep terminology aligned.
- Promote ontology versions alongside schema releases (e.g., v0.4 → v0.5) and reference the version in PR descriptions.
- Keep experimental labels (`Policy`, `Actor`, temporal attributes) marked in the ontology until productionized.
