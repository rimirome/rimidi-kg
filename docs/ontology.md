# Rimidi KG Ontology

The ontology defines the vocabulary used across schema files, datasets, and automations. Every node label or relationship type in `schema/` maps to a business concept so Product, Engineering, TechOps, and Compliance reason with the same language.

## Node Labels

| Label | Description | Example | Owned By |
| --- | --- | --- | --- |
| `ProductCapability` | End-to-end product capability or feature area that delivers user value. | `capability-billing-insights` | Product Experience |
| `UseCase` | Business outcome delivered to Rimidi customers or internal teams. | `usecase-rpm-support` | Product Experience |
| `Workflow` | Operational or clinical sequence of actions, often powered by automations. | `workflow-hypertension-care-plan` | Clinical Ops |
| `Service` | Application or shared service that Rimidi operates. | `service-device-api` | Platform Engineering |
| `Integration` | External system, vendor, or API connected to Rimidi services. | `integration-dexcom-g6` | Integration Engineering |
| `InfraService` | Cloud infrastructure primitive providing hosting, storage, or monitoring. | `infra-ecs-rimidi` | TechOps |
| `Domain` | Governed data store or logical grouping of datasets. | `domain-aquifer` | Data Insights |
| `Collection` | Concrete dataset within a domain. | `collection-audit-care-plans` | Data Insights |
| `Feeder` | Pipeline or process that moves/derives data between domains. | `feeder-aquifer` | Data Engineering |
| `Seed` | Curated dataset for ML/analytics experimentation. | `seed-rpm-device-signals` | Data Insights |
| `AnalyticsSurface` | Observable surface (dashboard/report) that consumes the graph. | `surface-bluejay` | TechOps |
| `Policy` *(planned)* | Compliance or business rule constraining configurations. | `policy-audit-billing` | Compliance |
| `Actor` / `Team` *(planned)* | Person or team accountable for services, domains, or policies. | `team-platform-engineering` | People Ops |

## Relationship Types

| Type | Description | Typical Usage |
| --- | --- | --- |
| `ENABLES` | Capability provides functionality to a workflow. | Capability → Workflow |
| `DELIVERS` | Capability delivers a business use case. | Capability → UseCase |
| `SUPPORTS` | Service supports a use case. | Service → UseCase |
| `IMPLEMENTS` | Workflow leverages an integration. | Workflow → Integration |
| `RUNS_ON` | Service is hosted on infrastructure. | Service → InfraService |
| `SCHEDULED_BY` | Service execution is triggered by infra. | Service → InfraService |
| `DEPENDS_ON` | Service dependency graph (api/data/logging/etc.). | Service → Service |
| `INTEGRATES_WITH` | Service connects to external integration. | Service → Integration |
| `BACKED_BY` | Service persists data in a domain. | Service → Domain |
| `POWERS` | Domain enables a service. | Domain → Service |
| `CONTAINS_COLLECTION` | Domain contains a dataset. | Domain → Collection |
| `FEEDS` / `CONSUMES_FROM` | Feeder populates or reads from a domain. | Feeder ↔ Domain |
| `PERSISTED_IN` | Domain stored on infrastructure. | Domain → InfraService |
| `MONITORED_BY` / `OBSERVES` | Services and analytics surfaces share telemetry. | Service ↔ AnalyticsSurface |
| `REPORTS_ON` | Analytics surface reports on a domain. | AnalyticsSurface → Domain |
| `DERIVED_FROM` / `WRITES_TO` | Seeds derived from or written to domains. | Seed ↔ Domain |
| `OWNS` *(planned)* | Actor/Team accountable for a resource. | Team → Service |
| `GOVERNS` *(planned)* | Policy regulates a resource. | Policy → Domain/Service |

## Metadata & Governance

- **Identifiers**: All nodes use slug-style IDs (lowercase, hyphen separated). Prefer stable identifiers that outlive organizational changes.
- **Temporal Fields (planned)**: add `valid_from`, `valid_to`, `status_history` where historical lineage is needed.
- **Ownership**: Every top-level node should eventually point to a `Team` or `Actor` once ownership modeling is implemented.
- **Provenance**: Source references (`source_system`, `release_note`, `jira_id`) belong in data files when new entities are introduced.

See `docs/CONTRIBUTING.md` for change control around ontology updates.
