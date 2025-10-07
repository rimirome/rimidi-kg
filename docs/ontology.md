# Rimidi KG Ontology

The Rimidi knowledge graph organizes vocabulary across Product, Platform Architecture, Shared/CRM, and cross-cutting governance so teams can reason about the platform with a shared language. Every label or relationship defined below is sourced from `data/rimidi_kg_review_master_v2.csv` and mapped into the refreshed schema under `schema/`.

## Subgraph Overview
- **Product Graph** — Capabilities, use cases, workflows, and UI components that define how Rimidi delivers value to clinicians, patients, and staff.
- **Platform Architecture Graph** — Runtime services, data pipelines, reporting packages, observability tooling, infrastructure, releases, and code artifacts that power the product.
- **Shared / CRM Graph** — Clients, deployment archetypes, integration partners, EMR/device connections, device vendors, and communication channels that link Rimidi to the healthcare ecosystem.
- **Cross-cutting** — Teams and actors (people) that request, approve, or govern changes across every subgraph.

Keep the subgraphs linked by explicit relationships (for example, services that support use cases, data services feeding reporting packages, or deployment types governed by a team) so governance and automation stay aligned.

## Node Labels

### Product Graph

| Label | Description | Example | Notes |
| --- | --- | --- | --- |
| `ProductCapability` | End-to-end feature area that delivers measurable clinical or operational value. | `capability-remote-monitoring` | Anchor for roadmap, release notes, and outcomes. |
| `UseCase` | Business outcome delivered to providers, staff, or patients. | `usecase-time-in-range` | Tied to capabilities and the services that make it real. |
| `EndUserWorkflow` | Sequenced product or operational steps executed by humans or automations. | `workflow-device-onboarding` | Capture UI surface via `ui_area` and connect to supporting services. |
| `SupportWorkflow` | Troubleshooting or incident playbook used by Customer Success, Product, or TechOps. | `workflow-rpm-alert-reset` | Reference runtime assets and integrations needed for recovery. |
| `UIComponent` | Visible or interactive UI element such as a dashboard widget, modal, or navigation tab. | `component-patient-chart-overview` | Use `ui_area` plus `HAS_COMPONENT` to connect to capabilities and services. |

### Platform Architecture Graph

| Label | Description | Example | Notes |
| --- | --- | --- | --- |
| `Service` | Application or shared service operated by Rimidi (UI, API, worker, automation, etc.). | `service-device-api` | Track dependencies, infra, integrations, and ownership. |
| `ToolingService` | Internal utility or admin tool exposed to operations or back-office teams. | `tool-sso-admin-console` | Always include managing team and UI surface. |
| `DataService` | Data platform job or pipeline that extracts, transforms, or loads Rimidi data. | `datasvc-aquifer-sync` | Model upstream sources, targets, and infra dependencies. |
| `Reporting` | Business intelligence report or curated dataset published for analytics consumption. | `report-clinical-quality-scorecard` | Capture surface type and downstream consumers. |
| `Observability` | Telemetry, dashboarding, or logging surface used to monitor the platform. | `observability-bluejay-dashboard` | Link to monitored services and infra persistence. |
| `InfraService` | Cloud or infrastructure primitive providing hosting, scheduling, storage, or messaging. | `infra-aws-ecs-cluster` | Used by services, data pipelines, and reporting packages. |
| `ReleaseVersion` | Deployment, incident, configuration change, or release artifact with temporal metadata. | `release-2025-04-rpm-ui` | Connect to triggered services/workflows and resulting assets. |
| `CodeArtifact` | Source repository, package, or path that implements a capability, service, or pipeline. | `code-rimidi-container-api` | Map via `USES_CODE` to the runtime components that rely on it. |

### Shared / CRM Graph

| Label | Description | Example | Notes |
| --- | --- | --- | --- |
| `Client` | Healthcare organization or customer licensed to use Rimidi. | `client-coastal-health` | Capture accountable team and deployment type. |
| `DeploymentType` | Canonical deployment configuration or tenant archetype shared across clients. | `deployment-multitenant-prod` | Governs release and compliance guardrails for clients. |
| `IntegrationPartner` | Third-party vendor or platform integrated with Rimidi offerings (non-EMR/device). | `integration-xealth` | Treat as partner-level surface; device/EMR specifics modeled separately. |
| `EMRIntegration` | EMR vendor connection powering data exchange with Rimidi. | `integration-cerner` | Use alongside integration partners for broader workflows. |
| `DeviceIntegration` | Device connectivity integration ingesting clinical measurements or PGHD. | `integration-dexcom-g7` | Links to device vendor and upstream/downstream services. |
| `DeviceVendor` | Manufacturer that produces healthcare devices supported by Rimidi integrations. | `vendor-omron` | Attach from device integrations to retain traceability. |
| `CommChannel` | Communication pathway used to reach clinicians, patients, or partners (SMS, email, phone, etc.). | `channel-sms` | Services expose channels the platform supports. |

### Cross-cutting Graph

| Label | Description | Example | Notes |
| --- | --- | --- | --- |
| `Team` | Organizational unit responsible for Rimidi resources and accountable outcomes. | `team-techops` | Use for ownership, governance, and operational responsibilities. |
| `Actor` | Individual requester or approver associated with product, platform, or client changes. | `actor-rpeters` | Supports change control and audit requirements. |

