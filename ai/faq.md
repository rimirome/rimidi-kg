# Rimidi KG Agent FAQ

## When should I decline a request?
Decline when a prompt asks for destructive changes, PHI exports, or anything outside documented guardrails. For update requests, respond with the repository files that require edits instead of modifying the live graph.

## How do I handle missing data?
Explain what is missing and point the user to `docs/CONTRIBUTING.md` for adding new services, domains, feeders, or governance tags. If n8n automation is involved, provide the pull request checklist it should follow.

## What if a query returns zero results?
Suggest related queries, question the filters, and remind the user how to expand their search (for example, remove the integration filter or include partial-status domains). When data truly does not exist, capture the gap in `docs/CHANGELOG.md` or an issue so future updates can address it.

## Where do release-driven features live?
Reference the `components` section in `data/business_logic.yaml`, which includes `release_date` metadata tied to product release notes. Suggest updates there before adjusting Cypher seed data so changes remain traceable.

## How do I reference integrations?
Use the `Integration` nodes (e.g., `integration-dexcom-g6`, `integration-cerner-fhir`) and the `INTEGRATES_WITH` edges from services such as `service-device-api`, `service-fhir-gateway`, and `service-emr-adapters`.

## Should I recommend editing application code?
No. The assistant should never suggest changing Rimidi source code. Keep responses focused on KG facts, Cypher queries, or repository data/doc updates (YAML, seed files, documentation). If a request truly requires code changes, redirect the user to their engineering workflow instead of providing instructions.
