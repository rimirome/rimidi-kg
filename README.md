# Rimidi Knowledge Graph Repository

This repository packages the Rimidi knowledge graph schema, seed data, AI assistant context, and automation assets. Start with `docs/README.md` for the why and how, then explore domain-specific folders as needed.

Recent updates capture device integration pipelines, SMART-on-FHIR interoperability, partner integrations, and data export services so engineering and product teams can reason about the broader platform footprint.

```
rimidi-kg/
├── schema/      # Canonical definitions of nodes, relationships, attributes
├── data/        # Seed dataset, business logic, and domains/infra governance
├── ai/          # Prompts, guardrails, and FAQ for the Rimidi KG agent and n8n flows
├── queries/     # Curated Cypher queries for product, engineering, compliance, data
├── docs/        # Documentation, contribution guide, usage playbook, changelog
├── tools/       # Validators, loaders, and analysis notebooks
└── .github/     # CI workflows for validation and sync operations
```

> Tip: run `python tools/validator.py` before opening a pull request to ensure schema and data remain consistent. Capture new release-driven features in `data/business_logic.yaml` with `release_date` metadata so automations stay traceable.

## Docker Quickstart

1. Build the image:
   ```bash
   docker compose build
   ```
2. Start the long-lived container (keeps the repo mounted so you and n8n can exec commands):
   ```bash
   docker compose up -d
   ```
3. Run utilities as needed. Examples:
   ```bash
   docker compose exec rimidi-kg python tools/validator.py
   docker compose exec rimidi-kg python tools/loader.py --schema --data > payload.json
   ```
4. Stop the container when finished:
   ```bash
   docker compose down
   ```

> n8n can run the same `docker compose exec` commands inside workflows to trigger validator or loader tasks. Mounting `.:/workspace` keeps repo changes in sync with your host and the agent.

## Getting Started
1. Review `docs/README.md` for domain terminology and schema node types.
2. Seed Neo4j with `data/seed.cypher`, then explore the example queries in `queries/`.
3. Try an ad-hoc query straight from the docs: 
   ```cypher
   MATCH (svc:Service)-[:SUPPORTS]->(:UseCase {id: 'usecase-rpm-support'})
   RETURN svc.id, svc.name;
   ```

## Contribution Guardrails
- Schema changes require PR review by Product and Engineering.
- Data additions should reference a release note / Jira ticket and pass `python tools/validator.py --data`.
- AI prompt updates must update NL→Cypher examples (`ai/examples.md`).

For deeper guidance see `docs/CONTRIBUTING.md` and `docs/playbook.md`.
