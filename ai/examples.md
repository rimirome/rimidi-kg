# Natural Language to Cypher Examples

## Example 1
**Question**: Which services support Remote Patient Monitoring?
**Cypher**:
```cypher
MATCH (s:Service)-[:SUPPORTS]->(:UseCase {id: 'usecase-rpm-support'})
RETURN s.id AS service_id, s.name AS service_name
ORDER BY service_name;
```

## Example 2
**Question**: Show infrastructure primitives hosting the Rimidi container.
**Cypher**:
```cypher
MATCH (:Service {id: 'service-rimidi-container'})-[:RUNS_ON]->(i:InfraService)
RETURN i.id AS infra_id, i.name AS infra_name;
```

## Example 3
**Question**: Which domains feed Aquifer through anonymized pipelines?
**Cypher**:
```cypher
MATCH (f:Feeder {id: 'feeder-aquifer'})-[:CONSUMES_FROM]->(d:Domain)
RETURN d.id AS source_domain, d.name AS source_name;
```

## Example 4
**Question**: What analytics surfaces monitor Coldbrew?
**Cypher**:
```cypher
MATCH (:Service {id: 'service-coldbrew'})-[:MONITORED_BY]->(a:AnalyticsSurface)
RETURN a.id AS surface_id, a.name AS surface_name;
```

## Example 5
**Question**: List domains that store PHI and their access modes.
**Cypher**:
```cypher
MATCH (d:Domain)
WHERE d.phi_sensitivity = 'phi'
RETURN d.id, d.name, d.access_mode;
```

## Example 6
**Question**: Which capabilities power billing operations and which services support the same use case?
**Cypher**:
```cypher
MATCH (u:UseCase {id: 'usecase-billing-operations'})
MATCH (cap:ProductCapability)-[:DELIVERS]->(u)
OPTIONAL MATCH (svc:Service)-[:SUPPORTS]->(u)
RETURN cap.id AS capability_id, cap.name AS capability_name,
       collect(DISTINCT svc.id) AS supporting_services
ORDER BY capability_name;
```

## Example 7
**Question**: Show device partners integrated with the Device Integration API.
**Cypher**:
```cypher
MATCH (:Service {id: 'service-device-api'})-[:INTEGRATES_WITH]->(i:Integration)
RETURN i.id AS integration_id, i.name AS integration_name
ORDER BY integration_name;
```
