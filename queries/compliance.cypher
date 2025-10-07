// Compliance and traceability checks for the dual-plane ontology.

// Deployment types lacking a governing team.
MATCH (dt:DeploymentType)
WHERE NOT (:Team)-[:GOVERNS]->(dt)
RETURN dt.id AS deployment_type_id, dt.name AS deployment_type_name;

// Release versions without an approval record.
MATCH (rel:ReleaseVersion)
WHERE NOT (:Actor)-[:APPROVED_BY]->(rel)
RETURN rel.id AS release_id, rel.release_reference AS release_reference;

// Data services pulling secrets without declaring data scope.
MATCH (ds:DataService)-[rel:USES_SECRET_FROM]->(infra:InfraService)
WHERE rel.data_scope IS NULL
RETURN ds.id AS data_service_id, infra.id AS infra_id;

// Communication channels not tied to any runtime surface.
MATCH (ch:CommChannel)
WHERE NOT (:Service)-[:PROVIDES_CHANNEL]->(ch)
  AND NOT (:ToolingService)-[:PROVIDES_CHANNEL]->(ch)
RETURN ch.id AS channel_id, ch.name AS channel_name;

// Capabilities or services marked low maturity for audit follow-up.
MATCH (n)
WHERE (n:ProductCapability OR n:Service OR n:DataService)
  AND n.governance_maturity = 'Weak'
RETURN labels(n) AS labels, n.id AS node_id, n.name AS node_name;
