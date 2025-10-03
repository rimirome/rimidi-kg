# Rimidi Knowledge Graph

The Rimidi Knowledge Graph (KG) is the single source of truth for how product capabilities, services, data domains, and infrastructure primitives connect. It helps product, engineering, data, and compliance teams reason about change impact, answer traceability questions, and power AI-driven insights (including n8n automations backed by Sunny).

## Getting Started
1. Review the schema definitions under `schema/` to understand supported node types (capabilities, use cases, services, infra, domains, feeders, analytics surfaces).
2. Load the starter dataset from `data/seed.cypher` into your Neo4j environment, or inspect the declarative YAML in `data/` for richer context.
3. Explore curated queries in `queries/` or run ad-hoc Cypher using the examples in `ai/examples.md`.

## What Lives Here
- **Business Services**: UI, Rimidi container, Coldbrew, Rimidify, Surve, reporting pipelines.
- **Infrastructure**: ECS clusters, Lambda schedules, EventBridge triggers, Redis queues, CloudFront, ALB, CloudWatch, Secrets Manager, Grafana.
- **Data Ecosystem**: Domains like Hearth, Apothecary, Aquifer, Canal, Jetty, Stillwater; collections, feeders, and seeds with governance tags.
- **Observability**: Bluejay, Kaleidoscope, Canopy surfaces and their telemetry relationships.
- **AI Contract**: Prompt context, guardrails, and examples that guide Sunny and n8n flows.

For contribution guidelines and workflow examples, check `docs/CONTRIBUTING.md` and `docs/playbook.md`. Release-driven enhancements are recorded in `data/business_logic.yaml` with `release_date` metadata sourced from product release notes.
