# Rimidi Dual-Plane Ontology

The Rimidi knowledge graph is reinitialized from `data/rimidi_kg_review_master_v2.csv` and serves as the authoritative contract for the Sunny (query execution) and Luna (reasoning/documentation) agents. This document captures the node labels and relationship types for the dual-plane architecture with updated governance metadata.

## Dual-Plane Governance Principles
- **Skye (Normalization Layer)** — resolves aliases defined in `data/aliases.yaml` before any prompt reaches the graph agents.
- **Sunny (Query Plane)** — read-only Cypher agent backed by the `neo4j_reader` role. Sunny translates normalized language to Cypher and always respects this schema.
- **Luna (Reasoning Plane)** — documentation and interpretation agent orchestrated through n8n. Luna references KG context, summarizes results, and suggests follow-up actions without writing to Neo4j.
- Structural changes still begin in Git and are validated before production deployment; agents surface guidance but do not auto-apply writes.

## Node Labels
### Product

| Label | Description | Example ID | Owner Team | Status | Usage | Maturity |
| --- | --- | --- | --- | --- | --- | --- |
| `EndUserWorkflow` | Sequenced steps that deliver a clinical or operational outcome. | `workflow-alert-triage` | Product | active | High | Strong |
| `ProductCapability` | End-to-end product capability or feature area powering clinical or operational value. | `capability-remote-monitoring` | Product | active | High | Strong |
| `SupportWorkflow` | Troubleshooting or support playbook used by Customer Success or Product. | `workflow-integration-reset` | Product | active | Medium | Strong |
| `UIComponent` | Visible or interactive element (modal, header, dashboard widget). | `component-care-team-dashboard` | Product | active | Medium | Strong |
| `UseCase` | Business outcome delivered to providers, staff, or patients. | `usecase-hypertension-management` | Product | active | High | Strong |

### Platform Architecture

| Label | Description | Example ID | Owner Team | Status | Usage | Maturity |
| --- | --- | --- | --- | --- | --- | --- |
| `Actor` | Individual requester or approver associated with changes. | `actor-change-approver` | TechOps | active | Medium | Medium |
| `CodeArtifact` | Source code reference implementing a capability or workflow. | `code-rimidi-kg-repo` | Engineering | active | Medium | Medium |
| `DataService` | Data service for Extraction, Transformation, or Load for Rimidi platform | `datasvc-metrics-aggregation` | Engineering | planned | Medium | Medium |
| `InfraService` | Cloud infrastructure primitive providing hosting, storage, or monitoring. | `infra-aws-ecs-cluster` | Engineering | active | High | Strong |
| `Observability` | Ability to monitor using reporting, dashboarding, or logging. | `observability-loki-pipeline` | Engineering | planned | Medium | Medium |
| `ReleaseVersion` | Deployment, incident, or configuration change with temporal metadata. | `v2-25` | Engineering | active | Medium | Strong |
| `Reporting` | Reporting of data | `report-operational-dashboard` | Engineering | planned | Medium | Medium |
| `Service` | Application or shared service operated by Rimidi (UI, API, worker, etc.). | `service-scheduling-api` | Engineering | active | High | Strong |
| `Team` | Organizational unit responsible for Rimidi resources. | `team-platform-engineering` | TechOps | active | High | Strong |
| `ToolingService` | Internal Rimidi utility or admin tool for back-office teams. | `tooling-deployment-console` | Engineering | active | Medium | Medium |

### Shared / CRM

| Label | Description | Example ID | Owner Team | Status | Usage | Maturity |
| --- | --- | --- | --- | --- | --- | --- |
| `Client` | Healthcare organization or customer entity licensed to use Rimidi. | `client-coastal-health` | ClientSuccess | active | Medium | Strong |
| `CommChannel` | Communication pathway (SMS, Email, Phone, etc.). | `channel-secure-messaging` | ClientSuccess | planned | Medium | Strong |
| `DeploymentType` | Client-specific deployment configuration. | `deployment-multitenant-prod` | ClientSuccess | active | Medium | Medium |
| `DeviceIntegration` | Device connected to Rimidi services. | `integration-dexcom-g7` | ClientSuccess | planned | High | Strong |
| `DeviceVendor` | Device manufacturer distinct from integration endpoints. | `vendor-dexcom` | ClientSuccess | planned | Medium | Strong |
| `EMRIntegration` | EMR vendor connected to Rimidi services. | `integration-cerner` | ClientSuccess | planned | High | Strong |
| `ImplementationVariant` | Specific deployment configuration tailored for a client tenant. | `implementation-variant-standard` | TechOps | planned | Medium | Medium |
| `IntegrationPartner` | External vendor connected to Rimidi services. | `integration-xealth` | ClientSuccess | planned | High | Strong |

