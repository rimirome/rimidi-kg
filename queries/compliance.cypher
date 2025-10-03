// Compliance and traceability checks.

// Workflows touching PHI without an assigned owner team.
MATCH (c:ProductCapability)-[:ENABLES]->(w:Workflow)
WHERE c.status = 'live' AND (w.owner_team IS NULL OR w.owner_team = '')
RETURN c.name AS capability, w.name AS workflow;

// Integrations missing vendor metadata.
MATCH (i:Integration)
WHERE i.vendor IS NULL OR i.vendor = ''
RETURN i.id AS integration_id, i.name AS integration_name;
