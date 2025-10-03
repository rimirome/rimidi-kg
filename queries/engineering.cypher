// Engineering-focused queries.

// Integrations without explicit coverage on implementation relationships.
MATCH (:Workflow)-[r:IMPLEMENTS]->(i:Integration)
WHERE r.coverage IS NULL
RETURN i.id AS integration_id, i.name AS integration_name;

// Capabilities flagged as deprecated but still enabling workflows.
MATCH (c:ProductCapability {status: 'deprecated'})-[:ENABLES]->(w:Workflow)
RETURN c.id AS capability_id, w.id AS workflow_id;
