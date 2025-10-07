# Rimidi Knowledge Graph Repository

<<<<<<< Updated upstream
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
=======
<<<<<<< Updated upstream
This repository packages the Rimidi knowledge graph schema, seed data, AI assistant context, and automation assets. Start with `docs/README.md` for the why and how, then explore domain-specific folders as needed.
=======
The Rimidi Knowledge Graph (KG) is the canonical map of Rimidi product capabilities, services, data domains, and governance metadata. This repository houses every artefact required to understand, evolve, and automate against the KG. All automations now run through a three-agent orchestration: Lexi normalizes teammate input, Sunny produces parameterized Cypher, and Luna explains results with links back to documentation.
>>>>>>> Stashed changes

## Agent Architecture
| Stage | Agent | Responsibility | Runner | Key Inputs |
| --- | --- | --- | --- | --- |
| Pre-process | Lexi | Resolve aliases from `data/aliases.yaml`, flag ambiguities, and emit normalized intent for downstream agents. | n8n workflow | `ai/prompts/base_prompt_lexi.md`, `data/aliases.yaml` |
| Translate | Sunny | Generate safe, parameterized Cypher tied to KG governance rules and explicit validator reminders. | n8n workflow | `ai/prompts/base_prompt_sunny.md`, `ai/context/*.md` |
| Reason | Luna | Interpret Cypher output, cite docs, and recommend follow-ups without executing writes. | n8n workflow | `ai/prompts/base_prompt_luna.md`, `docs/*`, `ai/context/*` |

Working agreements:
- Lexi annotates every request with the alias entries applied so Sunny and Luna can audit transformations.
- Sunny is read-only; destructive Cypher demands explicit human approval and validator evidence before execution.
- Luna provides reasoning and documentation linkage only; human operators still perform schema/data commits.
- n8n remains the orchestration surface. Runtime logic stays outside this repo; we store only prompts, context, and guidance.

## Canonical Artefacts
- `data/rimidi_kg_review_master_v2.csv` - master review sheet for labels, relationships, and governance state.
- `schema/node_types.yaml`, `schema/relationships.yaml`, `schema/attributes.yaml` - generated schema definitions with ownership and maturity metadata.
- `docs/ontology.md` - narrative documentation of the schema, aligned with the three-agent division of responsibilities.
- `ai/context/` - modular knowledge cards referenced by Sunny and Luna.
- `data/aliases.yaml` - alias catalogue loaded by Lexi before every turn.

## Getting Started
1. Install requirements with `pip install -r requirements.txt` (or use the provided Docker setup).
2. Review `docs/ontology.md` for vocabulary, governance rules, and agent boundaries.
3. Run `python3 tools/validator.py --schema` (add `--data` after editing seed files) to confirm the repo state.
4. Load `data/seed.cypher` into a Neo4j dev environment or inspect YAML payloads in `data/` for context.
5. Update prompts or context only after consulting `ai/prompt_context.md` and ensuring Lexi/Sunny/Luna stay aligned.
>>>>>>> Stashed changes

## Repository Layout
```
rimidi-kg/
<<<<<<< Updated upstream
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
=======
<<<<<<< Updated upstream
├── schema/      # Canonical definitions of nodes, relationships, attributes
├── data/        # Seed dataset and YAML sources that feed the graph
├── ai/          # Prompts, guardrails, and FAQ for the Rimidi KG agent
├── queries/     # Curated Cypher queries for product, engineering, compliance
├── docs/        # Documentation, contribution guide, and usage playbook
├── tools/       # Validators, loaders, and analysis notebooks
└── .github/     # CI workflows for validation and sync operations
```

> Tip: run `python tools/validator.py` before opening a pull request to ensure schema and data remain consistent.
# rimidi-kg
=======
|-- ai/                 # Prompts, context packs, and automation tooling docs for Lexi, Sunny, and Luna
|-- data/               # Canonical CSVs, seed payloads, and alias definitions
|-- docs/               # Ontology, playbooks, contributor guidance, readiness checklists
|-- n8n/                # Workflow assets, node templates, and runbook notes for orchestrating the agents
|-- queries/            # Curated Cypher snippets aligned to the governed schema
|-- schema/             # Generated node, relationship, and attribute definitions plus changelog
|-- tools/              # Validator, loaders, helper scripts for local or CI environments
`-- ...                 # Docker configs, CI hooks, and ancillary scripts
```

## Change Workflow
1. Update `data/rimidi_kg_review_master_v2.csv` (or the relevant canonical source) with the proposed ontology or governance changes.
2. Regenerate the schema YAMLs under `schema/` so ownership, maturity, and usage metadata stay synchronized.
3. Refresh `docs/ontology.md`, affected playbooks, and any prompt/context files impacted by the change.
4. Adjust curated queries in `queries/` if the schema evolution affects expected query patterns.
5. Run `python3 tools/validator.py --schema --data` and capture the output for reviewers.
6. Use n8n to drive Lexi -> Sunny -> Luna validation conversations; commits remain human-owned through standard PR review.

## Governance Reminders
- Include `owner_team`, `usage_frequency`, `governance_maturity`, and provenance metadata on every node/relationship committed to the repo.
- PHI or tenant identifiers never enter the repository. Use the sanitized examples in `docs/ontology.md` or `data/seed.cypher` when authoring content.
- Alias updates in `data/aliases.yaml` must note the confidence level and intended scope so Lexi can defend transformations downstream.
- Document structural changes in `schema/changelog.md` and cross-link relevant ADRs or tickets.

## Validation & Tooling
Run the validator before every PR:
```bash
python3 tools/validator.py --schema
```
Add `--data` when seed or alias payloads change. The same commands are available via Docker (`docker compose exec rimidi-kg python3 tools/validator.py`). For automation details, consult the README files in each subdirectory and the n8n workflow notes under `n8n/`.
>>>>>>> Stashed changes
>>>>>>> Stashed changes
