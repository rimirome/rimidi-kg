## Shared / CRM Subgraph Snapshot

### Node labels
- `Client`: Customer organisation licensed to use Rimidi. Example `client-coastal-health`.
- `DeploymentType`: Canonical deployment archetype across clients. Example `deployment-multitenant-prod`.
- `ImplementationVariant`: Configuration variant tailored to a specific tenant. Example `implementation-variant-standard`.
- `IntegrationPartner`: Third-party platform integration (non-EMR/device). Example `integration-xealth`.
- `EMRIntegration`: EMR vendor connectivity. Example `integration-cerner`.
- `DeviceIntegration`: Device connectivity endpoint. Example `integration-dexcom-g7`.
- `DeviceVendor`: Manufacturer linked to device integrations. Example `vendor-dexcom`.
- `CommChannel`: Communication pathway (SMS, email, phone, webhook). Example `channel-secure-messaging`.

### Relationships
- `ImplementationVariant -[:CONFIGURED_FOR]-> Client`: Tenant-specific configuration applied to a client.
- `Client -[:USES]-> ProductCapability`: Product capability relied on by a client process.
- `Team -[:OWNS|RESPONSIBLE_FOR|GOVERNS]-> Client|DeploymentType|ImplementationVariant|IntegrationPartner|EMRIntegration|DeviceIntegration|CommChannel`: Accountability and guardrails.
- `Service|ToolingService -[:PROVIDES_CHANNEL]-> CommChannel`: Runtime surfaces exposing communications.
- `Service|DataService -[:INTEGRATES_WITH]-> IntegrationPartner|EMRIntegration|DeviceIntegration`: External dependencies (`integration_mode` optional).
- `DeviceIntegration -[:MANUFACTURED_BY]-> DeviceVendor`: Traceability for hardware partners.
- `EndUserWorkflow -[:SUPPORTS]-> Client`: Workflow operationally supports a client process when modeled.

### Modeling tips
- Record `owner_team`, `category`, and provenance fields (`source_system`, `jira_reference`, `release_reference`) for every CRM node and relationship to keep lineage auditable.
- Use sanitized IDs (e.g., `client-coastal-health`) in Cypher; patient or tenant-specific values never enter the repo.
- When a client requires a distinct setup, model both the `DeploymentType` and `ImplementationVariant` so Luna can reason about upgrades via `CONFIGURED_FOR` and `GOVERNS`.
- Connect client usage back to product and platform nodes via `USES`, `SUPPORTS`, and `INTEGRATES_WITH` edges to keep cross-plane impact analysis deterministic.
