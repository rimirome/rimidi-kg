## Product Subgraph Snapshot

### Node labels
- `ProductCapability`: End-to-end feature area delivering measurable outcomes. Example `capability-remote-monitoring`.
- `UseCase`: Business outcome tied to clinical or operational goals. Example `usecase-hypertension-management`.
- `EndUserWorkflow`: Sequenced interactions executed by clinicians or automations. Example `workflow-alert-triage`.
- `SupportWorkflow`: Troubleshooting or incident playbook used by Product. Example `workflow-integration-reset`.
- `UIComponent`: User-facing element such as modal, dashboard widget, or tab. Example `component-care-team-dashboard`.

### Relationships
- `ProductCapability|EndUserWorkflow -[:DELIVERS]-> UseCase`: Capabilities and workflows deliver measurable value.
- `ProductCapability -[:ENABLES]-> EndUserWorkflow`: Capability powers a workflow stage.
- `ProductCapability|Service|ToolingService -[:HAS_COMPONENT]-> UIComponent`: Surfaces and modules tied to the capability or service.
- `ProductCapability|Service|DataService -[:SUPPORTS_TROUBLESHOOTING]-> SupportWorkflow`: Runtime assets documented for incident response.
- `EndUserWorkflow -[:IMPLEMENTS]-> IntegrationPartner|EMRIntegration|DeviceIntegration|DataService`: External or data services executing each step.
- `Service|DataService|ToolingService|EndUserWorkflow -[:SUPPORTS]-> UseCase|Client`: Operational dependencies that make the use case real or support client processes.
- `ReleaseVersion -[:TRIGGERS]-> EndUserWorkflow|SupportWorkflow`: Change events that start user-facing flows.

### Modeling tips
- Populate `owner_team`, `category`, and provenance fields (`source_system`, `jira_reference`, `release_reference`) for every product node so Sunny can explain governance posture.
- Use sanitized IDs (e.g., `capability-remote-monitoring`) when generating Cypher; PHI descriptors must never appear.
- Sunny is read-only; escalate structural changes or new labels to Luna so governance metadata stays synced with the schema.
- Combine product nodes with platform/CRM context via `SUPPORTS`, `IMPLEMENTS`, `USES`, and `INTEGRATES_WITH` edges to maintain traceable lineage.
