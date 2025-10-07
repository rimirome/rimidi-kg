// Seed dataset to bootstrap the Rimidi knowledge graph with the refreshed schema.

// --- Cross-cutting ---
MERGE (team:Team {id: 'team-techops'})
  SET team.name = 'TechOps',
      team.description = 'Technical Operations responsible for platform reliability and tooling.',
      team.owner_team = 'Operations',
      team.status = 'live',
      team.valid_from = datetime('2024-01-01T00:00:00Z'),
      team.source_system = 'schema-refresh',
      team.jira_id = 'KG-210',
      team.release_note = 'Schema rebuild 2025-10';

MERGE (actor:Actor {id: 'actor-rpeters'})
  SET actor.name = 'Riley Peters',
      actor.description = 'Change manager coordinating release approvals.',
      actor.owner_team = 'Operations',
      actor.status = 'live',
      actor.valid_from = datetime('2024-01-01T00:00:00Z'),
      actor.source_system = 'schema-refresh',
      actor.jira_id = 'KG-211',
      actor.release_note = 'Schema rebuild 2025-10';

// --- Product Graph ---
MERGE (cap:ProductCapability {id: 'capability-remote-monitoring'})
  SET cap.name = 'Remote Patient Monitoring',
      cap.description = 'End-to-end RPM capability that aggregates vitals and engagement signals.',
      cap.owner_team = 'Product Experience',
      cap.status = 'live',
      cap.valid_from = datetime('2023-10-01T00:00:00Z'),
      cap.source_system = 'roadmap-2024',
      cap.jira_id = 'KG-001',
      cap.release_note = 'Release-2024-Q4';

MERGE (usecase:UseCase {id: 'usecase-rpm-outcomes'})
  SET usecase.name = 'Improve RPM Outcomes',
      usecase.description = 'Track patient vitals and intervene when thresholds drift.',
      usecase.owner_team = 'Clinical Product',
      usecase.status = 'live',
      usecase.valid_from = datetime('2023-10-01T00:00:00Z'),
      usecase.source_system = 'roadmap-2024',
      usecase.jira_id = 'KG-002',
      usecase.release_note = 'Release-2024-Q4';

MERGE (workflow:EndUserWorkflow {id: 'workflow-hypertension-care-plan'})
  SET workflow.name = 'Hypertension Care Plan',
      workflow.description = 'Workflow guiding clinicians through monitoring, outreach, and documentation tasks.',
      workflow.owner_team = 'Clinical Product',
      workflow.ui_area = 'Care Coordination',
      workflow.status = 'live',
      workflow.valid_from = datetime('2024-01-15T00:00:00Z'),
      workflow.source_system = 'sunny-wip',
      workflow.jira_id = 'KG-003',
      workflow.release_note = 'Release-2024-Q4';

MERGE (support:SupportWorkflow {id: 'workflow-device-triage'})
  SET support.name = 'Device Connectivity Triage',
      support.description = 'Playbook used by Customer Success when a device stops reporting data.',
      support.owner_team = 'Customer Success',
      support.status = 'live',
      support.valid_from = datetime('2024-02-01T00:00:00Z'),
      support.source_system = 'support-hub',
      support.jira_id = 'KG-120',
      support.release_note = 'Release-2024-Q4';

MERGE (component:UIComponent {id: 'component-patient-dashboard-overview'})
  SET component.name = 'Patient Dashboard Overview',
      component.description = 'Summary card showing vitals, alerts, and recent outreach.',
      component.owner_team = 'Product Experience',
      component.ui_area = 'Patient Dashboard',
      component.status = 'live',
      component.access_role = 'external-facing',
      component.valid_from = datetime('2024-03-01T00:00:00Z'),
      component.source_system = 'design-system',
      component.jira_id = 'KG-121',
      component.release_note = 'Release-2024-Q4';

// --- Platform Architecture ---
MERGE (service:Service {id: 'service-device-api'})
  SET service.name = 'Device API',
      service.description = 'API handling inbound device measurements and publishing events.',
      service.owner_team = 'Platform Engineering',
      service.status = 'live',
      service.layer = 'business',
      service.service_type = 'api',
      service.provider = 'aws',
      service.code_name = 'coldbrew-device-api',
      service.phi_sensitivity = 'phi',
      service.access_role = 'internal',
      service.access_mode = 'mixed',
      service.data_purpose = ['ops', 'ingestion'],
      service.valid_from = datetime('2023-06-01T00:00:00Z'),
      service.source_system = 'service-catalog',
      service.jira_id = 'KG-050',
      service.release_note = 'Release-2023-Q3';

