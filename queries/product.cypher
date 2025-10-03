// Product management insights.

// Capabilities supporting the Hypertension Care Plan.
MATCH (c:ProductCapability)-[:ENABLES]->(w:Workflow {id: 'workflow-hypertension-care-plan'})
RETURN c.id AS capability_id, c.name AS capability_name
ORDER BY capability_name;

// Workflows missing an assigned owner.
MATCH (w:Workflow)
WHERE w.owner_team IS NULL OR w.owner_team = ''
RETURN w.id AS workflow_id, w.name AS workflow_name;

// Use cases that currently have no supporting services documented.
MATCH (u:UseCase)
WHERE NOT (:Service)-[:SUPPORTS]->(u)
RETURN u.id AS use_case_id, u.name AS use_case_name;

// Capabilities powering Billing Operations & Compliance with their supporting services.
MATCH (u:UseCase {id: 'usecase-billing-operations'})
MATCH (cap:ProductCapability)-[:DELIVERS]->(u)
OPTIONAL MATCH (svc:Service)-[:SUPPORTS]->(u)
RETURN cap.id AS capability_id, cap.name AS capability_name,
       collect(DISTINCT svc.id) AS supporting_services
ORDER BY capability_name;
