# Natural Language to Cypher Examples

## Example 1
**Question**: Which workflows depend on Epic?
**Cypher**:
```cypher
MATCH (i:Integration {name: 'Epic Bridge'})<-[:IMPLEMENTS]-(w:Workflow)
RETURN w.id AS workflow_id, w.name AS workflow_name;
```

## Example 2
**Question**: What capabilities enable the Hypertension Care Plan?
**Cypher**:
```cypher
MATCH (c:ProductCapability)-[:ENABLES]->(:Workflow {id: 'workflow-hypertension-care-plan'})
RETURN c.id, c.name;
```

## Example 3
**Question**: Show integrations missing coverage metadata.
**Cypher**:
```cypher
MATCH (:Workflow)-[r:IMPLEMENTS]->(i:Integration)
WHERE r.coverage IS NULL
RETURN i.id, i.name;
```