Alias notes: `DeploymentType` replaces `Implementation`.

## Relationship Types
### Product

| Type | Description | Source -> Target | Owner Team | Status | Usage | Maturity |
| --- | --- | --- | --- | --- | --- | --- |
| `DELIVERS` | Capability or workflow delivers measurable value for a specific use case. | `ProductCapability`, `EndUserWorkflow` -> `UseCase` | Product | active | High | Strong |
| `ENABLES` | Capability or workflow enables an operational experience. | `ProductCapability` -> `EndUserWorkflow` | Product | active | High | Strong |
| `HAS_COMPONENT` | Capability or service composed of a UI component surfaced to users. | `ProductCapability`, `Service`, `ToolingService` -> `UIComponent` | Product | active | Medium | Strong |
| `IMPLEMENTS` | Workflow leverages an integration or data service to execute steps. | `EndUserWorkflow` -> `IntegrationPartner`, `EMRIntegration`, `DeviceIntegration`, `DataService` | Product | active | High | Strong |
| `SUPPORTS_TROUBLESHOOTING` | Capability or service documented by a support workflow for incident response. | `ProductCapability`, `Service`, `DataService` -> `SupportWorkflow` | Product | active | Medium | Strong |

### Platform Architecture

| Type | Description | Source -> Target | Owner Team | Status | Usage | Maturity |
| --- | --- | --- | --- | --- | --- | --- |
| `ADMINISTERED_BY` | Tooling service managed day-to-day by a specific team. | `ToolingService` -> `Team` | TechOps | active | Medium | Strong |
| `APPROVED_BY` | Actor approving a change, deployment, or configuration update for a Rimidi asset. | `Actor` -> `Service`, `DataService`, `DeploymentType`, `ImplementationVariant`, `ReleaseVersion` | TechOps | active | Medium | Strong |
| `DEPENDS_ON` | Service-level dependency across Rimidi services or data pipelines. | `Service`, `DataService` -> `Service`, `DataService` | Engineering | active | High | Strong |
| `FEEDS` | Data service publishes curated datasets or metrics into reporting or observability surfaces. | `DataService` -> `Reporting`, `Observability` | Engineering | active | Medium | Medium |
| `GOVERNS` | Team-defined guardrail that constrains how a deployment type, service, or client handles data. | `Team` -> `DeploymentType`, `ImplementationVariant`, `Service`, `DataService`, `Client` | TechOps | active | Medium | Strong |
| `MONITORED_BY` | Service, data pipeline, or report surface monitored by an observability tool. | `Service`, `DataService`, `Reporting` -> `Observability` | Engineering | active | Medium | Strong |
| `OWNS` | Team accountable for an asset across product, platform, or client contexts. | `Team` -> `ProductCapability`, `UseCase`, `EndUserWorkflow`, `SupportWorkflow`, `UIComponent`, `Service`, `ToolingService`, `DataService`, `Reporting`, `Observability`, `InfraService`, `Client`, `DeploymentType`, `ImplementationVariant`, `IntegrationPartner`, `EMRIntegration`, `DeviceIntegration`, `CommChannel`, `CodeArtifact`, `ReleaseVersion` | TechOps | active | High | Strong |
| `PROVIDES_CHANNEL` | Service exposes a communication pathway to end users or partners. | `Service`, `ToolingService` -> `CommChannel` | Engineering | active | Medium | Strong |
| `REPORTS_ON` | Analytics summarizing metrics for capabilities, services, or pipelines. | `Reporting`, `Observability` -> `ProductCapability`, `UseCase`, `Service`, `DataService` | Engineering | active | Medium | Strong |
| `REQUESTED_BY` | Actor initiating a change, deployment, or configuration update for a Rimidi asset. | `Actor` -> `Service`, `DataService`, `DeploymentType`, `ImplementationVariant`, `ReleaseVersion` | TechOps | active | Medium | Strong |
| `RESPONSIBLE_FOR` | Team charged with ongoing operations or quality of a workflow, integration, or service. | `Team` -> `Service`, `DataService`, `Reporting`, `Observability`, `EndUserWorkflow`, `SupportWorkflow`, `IntegrationPartner`, `EMRIntegration`, `DeviceIntegration`, `CommChannel`, `Client` | TechOps | active | High | Strong |
| `RESULTED_IN` | Release version produces new reporting, observability, or service state. | `ReleaseVersion` -> `Service`, `DataService`, `Reporting`, `Observability` | Engineering | active | Medium | Strong |
| `RUNS_ON` | Workload hosted on infrastructure. | `Service`, `DataService`, `Reporting`, `Observability` -> `InfraService` | Engineering | active | High | Strong |
| `SCHEDULED_BY` | Service or data pipeline triggered by an infrastructure primitive. | `Service`, `DataService` -> `InfraService` | Engineering | active | Medium | Strong |
| `SOURCED_FROM` | Data service ingests data from an upstream service, integration, or reporting asset. | `DataService` -> `Service`, `IntegrationPartner`, `EMRIntegration`, `DeviceIntegration`, `Reporting` | Engineering | active | Medium | Medium |
| `STORED_IN` | Reporting or observability asset persists data within an infrastructure primitive. | `Reporting`, `Observability` -> `InfraService` | Engineering | active | Medium | Strong |
| `SUPPORTS` | Runtime service or workflow supports use cases or client processes. | `Service`, `DataService`, `ToolingService`, `EndUserWorkflow` -> `UseCase`, `Client` | Engineering | active | High | Strong |
| `TRIGGERS` | Release version or incident triggers downstream services or workflows. | `ReleaseVersion` -> `Service`, `DataService`, `EndUserWorkflow`, `SupportWorkflow` | Engineering | active | Medium | Strong |
| `USES_CODE` | Runtime service or pipeline implemented by a specific code artifact. | `Service`, `DataService`, `ToolingService` -> `CodeArtifact` | Engineering | active | Medium | Strong |
| `USES_SECRET_FROM` | Service or pipeline retrieves credentials or configuration from infra. | `Service`, `DataService`, `ToolingService` -> `InfraService` | Engineering | active | Low | Medium |