MERGE (tool:ToolingService {id: 'tool-device-admin-console'})
  SET tool.name = 'Device Admin Console',
      tool.description = 'Internal console for managing device integrations and credentials.',
      tool.owner_team = 'TechOps',
      tool.ui_area = 'Operations Portal',
      tool.status = 'live',
      tool.layer = 'business',
      tool.service_type = 'ui',
      tool.provider = 'aws',
      tool.code_name = 'gearbox-admin',
      tool.access_role = 'internal',
      tool.access_mode = 'mixed',
      tool.valid_from = datetime('2023-08-01T00:00:00Z'),
      tool.source_system = 'service-catalog',
      tool.jira_id = 'KG-051',
      tool.release_note = 'Release-2023-Q4';

MERGE (datasvc:DataService {id: 'datasvc-aquifer-sync'})
  SET datasvc.name = 'Aquifer Sync Pipeline',
      datasvc.description = 'ETL job that aggregates device readings and normalizes units.',
      datasvc.owner_team = 'Data Platform',
      datasvc.status = 'live',
      datasvc.service_type = 'pipeline',
      datasvc.code_name = 'aquifer-sync',
      datasvc.phi_sensitivity = 'phi',
      datasvc.access_mode = 'mixed',
      datasvc.data_purpose = ['transformation', 'reporting'],
      datasvc.valid_from = datetime('2023-09-15T00:00:00Z'),
      datasvc.source_system = 'airflow-registry',
      datasvc.jira_id = 'KG-052',
      datasvc.release_note = 'Release-2023-Q4';

MERGE (report:Reporting {id: 'report-clinical-quality-scorecard'})
  SET report.name = 'Clinical Quality Scorecard',
      report.description = 'Curated dashboard powering quality metrics across RPM programs.',
      report.owner_team = 'Analytics',
      report.ui_area = 'Analytics Hub',
      report.status = 'live',
      report.surface_type = 'dashboard',
      report.access_role = 'internal',
      report.data_purpose = ['reporting', 'insight'],
      report.valid_from = datetime('2024-01-10T00:00:00Z'),
      report.source_system = 'sisense',
      report.jira_id = 'KG-060',
      report.release_note = 'Release-2024-Q1';

MERGE (obs:Observability {id: 'observability-bluejay-dashboard'})
  SET obs.name = 'Bluejay Observability Dashboard',
      obs.description = 'Telemetry dashboard tracking ingestion latency and error rates.',
      obs.owner_team = 'Reliability Engineering',
      obs.status = 'live',
      obs.surface_type = 'dashboard',
      obs.access_role = 'internal',
      obs.data_purpose = ['observability', 'monitoring'],
      obs.valid_from = datetime('2023-12-01T00:00:00Z'),
      obs.source_system = 'grafana',
      obs.jira_id = 'KG-061',
      obs.release_note = 'Release-2024-Q1';

MERGE (infra:InfraService {id: 'infra-aws-ecs-cluster'})
  SET infra.name = 'AWS ECS Cluster',
      infra.description = 'Container cluster hosting the device API and related workloads.',
      infra.owner_team = 'Platform Engineering',
      infra.status = 'live',
      infra.layer = 'infrastructure',
      infra.provider = 'aws',
      infra.valid_from = datetime('2022-05-01T00:00:00Z'),
      infra.source_system = 'aws-inventory',
      infra.jira_id = 'KG-070',
      infra.release_note = 'Release-2022-Q2';

MERGE (release:ReleaseVersion {id: 'release-2025-04-rpm-ui'})
  SET release.name = 'RPM UI Refresh - April 2025',
      release.description = 'Release introducing enhanced dashboards and device alerts.',
      release.owner_team = 'TechOps',
      release.status = 'live',
      release.valid_from = datetime('2025-04-15T12:00:00Z'),
      release.source_system = 'change-control',
      release.jira_id = 'CHG-2045',
      release.release_note = 'Release-2025-04';

MERGE (artifact:CodeArtifact {id: 'code-rimidi-container-api'})
  SET artifact.name = 'rimidi-container/api',
      artifact.description = 'Primary repository powering device ingestion services.',
      artifact.owner_team = 'Platform Engineering',
      artifact.status = 'live',
      artifact.valid_from = datetime('2022-01-01T00:00:00Z'),
      artifact.source_system = 'github',
      artifact.jira_id = 'KG-080',
      artifact.release_note = 'Initial import';

