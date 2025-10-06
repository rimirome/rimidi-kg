# Rimidi KG Ontology

The ontology defines the vocabulary used across schema files, datasets, and automations. Every node label or relationship type in `schema/` maps to a business concept so Product, Engineering, TechOps, and Compliance reason with the same language.

## Node Labels

| Label | Description | Example | Owned By |
| --- | --- | --- | --- |
| `ProductCapability` | End-to-end product capability or feature area that delivers user value. | `capability-billing-insights` | Product Team |
| `UseCase` | Business outcome delivered to Rimidi customers or internal teams. | `usecase-rpm-support` | Product Team |
| `Workflow` | Operational or clinical sequence of actions, often powered by automations. | `workflow-hypertension-care-plan` | Development Team |
| `Service` | Application or shared service that Rimidi operates. | `service-device-api` | Development Team |
| `Integration` | External system, vendor, or API connected to Rimidi services. | `integration-dexcom-g6` | Development Team |
| `InfraService` | Cloud infrastructure primitive providing hosting, storage, or monitoring. | `infra-ecs-rimidi` | TechOps Team |
| `Domain` | Governed data store or logical grouping of datasets. | `domain-aquifer` | Client Success Team |
| `Collection` | Concrete dataset within a domain. | `collection-audit-care-plans` | Client Success Team |
| `Feeder` | Pipeline or process that moves/derives data between domains. | `feeder-aquifer` | Development Team |
| `Seed` | Curated dataset for ML/analytics experimentation. | `seed-rpm-device-signals` | Quality Engineering Team |
| `AnalyticsSurface` | Observable surface (dashboard/report) that consumes the graph. | `surface-bluejay` | TechOps Team |
| `Policy` *(planned)* | Compliance or business rule constraining configurations. | `policy-audit-billing` | Cybersecurity Team |
| `Team` *(planned)* | Organizational unit responsible for Rimidi resources. | `team-techops` | Executives |
| `Actor` *(planned)* | Individual requester or approver associated with changes. | `actor-rpeters` | HR Team |
| `KnowledgeArticle` | Support or documentation entry describing expected behavior or troubleshooting steps. | `ka-rpm-billing-periods` | Client Success Team |
| `CodeArtifact` | Source code reference (repo/path) implementing a capability or service. | `code-rimidi-container-api` | Development Team |
| `Event` | Deployment, incident, or configuration change with temporal metadata. | `event-rpm-config-2025-03-01` | TechOps Team |

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
| `RELATES_TO` | Conceptual relationship or dependency between capabilities. | ProductCapability → ProductCapability |
| `BACKED_BY` | Service persists data in a domain. | Service → Domain |
| `POWERS` | Domain enables a service. | Domain → Service |
| `CONTAINS_COLLECTION` | Domain contains a dataset. | Domain → Collection |
| `FEEDS` / `CONSUMES_FROM` | Feeder populates or reads from a domain. | Feeder ↔ Domain |
| `PERSISTED_IN` | Domain stored on infrastructure. | Domain → InfraService |
| `MONITORED_BY` / `OBSERVES` | Services and analytics surfaces share telemetry. | Service ↔ AnalyticsSurface |
| `REPORTS_ON` | Analytics surface reports on a domain. | AnalyticsSurface → Domain |
| `DERIVED_FROM` / `WRITES_TO` | Seeds derived from or written to domains. | Seed ↔ Domain |
| `OWNS` | Team accountable for a resource. | Team → Service |
| `GOVERNS` | Policy regulates a resource. | Policy → Domain/Service |
| `EXPLAINS` | Knowledge article describing expected behavior. | KnowledgeArticle → ProductCapability |
| `DOCUMENTS` | Knowledge article documenting a workflow or service. | KnowledgeArticle → Workflow |
| `USES_CODE` | Service implemented by a code artifact. | Service → CodeArtifact |
| `IMPLEMENTED_BY` | Workflow implemented by code artifact. | Workflow → CodeArtifact |
| `TRIGGERS` | Event triggering a workflow or service. | Event → Service |
| `RESULTED_IN` | Event outcome impacting a domain. | Event → Domain |

## Metadata & Governance

- **Identifiers**: All nodes use slug-style IDs (lowercase, hyphen separated). Prefer stable identifiers that outlive organizational changes.
- **Temporal Fields (planned)**: add `valid_from`, `valid_to`, `status_history` where historical lineage is needed.
- **Ownership**: Every top-level node should eventually point to a `Team` or `Actor` once ownership modeling is implemented.
- **Provenance**: Source references (`source_system`, `release_note`, `jira_id`) belong in data files when new entities are introduced.
- **Aliases**: Add `aliases` or `synonyms` where useful so Sunny can fuzzily match natural language to canonical IDs (for example, “BP Graph” vs “Blood Pressure Graph”).

See `docs/CONTRIBUTING.md` for change control around ontology updates.
