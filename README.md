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