Alias notes: `SOURCED_FROM` replaces `CONSUMES_FROM`; `STORED_IN` replaces `PERSISTED_IN`.

### Shared / CRM

| Type | Description | Source -> Target | Owner Team | Status | Usage | Maturity |
| --- | --- | --- | --- | --- | --- | --- |
| `CONFIGURED_FOR` | Implementation variant configured for a client organization. | `ImplementationVariant` -> `Client` | TechOps | planned | Medium | Medium |
| `INTEGRATES_WITH` | Service connects to an external partner integration for data exchange or automation. | `Service`, `DataService` -> `IntegrationPartner`, `EMRIntegration`, `DeviceIntegration` | ClientSuccess | active | High | Strong |
| `MANUFACTURED_BY` | Integration linked to its device manufacturer for traceability. | `DeviceIntegration` -> `DeviceVendor` | ClientSuccess | active | Medium | Strong |
| `USES` | Client uses or depends on a product capability. | `Client` -> `ProductCapability` | ClientSuccess | planned | Medium | Medium |

## Governance Reminders
- Every node and relationship captures `owner_team`, `category`, and provenance metadata (`source_system`, `jira_reference`, `release_reference`) so audits remain deterministic.
- Plane access is encoded in schema files: Skye normalizes inputs, Sunny reads against the KG, and humans remain responsible for write operations after reviewing `tools/validator.py` output.
- PHI-adjacent identifiers are redacted; use sanitized examples such as the sample IDs above when drafting prompts or seed data.
- Retired node types (Domain, Collection, Feeder, Seed, ReportTemplate, KnowledgeArticle, Policy, Contract, AccountContact) remain deprecated and must not reappear without a new ontology review.
