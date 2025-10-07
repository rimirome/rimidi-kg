# Sunny Cypher Examples

## 1. Read: Inspect platform dependencies for an analytics request
**Scenario**: A teammate wants to confirm which data service feeds the clinical quality reporting surface.

```cypher
MATCH (report:Reporting {id: $report_id})
OPTIONAL MATCH (datasvc:DataService)-[:FEEDS]->(report)
OPTIONAL MATCH (infra:InfraService)<-[:RUNS_ON]-(report)
RETURN report.name AS reportingSurface,
       collect(DISTINCT datasvc.id) AS upstreamPipelines,
       collect(DISTINCT infra.id) AS storageTargets;
```
Parameters
```json
{
  "report_id": "report-clinical-quality-scorecard"
}
```

## 2. Write: Propose a new DataService sourced from an EMR integration
**Reminder**: Present this as a dry run, ask for confirmation, and note that the teammate must run `python tools/validator.py --schema --data` after applying to seed data.

```cypher
:param env => 'stage';
:param tenant => 'coastal-health';
:param datasource_id => 'datasvc-cerner-careplans';
:param jira => 'INT-455';
:param release_note => 'Schema sync 2025-10';

MERGE (svc:DataService {id: $datasource_id})
  ON CREATE SET svc.name = 'Cerner Care Plan Sync',
                svc.description = 'Transforms Cerner care plan events into Rimidi workflows',
                svc.owner_team = 'Data Platform',
                svc.status = 'planned',
                svc.service_type = 'pipeline',
                svc.phi_sensitivity = 'phi',
                svc.access_mode = 'mixed',
                svc.data_purpose = ['transformation', 'reporting'],
                svc.source_system = 'airflow-registry',
                svc.jira_id = $jira,
                svc.release_note = $release_note;

MATCH (emr:EMRIntegration {id: 'integration-cerner'})
MERGE (svc)-[:SOURCED_FROM]->(emr);
MERGE (svc)-[:INTEGRATES_WITH]->(emr);
```

## 3. Governance reminder: Tag release events
**Scenario**: Closing out a release and linking affected services.

```cypher
:param env => 'prod';
:param tenant => 'global';
:param release_id => 'release-2025-11-observability-patch';
:param jira => 'CHG-2201';
:param note => 'Observability patch rollout 2025-11';

MERGE (rel:ReleaseVersion {id: $release_id})
  ON CREATE SET rel.name = 'Observability Patch - Nov 2025',
                rel.description = 'Rolls out improved monitoring thresholds',
                rel.owner_team = 'Reliability Engineering',
                rel.status = 'planned',
                rel.valid_from = datetime('2025-11-05T12:00:00Z'),
                rel.source_system = 'change-control',
                rel.jira_id = $jira,
                rel.release_note = $note;

MATCH (obs:Observability {id: 'observability-bluejay-dashboard'})
MERGE (rel)-[:RESULTED_IN]->(obs);
```

Sunny should always include a Dry Run Summary before surfacing the Cypher above and call out validation steps.
