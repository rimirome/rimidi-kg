# Rimidi KG Ontology

The ontology defines the shared language across Product, TechOps, and Shared/CRM teams. Every node label or relationship type in `schema/` should map to a business concept so automations, dashboards, and graph queries stay aligned with how the platform is actually described.

## Subgraph Overview
- **Product Graph** — Capabilities, workflows, UI elements, report templates, and policies that describe what Rimidi delivers to users.
- **TechOps Graph** — Services, internal tooling, infrastructure, data lineage, and operational events that explain how the platform runs.
- **Shared / CRM Graph** — Clients, implementations, devices, contracts, channels, and partner contexts that connect Product to customer outcomes.

Keep the graphs distinct but linked through explicit relationships (for example, Product capabilities referencing TechOps services and Shared device vendors).

## Node Labels

### Product Graph

| Label | Description | Example | Notes |
| --- | --- | --- | --- |
| `ProductCapability` | End-to-end product capability or feature area powering clinical or operational value. | `capability-user-management` | Anchor for Product roadmap discussions. |
| `UseCase` | Business outcome delivered to providers, staff, or patients. | `usecase-rpm-support` | Connects to capabilities and services that make it real. |
| `Workflow` | Sequenced steps that deliver a clinical or operational outcome. | `workflow-hypertension-care-plan` | Often backed by automations or integrations. |
| `SupportWorkflow` | Troubleshooting or support playbook used by Customer Success or Product. | `workflow-device-troubleshooting` | Reference these when mapping incident or support flows. |
| `UIComponent` | Visible or interactive element (modal, header, dashboard widget). | `component-patient-chart-header` | Use `ui_area` to flag where in the product the component lives. |
| `ReportTemplate` | Reusable report definition leveraged by analytics surfaces or workflows. | `report-rpm-summary-template` | Link from workflows or dashboards that embed it. |
| `KnowledgeArticle` | Support or documentation entry describing expected behavior or guided troubleshooting. | `ka-rpm-billing-periods` | Connects to capabilities, workflows, or support workflows. |
| `Policy` | Compliance or business guardrail applied to services, domains, or tenants. | `policy-audit-billing` | Reference applicable subgraph nodes via `GOVERNS` or `APPLIES_TO`. |
| `CodeArtifact` | Source code reference (repo/path) implementing a capability or workflow. | `code-rimidi-container-api` | Attach via `USES_CODE` / `IMPLEMENTED_BY`. |

### TechOps Graph

| Label | Description | Example | Notes |
| --- | --- | --- | --- |
| `Service` | Application or shared service operated by Rimidi (UI, API, worker, etc.). | `service-device-api` | Model dependencies, infra, and integrations. |
| `ToolingService` | Internal Rimidi utility or admin tool for back-office teams. | `tool-user-admin-table` | Always capture `owner_team` and optionally `ui_area`. |
| `InfraService` | Cloud infrastructure primitive providing hosting, storage, or monitoring. | `infra-ecs-rimidi` | Connect via `RUNS_ON`, `SCHEDULED_BY`, or `PERSISTED_IN`. |
| `Domain` | Governed data store or logical grouping. | `domain-aquifer` | Track PHI and access metadata. |
| `Collection` | Concrete dataset within a domain. | `collection-audit-care-plans` | Link back to parent domain via `CONTAINS_COLLECTION`. |
| `Feeder` | Pipeline or process that moves/derives data between domains. | `feeder-aquifer` | Use `FEEDS` / `CONSUMES_FROM` for lineage. |
| `Seed` @deprecated | Versioned dataset historically curated for ML/analytics. | `seed-rpm-device-signals` | Prefer Domains + Collections; keep for legacy references only. |
| `AnalyticsSurface` | Reporting, dashboarding, or observability UI. | `surface-bluejay` | Use `USES_TEMPLATE`, `REPORTS_ON`, `MONITORED_BY`. |
| `Event` | Deployment, incident, or configuration change with temporal metadata. | `event-rpm-config-2025-03-01` | Link to services or domains impacted. |

### Shared / CRM Graph

| Label | Description | Example | Notes |
| --- | --- | --- | --- |
| `Integration` | External system, vendor, or API connected to Rimidi services. | `integration-dexcom-g6` | Tie to services and the corresponding device vendor. |
| `DeviceVendor` | Device manufacturer distinct from integration endpoints. | `vendor-omron` | Connect using `MANUFACTURED_BY`. |
| `Channel` | Communication pathway (SMS, Email, In-App, Telehealth). | `channel-sms` | Services expose channels via `PROVIDES_CHANNEL`. |
| `Client` | Healthcare organization or customer entity licensed to use Rimidi. | `client-coastal-health` | Optional until populated; connect to implementations and capabilities. |
| `Implementation` | Client-specific deployment or environment configuration. | `implementation-coastal-prod` | Use future edges like `CONFIGURED_FOR`. |
| `Contract` | Commercial agreement or SOW covering a client relationship. | `contract-coastal-2024` | Capture term metadata when available. |
| `AccountContact` | Human relationship manager at a client organization. | `contact-sarah-jones` | Useful for CRM automations; populate as needed. |
| `Team` | Organizational unit responsible for Rimidi resources. | `team-techops` | Connect via `OWNS`, `RESPONSIBLE_FOR`, `ADMINISTERED_BY`. |
| `Actor` | Individual requester or approver associated with changes. | `actor-rpeters` | Use for change control and audit contexts. |