// --- Shared / CRM ---
MERGE (client:Client {id: 'client-coastal-health'})
  SET client.name = 'Coastal Health Network',
      client.description = 'Enterprise healthcare system leveraging Rimidi RPM and analytics.',
      client.owner_team = 'Client Success',
      client.status = 'live',
      client.access_role = 'external-facing',
      client.valid_from = datetime('2023-05-01T00:00:00Z'),
      client.source_system = 'salesforce',
      client.jira_id = 'CS-450',
      client.release_note = 'Client onboarding 2023-05';

MERGE (deployment:DeploymentType {id: 'deployment-multitenant-prod'})
  SET deployment.name = 'Multi-tenant Production',
      deployment.description = 'Shared production environment with PHI isolation and release guardrails.',
      deployment.owner_team = 'TechOps',
      deployment.status = 'live',
      deployment.valid_from = datetime('2022-09-01T00:00:00Z'),
      deployment.source_system = 'deployment-playbook',
      deployment.jira_id = 'KG-090',
      deployment.release_note = 'Deployment taxonomy refresh 2022';

MERGE (partner:IntegrationPartner {id: 'integration-xealth'})
  SET partner.name = 'Xealth',
      partner.description = 'Digital therapeutics orchestration platform integrated with Rimidi.',
      partner.owner_team = 'Strategic Integrations',
      partner.vendor = 'Xealth',
      partner.status = 'live',
      partner.access_role = 'partner',
      partner.valid_from = datetime('2024-03-10T00:00:00Z'),
      partner.source_system = 'integration-registry',
      partner.jira_id = 'INT-320',
      partner.release_note = 'Integration wave 2024-Q2';

MERGE (emr:EMRIntegration {id: 'integration-cerner'})
  SET emr.name = 'Cerner FHIR',
      emr.description = 'FHIR-based EMR integration for patient demographics and encounters.',
      emr.owner_team = 'Strategic Integrations',
      emr.vendor = 'Oracle Cerner',
      emr.status = 'live',
      emr.access_role = 'partner',
      emr.valid_from = datetime('2023-11-01T00:00:00Z'),
      emr.source_system = 'integration-registry',
      emr.jira_id = 'INT-210',
      emr.release_note = 'EMR integration program 2023';

MERGE (device_integ:DeviceIntegration {id: 'integration-dexcom-g7'})
  SET device_integ.name = 'Dexcom G7 Integration',
      device_integ.description = 'Device integration ingesting glucose values via Dexcom APIs.',
      device_integ.owner_team = 'Platform Engineering',
      device_integ.vendor = 'Dexcom',
      device_integ.status = 'live',
      device_integ.access_role = 'partner',
      device_integ.data_purpose = ['ingestion', 'ops'],
      device_integ.valid_from = datetime('2024-04-01T00:00:00Z'),
      device_integ.source_system = 'integration-registry',
      device_integ.jira_id = 'INT-330',
      device_integ.release_note = 'Device integrations 2024-Q2';

MERGE (vendor:DeviceVendor {id: 'vendor-dexcom'})
  SET vendor.name = 'Dexcom',
      vendor.description = 'Manufacturer of Dexcom continuous glucose monitoring devices.',
      vendor.owner_team = 'Strategic Integrations',
      vendor.status = 'live',
      vendor.valid_from = datetime('2022-05-01T00:00:00Z'),
      vendor.source_system = 'vendor-catalog',
      vendor.jira_id = 'INT-120',
      vendor.release_note = 'Vendor registry baseline';

MERGE (channel:CommChannel {id: 'channel-sms'})
  SET channel.name = 'SMS Messaging',
      channel.description = 'Two-way SMS channel for patient outreach and nudges.',
      channel.owner_team = 'Engagement',
      channel.status = 'live',
      channel.access_mode = 'mixed',
      channel.access_role = 'external-facing',
      channel.valid_from = datetime('2023-01-01T00:00:00Z'),
      channel.source_system = 'engagement-registry',
      channel.jira_id = 'ENG-204',
      channel.release_note = 'Messaging platform migration';

