// Data ecosystem and lineage queries for the refreshed ontology.

// Data services without upstream source definitions.
MATCH (ds:DataService)
WHERE NOT (ds)-[:SOURCED_FROM]->(:Service)
  AND NOT (ds)-[:SOURCED_FROM]->(:IntegrationPartner)
  AND NOT (ds)-[:SOURCED_FROM]->(:EMRIntegration)
  AND NOT (ds)-[:SOURCED_FROM]->(:DeviceIntegration)
  AND NOT (ds)-[:SOURCED_FROM]->(:Reporting)
RETURN ds.id AS data_service_id, ds.name AS data_service_name
ORDER BY data_service_name;

// Data services that do not publish to reporting or observability surfaces.
MATCH (ds:DataService)
WHERE NOT (ds)-[:FEEDS]->(:Reporting)
  AND NOT (ds)-[:FEEDS]->(:Observability)
RETURN ds.id AS data_service_id, ds.name AS data_service_name;

// Reporting assets missing explicit storage targets.
MATCH (rep:Reporting)
WHERE NOT (rep)-[:STORED_IN]->(:InfraService)
RETURN rep.id AS reporting_id, rep.name AS reporting_name;

// Observability tooling without hosting metadata.
MATCH (obs:Observability)
WHERE NOT (obs)-[:RUNS_ON]->(:InfraService)
RETURN obs.id AS observability_id, obs.name AS observability_name;

// Data services sourcing from integrations without an integration_mode tag.
MATCH (ds:DataService)-[rel:SOURCED_FROM]->(src)
WHERE (src:IntegrationPartner OR src:EMRIntegration OR src:DeviceIntegration)
  AND rel.integration_mode IS NULL
RETURN ds.id AS data_service_id, src.id AS source_id;

// Release versions that resulted in new reporting artifacts.
MATCH (rel:ReleaseVersion)-[:RESULTED_IN]->(rep:Reporting)
RETURN rel.id AS release_id, rel.release_reference AS release_reference, rep.id AS reporting_id
ORDER BY release_reference DESC;
