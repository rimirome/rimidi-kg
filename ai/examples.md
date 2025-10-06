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

## Example 8
**Question**: Which knowledge articles explain the Billing Insights capability?
**Cypher**:
```cypher
MATCH (ka:KnowledgeArticle)-[:EXPLAINS]->(:ProductCapability {id: 'capability-billing-insights'})
RETURN ka.id, ka.name, ka.url;
```

## Example 9
**Question**: Which code artifacts implement the Hypertension Care Plan workflow?
**Cypher**:
```cypher
MATCH (:Workflow {id: 'workflow-hypertension-care-plan'})-[:IMPLEMENTED_BY]->(code:CodeArtifact)
RETURN code.id, code.repo, code.path;
```

## Example 10
**Question**: List recent events that triggered the billing toolkit service.
**Cypher**:
```cypher
MATCH (evt:Event)-[:TRIGGERS]->(:Service {id: 'service-billing-toolkit'})
RETURN evt.id, evt.valid_from AS occurred_at, evt.status
ORDER BY occurred_at DESC;
```

## Example 11
**Question**: Which services and domains would be impacted if we modify the Billing Insights capability?
**Cypher**:
```cypher
MATCH (cap:ProductCapability {id: 'capability-billing-insights'})-[:DELIVERS]->(:UseCase)<-[:SUPPORTS]-(svc:Service)
OPTIONAL MATCH (svc)-[:BACKED_BY]->(domain:Domain)
RETURN svc.id AS service_id, collect(DISTINCT domain.id) AS domains
```
