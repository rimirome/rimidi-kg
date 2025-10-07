# Rimidi Knowledge Graph Repository

The Rimidi knowledge graph has been reinitialized around the dual-plane architecture described in `data/rimidi_kg_review_master_v2.csv`. This repository is the single authority for schema, ontology, prompts, and governance workflows consumed by Sunny (query plane) and Luna (authoring plane).

## Dual-Plane Overview
| Plane | Agent | Responsibility | Access Role | Primary Endpoint |
| --- | --- | --- | --- | --- |
| Query | Sunny · gpt-4o-mini | Natural-language to Cypher translation, read-only reasoning, query safety checks | `neo4j_reader` | `/query` |
| Authoring | Luna · n8n workflow | Schema and ontology authoring, governance automation, pull request generation | `neo4j_writer` | `/cypher` |

Working agreements:
- Every structural change (nodes, relationships, attributes, ontology text) starts in Git and is validated before reaching production.
- Sunny must never mutate the KG; Luna executes approved write operations via governed playbooks.
- The schema in `schema/` and ontology in `docs/ontology.md` are regenerated directly from `data/rimidi_kg_review_master_v2.csv` and represent the source of truth.
- All PHI-adjacent identifiers remain redacted in examples; use sanitized sample IDs from the schema when crafting prompts or seed data.

## Canonical Artifacts
- `data/rimidi_kg_review_master_v2.csv` — master review sheet that enumerates every node label and relationship used in the refreshed ontology.
- `schema/node_types.yaml`, `schema/relationships.yaml`, `schema/attributes.yaml` — generated definitions containing descriptions, ownership, usage frequency, and plane guidance.
- `docs/ontology.md` — human-readable explanation of the ontology, aligned with the schema and dual-plane responsibilities.
- `ai/context/` — slim knowledge cards Sunny references when grounding responses for product, platform architecture, and shared/CRM questions.
- `schema/changelog.md` — log of notable schema releases (update when a structural change is merged).

## Getting Started
1. Review `docs/ontology.md` to understand the refreshed vocabulary and dual-plane guardrails.
2. Run `python3 tools/validator.py --schema` to confirm the repo is in a valid state.
3. Seed or update a Neo4j instance using the artifacts in `schema/` and `data/` (authoring changes always flow through Luna workflows).
4. Use the context files in `ai/context/` when updating Sunny/Luna prompts so the agents stay aligned with the new ontology.

```
rimidi-kg/
├── ai/                 # Sunny and Luna guardrails, prompt context, tooling integrations
├── data/               # Canonical CSVs, seed payloads, and governance metadata
├── docs/               # Ontology, playbooks, contributor guidance
├── queries/            # Curated Cypher aligned with the regenerated schema
├── schema/             # Generated node, relationship, and attribute definitions
├── tools/              # Validator, loaders, dev helpers
└── ...                 # Supporting scripts, configs, CI workflows
```

## Change Workflow
1. Update `data/rimidi_kg_review_master_v2.csv` (or the relevant canonical source) to reflect the desired ontology change.
2. Regenerate `schema/node_types.yaml`, `schema/relationships.yaml`, and `schema/attributes.yaml` so usage frequency, maturity, and owner metadata stay in sync.
3. Refresh `docs/ontology.md` and any affected `ai/context/` cards to keep human-facing guidance aligned.
4. Adjust curated queries in `queries/` if the schema evolution changes expected patterns.
5. Run `python3 tools/validator.py --schema` (and `--data` if seed artifacts changed) before opening a PR.
6. Let Luna’s workflow propose the change downstream; Sunny should only consume the merged schema for read-only reasoning.

## Governance Reminders
- Every node or relationship committed to the repository must include `owner_group`, `usage_frequency`, and `governance_maturity` so audits remain deterministic.
- Plane visibility is declared in the schema: Sunny is read-only; Luna is read-write. Do not bypass this separation when designing new automation.
- Keep `schema/changelog.md` current so downstream teams understand when structural contracts moved.
- Use sanitized identifiers in prompts, docs, and seed data; PHI never enters the repo or the KG.

## Validator & Tooling
Run the lightweight validator before every PR to ensure required files exist and basic structure checks pass:
```bash
python3 tools/validator.py --schema
```
Add `--data` when seed payloads or infra definitions change. The same command is available inside Docker (`docker compose exec rimidi-kg python3 tools/validator.py`).

For deeper automation, reference the n8n workflows that wrap Luna’s authoring plane; guardrails in `ai/prompts/` should always mirror the schema regenerated from the CSV.
