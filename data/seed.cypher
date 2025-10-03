// Seed dataset to bootstrap the Rimidi knowledge graph.

MERGE (c:ProductCapability {id: 'capability-remote-monitoring'})
  SET c.name = 'Remote Patient Monitoring',
      c.status = 'live';

MERGE (w:Workflow {id: 'workflow-hypertension-care-plan'})
  SET w.name = 'Hypertension Care Plan',
      w.owner_team = 'Clinical Ops';

MERGE (i:Integration {id: 'integration-epic-bridge'})
  SET i.name = 'Epic Bridge',
      i.vendor = 'Epic Systems',
      i.status = 'live';

MERGE (c)-[:ENABLES {criticality: 'critical'}]->(w);
MERGE (w)-[:IMPLEMENTS {coverage: 'partial'}]->(i);
