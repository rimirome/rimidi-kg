// Engineering-focused queries aligned with the regenerated schema.

// Services missing explicit infrastructure hosting documentation.
MATCH (s:Service)
WHERE NOT (s)-[:RUNS_ON]->(:InfraService)
RETURN s.id AS service_id, s.name AS service_name
ORDER BY service_name;

// Infra primitives that currently lack dependent workloads.
MATCH (infra:InfraService)
WHERE NOT (:Service)-[:RUNS_ON]->(infra)
  AND NOT (:DataService)-[:RUNS_ON]->(infra)
RETURN infra.id AS infra_id, infra.name AS infra_name;

// Capabilities marked deprecated but still enabling workflows.
MATCH (cap:ProductCapability {lifecycle_state: 'deprecated'})-[:ENABLES]->(wf:EndUserWorkflow)
RETURN cap.id AS capability_id, wf.id AS workflow_id;

// Service-to-service dependencies missing dependency_type metadata.
MATCH (s:Service)-[rel:DEPENDS_ON]->(up:Service)
WHERE rel.dependency_type IS NULL
RETURN s.id AS service_id, up.id AS upstream_service;

// Services not monitored by any observability surface.
MATCH (s:Service)
WHERE NOT (s)-[:MONITORED_BY]->(:Observability)
RETURN s.id AS service_id, s.name AS service_name;

// Integration coverage: ingestion and interop services missing external links.
MATCH (s:Service)
WHERE s.id IN ['service-device-api', 'service-fhir-gateway', 'service-emr-adapters', 'service-export-pipelines']
  AND NOT (s)-[:INTEGRATES_WITH]->(:IntegrationPartner)
  AND NOT (s)-[:INTEGRATES_WITH]->(:EMRIntegration)
  AND NOT (s)-[:INTEGRATES_WITH]->(:DeviceIntegration)
RETURN s.id AS service_id, s.name AS service_name;

// Code artifacts associated with services.
MATCH (s:Service)-[:USES_CODE]->(code:CodeArtifact)
RETURN s.id AS service_id, code.id AS artifact_id;

// Release versions triggering downstream services.
MATCH (rel:ReleaseVersion)-[:TRIGGERS]->(s:Service)
RETURN rel.id AS release_id, rel.release_reference AS release_reference, s.id AS service_id
ORDER BY release_reference DESC;