### Deprecated or Historical Concepts
- `Seed` remains in the schema but is marked `@deprecated`; favor modeling analytics-ready data as Domains + Collections with Feeders.
- Historical label `Seeder` (not currently defined) should not be reintroduced; rely on `Feeder` + provenance metadata instead.

## Relationship Types

| Type | Description | Typical Usage |
| --- | --- | --- |
| `ENABLES` | Capability provides functionality to a workflow. | Capability → Workflow |
| `DELIVERS` | Capability delivers a business use case. | Capability → UseCase |
| `SUPPORTS` | Service supports a use case. | Service → UseCase |
| `SUPPORTS_TROUBLESHOOTING` | Capability or service documented by a support workflow. | (Capability ∣ Service) → SupportWorkflow |
| `IMPLEMENTS` | Workflow leverages an integration. | Workflow → Integration |
| `HAS_COMPONENT` | Capability or service composed of a UI component. | (Capability ∣ Service) → UIComponent |
| `PROVIDES_CHANNEL` | Service exposes a communication pathway. | Service → Channel |
| `MANUFACTURED_BY` | Integration linked to its device manufacturer. | Integration → DeviceVendor |
| `USES_TEMPLATE` | Workflow or analytics surface uses a report template. | (Workflow ∣ AnalyticsSurface) → ReportTemplate |
| `DEPENDS_ON` | Service dependency graph (api/data/logging/etc.). | Service → Service |
| `RUNS_ON` / `SCHEDULED_BY` | Service hosted on or triggered by infrastructure. | Service → InfraService |
| `USES_SECRET_FROM` | Service retrieves credentials/config from infra. | Service → InfraService |
| `MONITORED_BY` / `OBSERVES` | Services and analytics surfaces share telemetry. | Service ↔ AnalyticsSurface |
| `REPORTS_ON` | Analytics surface reports on a domain. | AnalyticsSurface → Domain |
| `INTEGRATES_WITH` | Service connects to external integration. | Service → Integration |
| `CONTAINS_COLLECTION` | Domain contains a dataset. | Domain → Collection |
| `FEEDS` / `CONSUMES_FROM` | Feeder populates or reads from a domain. | Feeder ↔ Domain |
| `PERSISTED_IN` | Domain stored on infrastructure. | Domain → InfraService |
| `POWERS` / `BACKED_BY` / `WRITES_TO` | Data powering services or written by seeds/feeders. | Domain/Seed ↔ Service/Domain |
| `DERIVED_FROM` | Seed derived from a domain. | Seed → Domain |
| `OWNS` | Team accountable for a resource. | Team → Service |
| `ADMINISTERED_BY` | Tooling service managed by a team. | ToolingService → Team |
| `RESPONSIBLE_FOR` | Team responsible for a domain, integration, or workflow. | Team → Domain/Integration/Workflow |
| `REQUESTED_BY` / `APPROVED_BY` | Actor initiating or approving change. | Actor → Service |
| `GOVERNS` / `APPLIES_TO` | Policy constrains configuration or data. | Policy → Service/Domain |
| `EXPLAINS` / `DOCUMENTS` | Knowledge article documents capability or workflow. | KnowledgeArticle → Capability/Workflow |
| `USES_CODE` / `IMPLEMENTED_BY` | Service or workflow implemented by a code artifact. | Service/Workflow ↔ CodeArtifact |
| `TRIGGERS` / `RESULTED_IN` | Event drives workflow/service or impacts domain. | Event → Service/Domain |

## Metadata & Governance
- **Identifiers**: All nodes use slug-style IDs (`component-disease-view-column`, `tool-role-manager`). Prefer stable identifiers that survive organizational renames.
- **Required provenance fields**: Always capture `owner_team`, `source_system`, `jira_id`, and `release_note` when adding new nodes or edges.
- **Optional UI context**: Use `ui_area` (new attribute) to tag the part of the product a component, template, or tool supports (e.g., "Patient Chart", "Device Integration").
- **Access controls**: Apply PHI and access-level attributes on domains, collections, feeders, and services that handle sensitive data.
- **Aliases**: Maintain synonyms in `data/aliases.yaml` so Sunny can fuzzy-match natural language terms (for example, "Admin Tool" → `ToolingService`).

Consistently applying the ontology ensures Sunny can guide Rimidi teammates across product capabilities, operational services, and client-facing contexts without ambiguity.
