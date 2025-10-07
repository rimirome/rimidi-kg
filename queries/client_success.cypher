// Client Success focused queries aligned with the refreshed schema.

// Support workflows attached to the billing insights capability.
MATCH (:ProductCapability {id: 'capability-billing-insights'})-[:SUPPORTS_TROUBLESHOOTING]->(sw:SupportWorkflow)
RETURN sw.id AS workflow_id, sw.name AS workflow_name;

// Clients missing an assigned owning team.
MATCH (client:Client)
WHERE NOT (:Team)-[:OWNS]->(client)
RETURN client.id AS client_id, client.name AS client_name;

// Clients without an operational team assigned for day-to-day stewardship.
MATCH (client:Client)
WHERE NOT (:Team)-[:RESPONSIBLE_FOR]->(client)
RETURN client.id AS client_id, client.name AS client_name;

// Communication channels not mapped to a runtime surface.
MATCH (ch:CommChannel)
WHERE NOT (:Service)-[:PROVIDES_CHANNEL]->(ch)
  AND NOT (:ToolingService)-[:PROVIDES_CHANNEL]->(ch)
RETURN ch.id AS channel_id, ch.name AS channel_name;

// Integration coverage per client for device data ingestion.
MATCH (client:Client {id: 'client-coastal-health'})<-[:OWNS]-(team:Team)
OPTIONAL MATCH (svc:Service)-[:INTEGRATES_WITH]->(di:DeviceIntegration)
RETURN client.id AS client_id,
       team.id AS steward_team,
       collect(DISTINCT di.id) AS device_integrations;