// --- Relationships ---
MERGE (cap)-[:DELIVERS]->(usecase);
MERGE (cap)-[:ENABLES]->(workflow);
MERGE (cap)-[:SUPPORTS_TROUBLESHOOTING]->(support);
MERGE (service)-[:SUPPORTS]->(usecase);
MERGE (service)-[:SUPPORTS_TROUBLESHOOTING]->(support);
MERGE (service)-[:HAS_COMPONENT]->(component);
MERGE (service)-[:PROVIDES_CHANNEL]->(channel);
MERGE (service)-[:DEPENDS_ON {dependency_type: 'data'}]->(datasvc);
MERGE (service)-[:RUNS_ON {environment: 'production'}]->(infra);
MERGE (service)-[:USES_SECRET_FROM]->(infra);
MERGE (service)-[:MONITORED_BY]->(obs);
MERGE (service)-[:USES_CODE]->(artifact);
MERGE (service)-[:INTEGRATES_WITH]->(partner);
MERGE (service)-[:INTEGRATES_WITH]->(emr);
MERGE (service)-[:INTEGRATES_WITH]->(device_integ);

MERGE (tool)-[:ADMINISTERED_BY]->(team);
MERGE (tool)-[:USES_CODE]->(artifact);
MERGE (tool)-[:RUNS_ON {environment: 'production'}]->(infra);
MERGE (tool)-[:SUPPORTS_TROUBLESHOOTING]->(support);

MERGE (datasvc)-[:SOURCED_FROM]->(service);
MERGE (datasvc)-[:SOURCED_FROM]->(device_integ);
MERGE (datasvc)-[:INTEGRATES_WITH]->(device_integ);
MERGE (datasvc)-[:FEEDS]->(report);
MERGE (datasvc)-[:FEEDS]->(obs);
MERGE (datasvc)-[:DEPENDS_ON {dependency_type: 'schedule'}]->(service);
MERGE (datasvc)-[:RUNS_ON {environment: 'production'}]->(infra);
MERGE (datasvc)-[:SCHEDULED_BY]->(infra);
MERGE (datasvc)-[:USES_SECRET_FROM]->(infra);
MERGE (datasvc)-[:USES_CODE]->(artifact);
MERGE (datasvc)-[:SUPPORTS]->(usecase);
MERGE (datasvc)-[:SUPPORTS_TROUBLESHOOTING]->(support);

MERGE (report)-[:REPORTS_ON]->(usecase);
MERGE (report)-[:REPORTS_ON]->(service);
MERGE (report)-[:RUNS_ON {environment: 'production'}]->(infra);
MERGE (report)-[:STORED_IN]->(infra);
MERGE (report)-[:MONITORED_BY]->(obs);

MERGE (obs)-[:RUNS_ON {environment: 'production'}]->(infra);
MERGE (obs)-[:STORED_IN]->(infra);

MERGE (vendor)<-[:MANUFACTURED_BY]-(device_integ);

MERGE (team)-[:OWNS]->(cap);
MERGE (team)-[:OWNS]->(service);
MERGE (team)-[:OWNS]->(datasvc);
MERGE (team)-[:OWNS]->(report);
MERGE (team)-[:OWNS]->(client);
MERGE (team)-[:OWNS]->(deployment);
MERGE (team)-[:RESPONSIBLE_FOR]->(workflow);
MERGE (team)-[:RESPONSIBLE_FOR]->(service);
MERGE (team)-[:RESPONSIBLE_FOR]->(datasvc);
MERGE (team)-[:RESPONSIBLE_FOR]->(report);
MERGE (team)-[:RESPONSIBLE_FOR]->(obs);
MERGE (team)-[:RESPONSIBLE_FOR]->(partner);
MERGE (team)-[:RESPONSIBLE_FOR]->(emr);
MERGE (team)-[:RESPONSIBLE_FOR]->(device_integ);
MERGE (team)-[:RESPONSIBLE_FOR]->(client);
MERGE (team)-[:GOVERNS]->(deployment);
MERGE (team)-[:GOVERNS]->(client);


MERGE (workflow)-[:IMPLEMENTS]->(datasvc);
MERGE (workflow)-[:IMPLEMENTS]->(emr);
MERGE (support)<-[:SUPPORTS_TROUBLESHOOTING]-(cap);
MERGE (support)<-[:SUPPORTS_TROUBLESHOOTING]-(datasvc);

MERGE (release)-[:TRIGGERS]->(service);
MERGE (release)-[:TRIGGERS]->(datasvc);
MERGE (release)-[:TRIGGERS]->(workflow);
MERGE (release)-[:RESULTED_IN]->(report);
MERGE (release)-[:RESULTED_IN]->(obs);

MERGE (actor)-[:REQUESTED_BY]->(service);
MERGE (actor)-[:REQUESTED_BY]->(release);
MERGE (actor)-[:APPROVED_BY]->(deployment);
MERGE (actor)-[:APPROVED_BY]->(release);
