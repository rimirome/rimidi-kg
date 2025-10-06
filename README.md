# Rimidi Knowledge Graph Repository

## Purpose & Assumptions

The Rimidi KG is the single source of truth for how Rimidi capabilities, services, integrations, data domains, and infrastructure connect. It powers change-impact analysis for Product & Engineering and acts as the contract that keeps Sunny/n8n automations aligned with reality.

Working assumptions:
- **Ontology-first**: every node/edge type lives in `docs/ontology.md` before it appears in schema or data files.
- **Governance metadata**: core nodes carry `valid_from`, `valid_to`, and provenance fields (`source_system`, `jira_id`, `release_note`).
- **Ownership required**: services, domains, integrations, and capabilities will point to a `Team` via `OWNS` as ownership data is filled in.
- **Policy & events ready**: `Policy`, `Team`, `Actor`, and event modeling exist in the schema so temporal/policy reasoning can be layered in without further structural churn.
- **AI regression**: whenever schema/data changes, update NL→Cypher examples in `ai/examples.md` so Sunny/n8n stay aligned.
- **Sunny writes via Cypher**: live KG updates occur through Sunny/n8n-generated Cypher; repo edits remain for ontology, schema, and curated seed data.

## Getting Started
1. Read `docs/README.md` to understand the node types (`ProductCapability`, `UseCase`, `Service`, `Integration`, `Domain`, `InfraService`, etc.) and how they map to Rimidi terminology.
2. Seed a Neo4j instance with `data/seed.cypher` (or inspect the declarative YAML in `data/`).
3. Try a quick query to explore the graph:
   ```cypher
   MATCH (svc:Service)-[:SUPPORTS]->(:UseCase {id: 'usecase-rpm-support'})
   RETURN svc.id AS service_id, svc.name AS service_name
   ORDER BY service_name;
   ```
4. Browse curated queries in `queries/` or run ad-hoc Cypher using the prompts in `ai/examples.md`.

```
rimidi-kg/
├── schema/      # Canonical definitions of nodes, relationships, attributes
├── data/        # Seed dataset, business logic, domains/infra governance
├── ai/          # Prompts, guardrails, and FAQ for Sunny / n8n automations
├── queries/     # Curated Cypher for product, engineering, compliance, data
├── docs/        # README, CONTRIBUTING, playbook, changelog
├── tools/       # Validator, loader, analysis notebooks
└── .github/     # CI workflows for validation & sync operations
```

## Contribution Guardrails
- **Schema changes** (`schema/`) require PR review from both Product and Engineering before merge.
- **Data changes** (`data/`) must reference a release note / Jira ticket and pass `python tools/validator.py --data`.
- **AI contract updates** (`ai/`) must refresh the NL→Cypher examples in `ai/examples.md`.

For detailed workflows see `docs/CONTRIBUTING.md` and `docs/playbook.md`. Run `python tools/validator.py` before every PR to keep the repo consistent. Capture new release-driven features in `data/business_logic.yaml` (use the `release_date` field for traceability).

## Docker Quickstart

1. Build the image:
   ```bash
   docker compose build
   ```
2. Start the long-lived container (mounts the repo so you and n8n can exec commands):
   ```bash
   docker compose up -d
   ```
3. Run utilities as needed:
   ```bash
   docker compose exec rimidi-kg python tools/validator.py
   docker compose exec rimidi-kg python tools/loader.py --schema --data > payload.json
   ```
4. Stop the container when finished:
   ```bash
   docker compose down
   ```

> n8n can run the same `docker compose exec` commands inside workflows to trigger validator or loader tasks. Mounting `.:/workspace` keeps repo changes in sync with your host and the agent.

## How to Maintain This Repo

Think of the repo in two layers:

**System files (edit with care)**
- `docs/ontology.md` – canonical vocabulary, responsible teams.
- `schema/` – node/relationship definitions, attributes, changelog.
- `tools/` – validator, loader, pipeline scripts, notebooks.
- `.github/` – CI workflows.

**Config/content files (updated frequently with provenance)**
- `data/` – YAML/Cypher facts, business logic, integrations.
- `ai/` – prompt context, examples, guardrails for Sunny/n8n.
- `queries/` – Cypher used by humans and automations.
- `docs/CHANGELOG.md`, `docs/README.md`, `docs/playbook.md` – human-facing guidance.

When you add or modify information, work through these steps:
1. Update `docs/ontology.md` with any new labels/relationships and note owning teams.
2. Reflect the ontology change in `schema/` and log it in `schema/changelog.md`.
3. Refresh docs (`docs/README.md`, `docs/CONTRIBUTING.md`, `docs/playbook.md`) so Product/Engineering/TechOps understand the change.
4. Edit `data/` files, including provenance fields (release note, Jira ID, source system).
5. Update `ai/` prompts/examples and add or tweak queries in `queries/`.
6. Adjust tooling (`tools/validator.py`, `tools/pipeline/`) if new validation or ingestion paths are required.
7. Run `python tools/validator.py --schema --data` (or via Docker) before committing.

Every PR should mention the ontology version and data provenance sources so future audits can trace changes.

### Repo Files vs. Live KG Updates

Use this repo whenever you are changing **structure, canonical content, or automation contracts**:
- Introducing/changing node or relationship types, attributes, or ownership rules.
- Adding or modifying source-of-truth data that should be versioned (seed data, business logic YAML, integration metadata).
- Updating Sunny/n8n prompts, curated queries, or validator/tooling behavior.
- Recording provenance, governance policies, or release-driven enhancements.

Update the live KG directly (via Neo4j/n8n/Sunny) when you are applying **operational facts** that do not alter the ontology:
- Tenant-specific or environment-specific configuration values already modeled in schema.
- Runtime events (deployments, incidents) that will later be synced back through a pipeline.
- Ad-hoc investigations or exploratory queries that do not need to be checked into version control.

Rule of thumb: if others need to rely on the change as a shared contract or if it impacts code/automation, edit the repo first. For transient/tenant-specific data, update the KG and ensure a pipeline exists to persist any facts that should eventually live in `data/`.
