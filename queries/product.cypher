// Product management insights.

// Capabilities supporting the Hypertension Care Plan.
MATCH (c:ProductCapability)-[:ENABLES]->(w:Workflow {id: 'workflow-hypertension-care-plan'})
RETURN c.id AS capability_id, c.name AS capability_name
ORDER BY capability_name;

// Workflows missing an assigned owner.
MATCH (w:Workflow)
WHERE w.owner_team IS NULL OR w.owner_team = ''
RETURN w.id AS workflow_id, w.name AS workflow_name;
