## Shared / CRM Subgraph Snapshot

### Node labels
- `Client`: Customer organisation using Rimidi. Example `client-coastal-health`.
- `DeploymentType`: Canonical deployment archetype shared across clients. Example `deployment-standalone-prod`.
- `IntegrationPartner`: Third-party platform integration (non-EMR/device). Example `integration-xealth`.
- `EMRIntegration`: EMR vendor connectivity. Example `integration-cerner`.
- `DeviceIntegration`: Device connectivity endpoint. Example `integration-dexcom-g7`.
- `DeviceVendor`: Manufacturer linked to device integrations. Example `vendor-dexcom`.
- `CommChannel`: Communication pathway (SMS, email, phone). Example `channel-sms`.

### Relationships
- `Service -[:PROVIDES_CHANNEL]-> CommChannel`: Runtime surfaces exposing communications.
- `DeviceIntegration -[:MANUFACTURED_BY]-> DeviceVendor`: Traceability for hardware partners.
- `Service|DataService -[:INTEGRATES_WITH]-> IntegrationPartner|EMRIntegration|DeviceIntegration`: External dependencies.
- `Team -[:OWNS]-> Client|DeploymentType|IntegrationPartner|EMRIntegration|DeviceIntegration|CommChannel`: Accountability.
- `Team -[:RESPONSIBLE_FOR]-> Client|IntegrationPartner|EMRIntegration|DeviceIntegration|CommChannel`: Operational responsibility.
- `Team -[:GOVERNS]-> DeploymentType|Client`: Compliance guardrails.
- `Actor -[:APPROVED_BY/REQUESTED_BY]-> DeploymentType`: Change-control links when deployments shift.

### Modeling tips
- When creating new clients or integrations, ensure `owner_team`, `source_system`, `jira_id`, and `release_note` document provenance.
- Always tag environment (`env`) and `tenant` parameters in change Cypher; CRM changes often target specific tenants.
- Reference existing integrations in `data/seed.cypher` before inventing new identifiers to avoid duplication.
