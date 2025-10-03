// Engineering-focused queries.

// Services missing explicit infrastructure hosting documentation.
MATCH (s:Service)
WHERE NOT (s)-[:RUNS_ON]->(:InfraService)
RETURN s.id AS service_id, s.name AS service_name;

// Infra primitives lacking dependent services.
MATCH (i:InfraService)
WHERE NOT (:Service)-[:RUNS_ON]->(i)
RETURN i.id AS infra_id, i.name AS infra_name;

// Capabilities flagged as deprecated but still enabling workflows.
MATCH (c:ProductCapability {status: 'deprecated'})-[:ENABLES]->(w:Workflow)
RETURN c.id AS capability_id, w.id AS workflow_id;

// Services that depend on other services without specifying dependency type metadata.
MATCH (s:Service)-[r:DEPENDS_ON]->(up:Service)
WHERE r.dependency_type IS NULL
RETURN s.id AS service_id, up.id AS upstream_service;

// Observability coverage: services not monitored by any analytics surface.
MATCH (s:Service)
WHERE NOT (s)-[:MONITORED_BY]->(:AnalyticsSurface)
RETURN s.id AS service_id, s.name AS service_name;
