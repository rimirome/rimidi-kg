## Platform Architecture Subgraph Snapshot

### Node labels
- `Service`: Application or shared runtime (UI, API, worker). Example `service-scheduling-api`.
- `ToolingService`: Internal console or admin tool. Example `tooling-deployment-console`.
- `DataService`: ETL/ELT pipeline orchestrating data movement. Example `datasvc-metrics-aggregation`.
- `Reporting`: Analytics dataset or dashboard publication. Example `report-operational-dashboard`.
- `Observability`: Telemetry or logging surface. Example `observability-loki-pipeline`.
- `InfraService`: Hosting, scheduling, or storage primitive. Example `infra-aws-ecs-cluster`.
- `ReleaseVersion`: Deployment or change record with temporal metadata. Example `release-2025-q1-platform`.
- `CodeArtifact`: Repository or package implementing runtime assets. Example `code-rimidi-kg-repo`.

### Relationships
- `Service|DataService -[:DEPENDS_ON]-> Service|DataService`: Capture runtime and data dependencies (`dependency_type` details the mode).
- `Service|DataService|Reporting|Observability -[:RUNS_ON]-> InfraService`: Hosting or persistence environment (`environment` property).
- `Service|DataService -[:SCHEDULED_BY]-> InfraService`: Scheduler or cron primitive triggering the workload.
- `Service|DataService|ToolingService -[:USES_SECRET_FROM]-> InfraService`: Secrets/config retrieval with `data_scope` for sensitivity.
- `Service|DataService|Reporting -[:MONITORED_BY]-> Observability`: Monitoring surfaces for runtime health metrics.
- `Reporting|Observability -[:REPORTS_ON]-> ProductCapability|UseCase|Service|DataService`: Analytics or telemetry summarising domain impact.
- `DataService -[:FEEDS]-> Reporting|Observability`: Downstream outputs produced by the pipeline.
- `DataService -[:SOURCED_FROM]-> Service|IntegrationPartner|EMRIntegration|DeviceIntegration|Reporting`: Upstream sources and integrations (`integration_mode` when helpful).
- `Reporting|Observability -[:STORED_IN]-> InfraService`: Persistence detail for analytics/telemetry stores.
- `Service|DataService|ToolingService -[:USES_CODE]-> CodeArtifact`: Implementation link to source control.
- `ReleaseVersion -[:TRIGGERS]-> Service|DataService|EndUserWorkflow|SupportWorkflow`: Change events activating workloads.
- `ReleaseVersion -[:RESULTED_IN]-> Service|DataService|Reporting|Observability`: Outputs or state shifts caused by the change.

### Modeling tips
- Always populate `owner_team`, `category`, and provenance fields so Luna can audit changes before committing writes.
- Maintain sanitized identifiers (e.g., `service-scheduling-api`) when referencing runtime assets; omit secrets from the repo.
- Pair pipelines with both `SOURCED_FROM` and `FEEDS` edges to keep lineage bi-directional and document integration mechanisms via `integration_mode`.
- Use `CONFIGURED_FOR` and `GOVERNS` when an implementation variant or deployment affects platform services to keep downstream automation in sync.
