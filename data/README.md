# Data Assets

Canonical datasets, alias catalogues, and seed payloads used to initialize and reason about the Rimidi KG.

## Contents
- `rimidi_kg_review_master_v2.csv` - source-of-truth sheet for labels, relationships, governance metadata.
- `seed.cypher` - bootstrap script for provisioning a Neo4j environment.
- `aliases.yaml` - normalization catalogue consumed by Lexi.
- `business_logic.yaml`, `infra.yaml`, `support.yaml`, `code_artifacts.yaml`, `events.yaml` - curated YAML datasets that extend the KG with governed facts and provenance.

## Key Assumptions
- Identifiers remain sanitized (slug-style) and avoid PHI or tenant details.
- Every record includes ownership and provenance fields so validators can enforce governance rules.
- Alias updates must include clear intent and scope so Lexi can expose confidence to downstream agents.
- Changes here should be accompanied by `python tools/validator.py --data` output in review notes.
