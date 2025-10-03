# Pipeline Stubs

This folder contains starter scripts aligned with the knowledge graph development process described in the research papers stored in `docs/`.

- `jira_ingest.py` – normalizes a Jira CSV export into a structured payload that can be translated into graph nodes/edges.
- `device_partner_loader.py` – converts a JSON list of device partners into an integration payload for downstream loaders.

> These scripts are intentionally lightweight. As we add new data sources (telehealth vendors, FHIR writeback results, RCA events), add modules here and document them in `docs/playbook.md`.
