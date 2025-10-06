# KG Readiness Checklist

Use this checklist before loading new data, promoting schema changes, or turning on new automations. It gathers the assumptions, guardrails, and recommended improvements we discussed so you can verify the repo and live KG stay in sync.

## 1. Vocabulary & Schema
- [ ] Proposed concepts are defined in `docs/ontology.md` (label, description, owning team).
- [ ] `schema/node_types.yaml` and `schema/relationships.yaml` reflect the ontology update.
- [ ] Governance attributes (`valid_from`, `valid_to`, `source_system`, `jira_id`, `release_note`) are present where required.
- [ ] `schema/changelog.md` has a new entry explaining the change.
- [ ] Validator changes (if needed) are implemented in `tools/validator.py`.

## 2. Documentation & Guardrails
- [ ] `docs/README.md`, `docs/CONTRIBUTING.md`, and `docs/playbook.md` mention the new concept or process change.
- [ ] Ownership expectations are captured (who owns the capability/service/domain).
- [ ] Provenance requirements are spelled out (link to release note/Jira/ADR).

## 3. Data & Automations
- [ ] `data/` YAML/Cypher files are updated with provenance fields populated.
- [ ] `ai/prompt_context.md`, `ai/examples.md`, and `ai/faq.md` include the updated terminology and examples.
- [ ] Relevant queries in `queries/` cover the new edges/nodes.
- [ ] Pipelines (`tools/pipeline/`) or loaders are updated/stubbed for any new data source.
- [ ] `python tools/validator.py --schema --data` passes locally (or via Docker).

## 4. Live KG & Operations
- [ ] Neo4j/Aura environment is seeded with the latest `data/seed.cypher` (or equivalent loader output).
- [ ] KG health automation (n8n) is still green (counts, orphan checks, sync timestamps).
- [ ] If PHI is involved, confirm PHI guardrails are respected (segregated nodes, prompts exclude PHI).

## SME Inputs Needed for Write Operations
Before Sunny or n8n generates write Cypher, provide:
- Target node/edge details (label, stable `id`, human-readable name/description).
- Ownership metadata (`owner_team`, approver/actor if relevant).
- Provenance fields (`source_system`, `jira_id`, `release_note`, `added_at`).
- Environment and tenant context (production/staging, specific tenant ids).
- Business context or expected behaviour so related knowledge articles/policies can link back to documentation.
- Explicit confirmation when an update replaces or deletes existing relationships/data.

## 5. Recommended Enhancements (Backlog)
Track these items and check them off as they are implemented:
- [ ] Temporal events modeled (`Event` node/edges) with `valid_from` / `valid_to` populated in data.
- [ ] Ownership edges enforced (`OWNS` / `RESPONSIBLE_FOR`), validator fails when missing.
- [ ] Canonical relationship allowlist lint in place (rejects unregistered edge types).
- [ ] NL→Cypher regression tests running in CI for Sunny/n8n prompts.
- [ ] PHI checks in validator (blocks PHI leakage into AI contexts).
- [ ] Daily/weekly KG health workflow posts metrics to Slack.
- [ ] Tenant/environment separation modeled explicitly (`Tenant`, `Environment`).
- [ ] Export tooling produces Neo4j + alternative formats (CSV/Parquet) to avoid platform lock-in.
- [ ] Visualization presets (Bloom or similar) published for stakeholders.
- [ ] Trigger policy for migrating to Neptune defined and documented.

Keep this file updated as the graph matures so you always have a single place to review readiness before major changes or audits.