## Relationship Types

| Type | Description | Typical Source → Target |
| --- | --- | --- |
| `ENABLES` | Capability provides functionality to an end-user workflow. | `ProductCapability` → `EndUserWorkflow` |
| `DELIVERS` | Capability delivers or proves out a use case. | `ProductCapability` → `UseCase` |
| `SUPPORTS` | Runtime service underpins a business use case. | (`Service` ∣ `DataService` ∣ `ToolingService`) → `UseCase` |
| `SUPPORTS_TROUBLESHOOTING` | Capability or runtime service documented by a support workflow. | (`ProductCapability` ∣ `Service` ∣ `DataService`) → `SupportWorkflow` |
| `IMPLEMENTS` | Workflow leverages an integration or data service. | `EndUserWorkflow` → (`IntegrationPartner` ∣ `EMRIntegration` ∣ `DeviceIntegration` ∣ `DataService`) |
| `HAS_COMPONENT` | Capability or service composed of a UI component. | (`ProductCapability` ∣ `Service`) → `UIComponent` |
| `OWNS` | Team accountable for an asset across the graph. | `Team` → product/platform/CRM nodes |
| `ADMINISTERED_BY` | Tooling service managed by a team. | `ToolingService` → `Team` |
| `RESPONSIBLE_FOR` | Team charged with operations or quality of a workflow, integration, or service. | `Team` → (`Service` ∣ `DataService` ∣ `Reporting` ∣ `Observability` ∣ integrations ∣ workflows ∣ `Client`) |
| `REQUESTED_BY` / `APPROVED_BY` | Actor initiates or approves changes. | `Actor` → (`Service` ∣ `DataService` ∣ `DeploymentType` ∣ `ReleaseVersion`) |
| `GOVERNS` | Team-defined guardrail for deployments, services, or clients. | `Team` → (`DeploymentType` ∣ `Service` ∣ `DataService` ∣ `Client`) |
| `DEPENDS_ON` | Service-level dependency (API, data, logging, etc.). | (`Service` ∣ `DataService`) → (`Service` ∣ `DataService`) |
| `RUNS_ON` / `SCHEDULED_BY` | Runtime component hosted or scheduled by infrastructure. | service/data/report/observability → `InfraService` |
| `USES_SECRET_FROM` | Service or pipeline retrieves credentials/config from infrastructure. | (`Service` ∣ `DataService`) → `InfraService` |
| `MONITORED_BY` | Runtime component monitored by an observability surface. | (`Service` ∣ `DataService` ∣ `Reporting`) → `Observability` |
| `REPORTS_ON` | Reporting package summarizes metrics for a capability, use case, service, or pipeline. | `Reporting` → (`ProductCapability` ∣ `UseCase` ∣ `Service` ∣ `DataService`) |
| `FEEDS` | Data service publishes curated datasets to reporting or observability surfaces. | `DataService` → (`Reporting` ∣ `Observability`) |
| `SOURCED_FROM` | Data service ingests from an upstream service or integration. | `DataService` → (`Service` ∣ `IntegrationPartner` ∣ `EMRIntegration` ∣ `DeviceIntegration` ∣ `Reporting`) |
| `STORED_IN` | Reporting/observability assets persist into infrastructure. | (`Reporting` ∣ `Observability`) → `InfraService` |
| `USES_CODE` | Runtime component implemented by a code artifact. | (`Service` ∣ `DataService` ∣ `ToolingService`) → `CodeArtifact` |
| `TRIGGERS` | Release version or incident triggers downstream services or workflows. | `ReleaseVersion` → (`Service` ∣ `DataService` ∣ `EndUserWorkflow` ∣ `SupportWorkflow`) |
| `RESULTED_IN` | Release version produces new runtime, reporting, or observability state. | `ReleaseVersion` → (`Service` ∣ `DataService` ∣ `Reporting` ∣ `Observability`) |
| `PROVIDES_CHANNEL` | Service exposes a communication channel. | `Service` → `CommChannel` |
| `MANUFACTURED_BY` | Device integration associated with its device vendor. | `DeviceIntegration` → `DeviceVendor` |
| `INTEGRATES_WITH` | Service or data pipeline connects to an external partner integration. | (`Service` ∣ `DataService`) → (`IntegrationPartner` ∣ `EMRIntegration` ∣ `DeviceIntegration`) |

## Metadata & Governance
- **Identifiers**: Use stable, slug-style IDs (`service-device-api`, `report-rpm-dashboard`, `deployment-multitenant-prod`). They should survive renames and align with automation payloads.
- **Required provenance fields**: Capture `owner_team`, `source_system`, `jira_id`, and `release_note` (via `attributes.governance.*`) whenever nodes or edges are created.
- **Runtime context**: Apply `service.layer`, `service.service_type`, `service.provider`, and `access.*` attributes to clarify architecture posture and data handling expectations.
- **Surface tagging**: `ui_area` and `data.surface_type` help Sunny or downstream tooling present the right UI and reporting surfaces for a request.
- **Change tracking**: Connect `ReleaseVersion` nodes to the services, pipelines, and reporting assets they trigger or update, and link the responsible `Actor`/`Team` via change-control relationships.

Consistently applying these definitions allows Sunny, TechOps, and Product teams to navigate the platform with shared intent and reduce translation overhead between engineering, operations, and customer-facing workflows.
