# Rimidi Knowledge Graph

The Rimidi Knowledge Graph (KG) is the single source of truth for how product capabilities, services, data domains, and infrastructure primitives connect. It helps product, engineering, data, and compliance teams reason about change impact, answer traceability questions, and power AI-driven insights (including n8n automations orchestrated by Lexi -> Sunny -> Luna).

## Getting Started
1. Review the schema definitions under `schema/` to understand the node types we model (`ProductCapability`, `UseCase`, `Service`, `Integration`, `InfraService`, `Domain`, `Collection`, `Feeder`, `Seed`, `AnalyticsSurface`).
2. Load the starter dataset from `data/seed.cypher` into your Neo4j environment, or inspect the declarative YAML in `data/` for richer context.
3. Explore curated queries in `queries/` or run ad-hoc Cypher using the examples in `ai/examples.md`. For example:

   ```cypher
   MATCH (svc:Service)-[:SUPPORTS]->(:UseCase {id: 'usecase-rpm-support'})
   RETURN svc.id AS service_id, svc.name AS service_name
   ORDER BY service_name;
   ```

- **Services (`Service`)**: UI, Rimidi container, Coldbrew, Rimidify, Surve, analytics dashboard, billing toolkit, patient chart subnavs, telehealth vendor enablement.
- **Integrations (`Integration`)**: Device manufacturers (Dexcom, Abbott, Smart Meter), EHR partners (Cerner, Epic, NextGen, athenahealth), ecosystem partners (Xealth, Baxter ShareSource).
- **Use Cases (`UseCase`)**: Remote patient monitoring, chronic care, billing operations, data exports, device ingestion, EHR interoperability, telehealth vendor enablement, care coordination.
- **Domains & Collections (`Domain`, `Collection`)**: Hearth, Apothecary, Aquifer, Canal, Jetty, Stillwater, Audit Repository and their governed datasets.
- **Infrastructure (`InfraService`)**: ECS workloads, Lambda/EventBridge schedulers, RDS, Redis, S3, CloudFront, ALB, CloudWatch, Secrets Manager, Grafana.
- **Analytics & Observability (`AnalyticsSurface`)**: Bluejay, Kaleidoscope, Canopy, and their telemetry relationships.
- **AI Contract (`ai/`)**: Prompt context, guardrails, examples, and FAQ guiding Lexi (alias normalization), Sunny (Cypher generation), and Luna (reasoning/documentation).

## Contribution Workflow

For the canonical vocabulary, see `docs/ontology.md`.

- **Schema edits** (`schema/`) require a pull request and review from Product and Engineering to safeguard backward compatibility.
- **Data updates** (`data/`) should reference a release note, ADR, or Jira ticket; run `python tools/validator.py --data` before requesting review.
- **AI context changes** (`ai/`) must include updated natural-language-to-Cypher examples so Lexi/Sunny/Luna stay aligned.

### Readiness Checklist

Before promoting schema or data changes, review `docs/kg_readiness_checklist.md`. It walks through ontology, schema, documentation, data, AI, and operational checks, plus recommended enhancements so nothing is missed.

## Using Lexi, Sunny, and Luna (Chat-Only Workflows)

When you interact with the KG through the n8n agents:
- Describe the concept in plain language; Lexi will expand it using `data/aliases.yaml` and note any low-confidence matches.
- Review Lexi’s alias summary—confirm ambiguous matches before Sunny proceeds with Cypher.
- Provide required metadata for new facts (`id`, `name`, `owner_team`, `source_system`, `jira_id`, `release_note`).
- Call out environment/tenant context (production vs staging, tenant identifier) so the generated Cypher is scoped correctly.
- Expect Sunny to show a dry-run summary plus Cypher for any write (especially destructive updates) and ask for explicit confirmation before executing it.
- Mention whether you are working in the Product, TechOps, or Shared graph; Sunny will default to asking if unclear.
- Use Luna to translate Cypher output into documentation summaries and follow-up actions, and to cite the relevant files in `/docs` or `/ai/context`.


For contribution guidelines and workflow examples, check `docs/CONTRIBUTING.md` and `docs/playbook.md`. Release-driven enhancements are recorded in `data/business_logic.yaml` with `release_date` metadata sourced from product release notes.

## Emerging Dimensions

To keep the graph future-proof for compliance, RCA, and ownership clarity, we plan to extend the schema with:

- **Temporal history**: versioned nodes or `valid_from` / `valid_to` attributes so we can query historical schema and workflow states.
- **Ownership & responsibility**: explicit `Actor` / `Team` nodes with `OWNS` or `RESPONSIBLE_FOR` edges for services, domains, and configurations.
- **Policy guardrails**: lightweight `Policy` nodes linking tenants, services, and workflows to enforce compliance or tenant-specific restrictions.
- **Outcome tracking**: status edges/events capturing whether configuration changes or workflows succeeded, enabling RCA and audit reporting.
