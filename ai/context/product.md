## Product Subgraph Snapshot

### Node labels
- `ProductCapability`: Feature area delivering measurable outcomes. Example ID `capability-remote-monitoring`.
- `UseCase`: Business outcome tied to clinical or operational goals. Example `usecase-rpm-outcomes`.
- `EndUserWorkflow`: Sequenced interactions executed by clinicians or automations. Example `workflow-hypertension-care-plan`.
- `SupportWorkflow`: Troubleshooting or incident playbook. Example `workflow-device-triage`.
- `UIComponent`: User-facing element such as modal, dashboard widget, or tab. Example `component-patient-dashboard-overview`.

### Relationships
- `ProductCapability -[:DELIVERS]-> UseCase`: Capability proves the business outcome.
- `ProductCapability -[:ENABLES]-> EndUserWorkflow`: Capability powers a workflow step.
- `ProductCapability -[:SUPPORTS_TROUBLESHOOTING]-> SupportWorkflow`: Capability documented for incident response.
- `Service|DataService -[:SUPPORTS]-> UseCase`: Runtime dependencies that make the use case real.
- `Service|ProductCapability -[:HAS_COMPONENT]-> UIComponent`: UI assets surfaced to users.
- `EndUserWorkflow -[:IMPLEMENTS]-> IntegrationPartner|EMRIntegration|DeviceIntegration|DataService`: External or data services executing the workflow.
- `SupportWorkflow` receives `SUPPORTS_TROUBLESHOOTING` from capabilities, services, and data services.

### Modeling tips
- Include `ui_area` for workflows or components when location matters.
- Always attach governance tags on new product artifacts (owner team usually Product Experience or Clinical Product).
- Validate read/write Cypher against Product nodes before referencing Shared/CRM or Platform context.
