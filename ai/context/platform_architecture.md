## Platform Architecture Subgraph Snapshot

### Node labels
- `Service`: Application or shared runtime (UI, API, worker). Example `service-device-api`.
- `ToolingService`: Internal console or admin tool. Example `tool-device-admin-console`.
- `DataService`: ETL/ELT pipeline orchestrating data movement. Example `datasvc-aquifer-sync`.
- `Reporting`: Analytics dataset or dashboard publication. Example `report-clinical-quality-scorecard`.
- `Observability`: Telemetry or logging surface. Example `observability-bluejay-dashboard`.
- `InfraService`: Hosting, scheduling, or storage primitive. Example `infra-aws-ecs-cluster`.
- `ReleaseVersion`: Deployment or change event with temporal metadata. Example `release-2025-04-rpm-ui`.
- `CodeArtifact`: Repository or package implementing runtime assets. Example `code-rimidi-container-api`.

### Relationships
- `Service|DataService -[:DEPENDS_ON]-> Service|DataService`: Runtime dependencies (`dependency_type` param expresses api, data, etc.).
- `Service|DataService|Reporting|Observability -[:RUNS_ON]-> InfraService`: Hosting environment (include `environment` parameter).
- `Service|DataService -[:SCHEDULED_BY]-> InfraService`: Scheduler relationships.
- `Service|DataService -[:USES_SECRET_FROM]-> InfraService`: Secrets/config retrieval.
- `Service|DataService|Reporting -[:MONITORED_BY]-> Observability`: Monitoring surfaces.
- `Reporting -[:REPORTS_ON]-> ProductCapability|UseCase|Service|DataService`: Analytics lineage.
- `DataService -[:FEEDS]-> Reporting|Observability`: Downstream outputs.
- `DataService -[:SOURCED_FROM]-> Service|IntegrationPartner|EMRIntegration|DeviceIntegration|Reporting`: Upstream inputs.
- `Reporting|Observability -[:STORED_IN]-> InfraService`: Persistence layer.
- `Service|DataService|ToolingService -[:USES_CODE]-> CodeArtifact`: Implementation link.
- `ReleaseVersion -[:TRIGGERS]-> Service|DataService|EndUserWorkflow|SupportWorkflow`: Change-driven activations.
- `ReleaseVersion -[:RESULTED_IN]-> Service|DataService|Reporting|Observability`: Change outcomes.

### Modeling tips
- Always capture `phi_sensitivity`, `access_role`, and `data_purpose` when relevant.
- For new pipelines, propose both `SOURCED_FROM` and `FEEDS` edges to avoid lineage gaps.
- Reference `tools/validator.py` and the seed Cypher when suggesting additions so automation stays consistent.
