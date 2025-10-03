# Rimidi KG Playbook

## Product Requirement Impact Analysis
1. Identify the target capability or use case in the KG.
2. Run `queries/product.cypher` to understand which services support it and which domains back those services. Cross-reference `data/business_logic.yaml` for recent release contexts or `release_date` tags.
3. Document affected workflows, services, domains, feeders, and release alignment in the requirement for downstream teams.

## Engineering Change Planning
1. Locate the services or infra primitives impacted by the change (for example, Rimidi container, Coldbrew, ECS clusters).
2. Execute `queries/engineering.cypher` to reveal dependency or observability gaps.
3. Update `data/infra.yaml` to reflect new hosting mappings or dependency metadata, then run validator checks.

## Data Governance Review
1. Use `queries/data.cypher` to audit PHI sensitivity, access roles, and feeder coverage across domains.
2. Confirm that each collection and feeder has the required governance tags as defined in `schema/attributes.yaml`.
3. Document remediation tasks or decision logs in `docs/CHANGELOG.md` for compliance traceability.

## AI / Automation Updates
1. When Sunny or n8n needs new behavior, update the relevant `ai/` files and store supporting Cypher in `queries/`.
2. Raise a pull request so human reviewers confirm guardrails before the automation runs in production.
3. Coordinate with TechOps to deploy any validator or workflow changes in `.github/workflows/`.
