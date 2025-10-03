# Rimidi Knowledge Graph Repository

The Rimidi KG is the single source of truth for how Rimidi capabilities, services, integrations, data domains, and infrastructure connect. It powers change-impact analysis for Product & Engineering and acts as the contract that keeps Sunny/n8n automations aligned with reality.

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
