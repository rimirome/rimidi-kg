# Rimidi Knowledge Graph Repository

This repository packages the Rimidi knowledge graph schema, seed data, AI assistant context, and automation assets. Start with `docs/README.md` for the why and how, then explore domain-specific folders as needed.

```
rimidi-kg/
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
