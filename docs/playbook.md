# Rimidi KG Playbook

## Product Requirement Impact Analysis
1. Identify the target capability or use case in the KG.
2. Run `queries/product.cypher` to understand which services support it and which domains back those services. Cross-reference `data/business_logic.yaml` for recent release contexts or `release_date` tags.
3. Document affected workflows, services, domains, feeders, and release alignment in the requirement for downstream teams.
4. Use the "Feature relationships" query (`RELATES_TO`) to map dependent capabilities when scoping impact.

## Engineering Change Planning
1. Locate the services or infra primitives impacted by the change (for example, Rimidi container, Coldbrew, ECS clusters).
2. Execute `queries/engineering.cypher` to reveal dependency or observability gaps.
3. Update `data/infra.yaml` to reflect new hosting mappings or dependency metadata, then run validator checks.
4. Review associated code artifacts via `queries/engineering.cypher` to notify repo owners before deploying.

## Data Governance Review
1. Use `queries/data.cypher` to audit PHI sensitivity, access roles, and feeder coverage across domains.
2. Confirm that each collection and feeder has the required governance tags as defined in `schema/attributes.yaml`.
3. Document remediation tasks or decision logs in `docs/CHANGELOG.md` for compliance traceability.

## Client Success Support
1. Run `queries/client_success.cypher` to pull knowledge articles (`KnowledgeArticle` nodes) for a capability or workflow.
2. Update `data/support.yaml` whenever new runbooks, FAQs, or expected behavior docs are published (with provenance fields).
3. Keep Skye/Sunny/Luna prompts aligned so expected-behavior responses reference these articles rather than ad-hoc explanations.

## Device & EHR Integration Planning
1. Map the affected device vendors or EHR partners to Integration nodes (Dexcom, Abbott, Smart Meter, Cerner, Epic, NextGen, athenahealth) and confirm `INTEGRATES_WITH` edges exist.
2. Update `data/business_logic.yaml` components (Device Integration Hub, SMART-on-FHIR Interop, EMR Adapter Integrations) with new requirements or release context.
3. Ensure `data/infra.yaml` reflects supporting services (`service-device-api`, `service-fhir-gateway`, `service-emr-adapters`) and add additional integration partners in `data/seed.cypher`.

## AI / Automation Updates
1. When Skye, Sunny, or Luna needs new behavior, update the relevant `ai/` files and store supporting Cypher or reasoning guides in `queries/`.
2. Raise a pull request so human reviewers confirm guardrails before the automation runs in production.
3. Coordinate with TechOps to deploy any validator or workflow changes in `.github/workflows/`.

## Ontology Governance
1. Review new node/edge definitions in `docs/ontology.md` with Product + Engineering before merging schema changes.
2. Version ontology updates alongside schema releases and record the version in `schema/changelog.md`.
3. Validate that ownership and policy assignments are populated for newly introduced services or domains.

## Data Pipeline & Reasoning Demos
1. Use `tools/loader.py --schema --data` to generate JSON payloads that can feed reasoning notebooks.
2. Populate `tools/pipeline/` scripts (see TODO stubs) when onboarding new data sources such as Jira or device vendor exports.
3. Demonstrate value via curated queries (e.g., integration readiness) and attach screenshots or cypher snippets to product playbooks.
