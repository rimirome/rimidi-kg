// Seed dataset to bootstrap the Rimidi knowledge graph with core nodes.

MERGE (cap:ProductCapability {id: 'capability-remote-monitoring'})
  SET cap.name = 'Remote Patient Monitoring',
      cap.status = 'live',
      cap.owner_team = 'Product';

MERGE (cap_billing:ProductCapability {id: 'capability-billing-insights'})
  SET cap_billing.name = 'Billing Insights & Compliance',
      cap_billing.status = 'live',
      cap_billing.owner_team = 'Product Experience';
MERGE (cap_device:ProductCapability {id: 'capability-device-insights'})
  SET cap_device.name = 'Device Insight Enhancements',
      cap_device.status = 'live',
      cap_device.owner_team = 'Platform Engineering';
MERGE (cap_coord:ProductCapability {id: 'capability-care-coordination'})
  SET cap_coord.name = 'Care Team Coordination',
      cap_coord.status = 'live',
      cap_coord.owner_team = 'Product Experience';
MERGE (cap_audit:ProductCapability {id: 'capability-audit-readiness'})
  SET cap_audit.name = 'Audit Readiness',
      cap_audit.status = 'live',
      cap_audit.owner_team = 'Product Experience';
MERGE (cap_api:ProductCapability {id: 'capability-api-access'})
  SET cap_api.name = 'External API Access',
      cap_api.status = 'live',
      cap_api.owner_team = 'Platform Engineering';
MERGE (cap_analytics:ProductCapability {id: 'capability-analytics-usability'})
  SET cap_analytics.name = 'Analytics Usability',
      cap_analytics.status = 'live',
      cap_analytics.owner_team = 'Product Experience';
MERGE (cap_engagement:ProductCapability {id: 'capability-patient-engagement'})
  SET cap_engagement.name = 'Patient Engagement Emails',
      cap_engagement.status = 'live',
      cap_engagement.owner_team = 'Product Experience';
MERGE (cap_integration:ProductCapability {id: 'capability-integration-hub'})
  SET cap_integration.name = 'Integration Partner Hub',
      cap_integration.status = 'live',
      cap_integration.owner_team = 'Platform Engineering';
MERGE (cap_ehr:ProductCapability {id: 'capability-ehr-interoperability'})
  SET cap_ehr.name = 'EHR Interoperability',
      cap_ehr.status = 'live',
      cap_ehr.owner_team = 'Platform Engineering';
MERGE (cap_data_export:ProductCapability {id: 'capability-data-export'})
  SET cap_data_export.name = 'Data Exports & Reporting',
      cap_data_export.status = 'live',
      cap_data_export.owner_team = 'Data Insights';
MERGE (cap_disease:ProductCapability {id: 'capability-disease-views'})
  SET cap_disease.name = 'Disease View Experience',
      cap_disease.status = 'live',
      cap_disease.owner_team = 'Product Experience';
MERGE (cap_chart_nav:ProductCapability {id: 'capability-patient-chart-navigation'})
  SET cap_chart_nav.name = 'Patient Chart Subnavs',
      cap_chart_nav.status = 'live',
      cap_chart_nav.owner_team = 'Product Experience';
MERGE (cap_telehealth:ProductCapability {id: 'capability-telehealth-programs'})
  SET cap_telehealth.name = 'Telehealth Vendor Programs',
      cap_telehealth.status = 'live',
      cap_telehealth.owner_team = 'Commercial Operations';

MERGE (use1:UseCase {id: 'usecase-rpm-support'})
  SET use1.name = 'Remote Patient Monitoring',
      use1.status = 'live';
MERGE (use2:UseCase {id: 'usecase-chronic-care'})
  SET use2.name = 'Chronic Condition Management',
      use2.status = 'live';
MERGE (use3:UseCase {id: 'usecase-clinical-decision-support'})
  SET use3.name = 'Clinical Decision Support',
      use3.status = 'planned';
MERGE (use4:UseCase {id: 'usecase-billing-operations'})
  SET use4.name = 'Billing Operations & Compliance',
      use4.status = 'live';
MERGE (use5:UseCase {id: 'usecase-care-coordination'})
  SET use5.name = 'Care Team Coordination',
      use5.status = 'live';
MERGE (use6:UseCase {id: 'usecase-device-ingestion'})
  SET use6.name = 'Patient Device Ingestion',
      use6.status = 'live';
MERGE (use7:UseCase {id: 'usecase-ehr-interoperability'})
  SET use7.name = 'EHR Interoperability',
      use7.status = 'live';
MERGE (use8:UseCase {id: 'usecase-data-exports'})
  SET use8.name = 'Data Exports & Reporting',
      use8.status = 'live';

MERGE (cap)-[:DELIVERS]->(use1);
MERGE (cap)-[:DELIVERS]->(use2);
MERGE (cap)-[:DELIVERS]->(use3);
MERGE (cap_billing)-[:DELIVERS]->(use4);
MERGE (cap_device)-[:DELIVERS]->(use1);
MERGE (cap_coord)-[:DELIVERS]->(use5);
MERGE (cap_audit)-[:DELIVERS]->(use4);
MERGE (cap_api)-[:DELIVERS]->(use1);
MERGE (cap_api)-[:DELIVERS]->(use4);
MERGE (cap_analytics)-[:DELIVERS]->(use4);
MERGE (cap_engagement)-[:DELIVERS]->(use1);
MERGE (cap_device)-[:DELIVERS]->(use6);
MERGE (cap_integration)-[:DELIVERS]->(use7);
MERGE (cap_ehr)-[:DELIVERS]->(use7);
MERGE (cap_data_export)-[:DELIVERS]->(use8);
MERGE (cap_integration)-[:DELIVERS]->(use8);

MERGE (wf:Workflow {id: 'workflow-hypertension-care-plan'})
  SET wf.name = 'Hypertension Care Plan',
      wf.owner_team = 'Clinical Ops',
      wf.status = 'live';
MERGE (cap)-[:ENABLES {criticality: 'critical'}]->(wf);

MERGE (integ:Integration {id: 'integration-epic-bridge'})
  SET integ.name = 'Epic Bridge',
      integ.vendor = 'Epic Systems',
      integ.status = 'live';
MERGE (wf)-[:IMPLEMENTS {coverage: 'partial'}]->(integ);

MERGE (integ_dexcom:Integration {id: 'integration-dexcom-g6'})
  SET integ_dexcom.name = 'Dexcom G6 API',
      integ_dexcom.vendor = 'Dexcom',
      integ_dexcom.status = 'live';
MERGE (integ_abbott:Integration {id: 'integration-abbott-libre'})
  SET integ_abbott.name = 'Abbott LibreView',
      integ_abbott.vendor = 'Abbott',
      integ_abbott.status = 'live';
MERGE (integ_smartmeter:Integration {id: 'integration-smartmeter'})
  SET integ_smartmeter.name = 'Smart Meter',
      integ_smartmeter.vendor = 'Smart Meter',
      integ_smartmeter.status = 'live';
MERGE (integ_baxter:Integration {id: 'integration-baxter-sharesource'})
  SET integ_baxter.name = 'Baxter ShareSource',
      integ_baxter.vendor = 'Baxter',
      integ_baxter.status = 'live';
MERGE (integ_xealth:Integration {id: 'integration-xealth'})
  SET integ_xealth.name = 'Xealth',
      integ_xealth.vendor = 'Xealth',
      integ_xealth.status = 'live';
MERGE (integ_cerner:Integration {id: 'integration-cerner-fhir'})
  SET integ_cerner.name = 'Cerner FHIR',
      integ_cerner.vendor = 'Oracle Cerner',
      integ_cerner.status = 'live';
MERGE (integ_nextgen:Integration {id: 'integration-nextgen'})
  SET integ_nextgen.name = 'NextGen API',
      integ_nextgen.vendor = 'NextGen',
      integ_nextgen.status = 'live';
MERGE (integ_athena:Integration {id: 'integration-athenahealth'})
  SET integ_athena.name = 'athenahealth API',
      integ_athena.vendor = 'athenahealth',
      integ_athena.status = 'live';
MERGE (svc_ui:Service {id: 'service-ui'})
  SET svc_ui.name = 'Rimidi User Interface',
      svc_ui.status = 'live',
      svc_ui.owner_team = 'Product Experience',
      svc_ui.layer = 'business',
      svc_ui.service_type = 'ui';
MERGE (svc_api:Service {id: 'service-rimidi-container'})
  SET svc_api.name = 'Rimidi Container',
      svc_api.status = 'live',
      svc_api.owner_team = 'Platform Engineering',
      svc_api.layer = 'business',
      svc_api.service_type = 'api',
      svc_api.code_name = 'rimidi';
MERGE (svc_sched:Service {id: 'service-coldbrew'})
  SET svc_sched.name = 'Coldbrew',
      svc_sched.status = 'live',
      svc_sched.owner_team = 'Platform Engineering',
      svc_sched.layer = 'business',
      svc_sched.service_type = 'scheduler';
MERGE (svc_billing:Service {id: 'service-billing-toolkit'})
  SET svc_billing.name = 'Billing Toolkit',
      svc_billing.status = 'live',
      svc_billing.owner_team = 'Product Experience',
      svc_billing.layer = 'business',
      svc_billing.service_type = 'billing';
MERGE (svc_notes:Service {id: 'service-patient-sticky-notes'})
  SET svc_notes.name = 'Patient Sticky Notes',
      svc_notes.status = 'live',
      svc_notes.owner_team = 'Product Experience',
      svc_notes.layer = 'business',
      svc_notes.service_type = 'collaboration';
MERGE (svc_api_platform:Service {id: 'service-api-platform'})
  SET svc_api_platform.name = 'Public API Platform',
      svc_api_platform.status = 'live',
      svc_api_platform.owner_team = 'Platform Engineering',
      svc_api_platform.layer = 'business',
      svc_api_platform.service_type = 'api';
MERGE (svc_dashboard:Service {id: 'service-analytics-dashboard'})
  SET svc_dashboard.name = 'Analytics Dashboard',
      svc_dashboard.status = 'live',
      svc_dashboard.owner_team = 'Product Experience',
      svc_dashboard.layer = 'business',
      svc_dashboard.service_type = 'analytics-ui';
MERGE (svc_device:Service {id: 'service-device-api'})
  SET svc_device.name = 'Device Integration API',
      svc_device.status = 'live',
      svc_device.owner_team = 'Platform Engineering',
      svc_device.layer = 'business',
      svc_device.service_type = 'ingestion';
MERGE (svc_fhir:Service {id: 'service-fhir-gateway'})
  SET svc_fhir.name = 'FHIR Gateway',
      svc_fhir.status = 'live',
      svc_fhir.owner_team = 'Platform Engineering',
      svc_fhir.layer = 'business',
      svc_fhir.service_type = 'interoperability';
MERGE (svc_emr:Service {id: 'service-emr-adapters'})
  SET svc_emr.name = 'EMR Adapter Suite',
      svc_emr.status = 'live',
      svc_emr.owner_team = 'Platform Engineering',
      svc_emr.layer = 'business',
      svc_emr.service_type = 'interoperability';
MERGE (svc_export:Service {id: 'service-export-pipelines'})
  SET svc_export.name = 'Data Export Pipelines',
      svc_export.status = 'live',
      svc_export.owner_team = 'Data Insights',
      svc_export.layer = 'business',
      svc_export.service_type = 'data-export';
MERGE (svc_ui)-[:SUPPORTS]->(use1);
MERGE (svc_ui)-[:SUPPORTS]->(use2);
MERGE (svc_api)-[:SUPPORTS]->(use1);
MERGE (svc_api)-[:SUPPORTS]->(use3);
MERGE (svc_ui)-[:DEPENDS_ON {dependency_type: 'api'}]->(svc_api);
MERGE (svc_api)-[:DEPENDS_ON {dependency_type: 'schedule'}]->(svc_sched);
MERGE (svc_sched)-[:DEPENDS_ON {dependency_type: 'api'}]->(svc_api);
MERGE (svc_billing)-[:SUPPORTS]->(use4);
MERGE (svc_billing)-[:SUPPORTS]->(use1);
MERGE (svc_notes)-[:SUPPORTS]->(use5);
MERGE (svc_api_platform)-[:SUPPORTS]->(use1);
MERGE (svc_api_platform)-[:SUPPORTS]->(use4);
MERGE (svc_dashboard)-[:SUPPORTS]->(use4);
MERGE (svc_dashboard)-[:SUPPORTS]->(use1);
MERGE (svc_device)-[:DEPENDS_ON {dependency_type: 'data'}]->(svc_api);
MERGE (svc_device)-[:DEPENDS_ON {dependency_type: 'api'}]->(svc_api_platform);
MERGE (svc_fhir)-[:DEPENDS_ON {dependency_type: 'api'}]->(svc_api_platform);
MERGE (svc_emr)-[:DEPENDS_ON {dependency_type: 'api'}]->(svc_api_platform);
MERGE (svc_export)-[:DEPENDS_ON {dependency_type: 'data'}]->(svc_device);
MERGE (svc_export)-[:DEPENDS_ON {dependency_type: 'data'}]->(svc_billing);
MERGE (svc_device)-[:SUPPORTS]->(use6);
MERGE (svc_fhir)-[:SUPPORTS]->(use7);
MERGE (svc_emr)-[:SUPPORTS]->(use7);
MERGE (svc_export)-[:SUPPORTS]->(use8);
MERGE (svc_export)-[:SUPPORTS]->(use4);
MERGE (svc_dashboard)-[:DEPENDS_ON {dependency_type: 'data'}]->(svc_billing);

MERGE (infra_ecs:InfraService {id: 'infra-ecs-rimidi'})
  SET infra_ecs.name = 'Amazon ECS (Rimidi Containers)',
      infra_ecs.status = 'live',
      infra_ecs.provider = 'aws',
      infra_ecs.service_type = 'container-orchestration';
MERGE (infra_lambda:InfraService {id: 'infra-lambda-coldbrew'})
  SET infra_lambda.name = 'AWS Lambda (Coldbrew)',
      infra_lambda.status = 'live',
      infra_lambda.provider = 'aws',
      infra_lambda.service_type = 'function';
MERGE (infra_eventbridge:InfraService {id: 'infra-eventbridge-coldbrew'})
  SET infra_eventbridge.name = 'Amazon EventBridge (Coldbrew Schedulers)',
      infra_eventbridge.status = 'live',
      infra_eventbridge.provider = 'aws',
      infra_eventbridge.service_type = 'scheduler';
MERGE (infra_s3_audit:InfraService {id: 'infra-s3-audit'})
  SET infra_s3_audit.name = 'Amazon S3 (Audit Exports)',
      infra_s3_audit.status = 'live',
      infra_s3_audit.provider = 'aws',
      infra_s3_audit.service_type = 'object-storage';
MERGE (svc_api)-[:RUNS_ON {environment: 'production'}]->(infra_ecs);
MERGE (svc_sched)-[:RUNS_ON {environment: 'production'}]->(infra_lambda);
MERGE (svc_sched)-[:SCHEDULED_BY]->(infra_eventbridge);
MERGE (svc_billing)-[:RUNS_ON {environment: 'production'}]->(infra_ecs);
MERGE (svc_notes)-[:RUNS_ON {environment: 'production'}]->(infra_ecs);
MERGE (svc_api_platform)-[:RUNS_ON {environment: 'production'}]->(infra_ecs);
MERGE (svc_dashboard)-[:RUNS_ON {environment: 'production'}]->(infra_ecs);
MERGE (svc_device)-[:RUNS_ON {environment: 'production'}]->(infra_ecs);
MERGE (svc_fhir)-[:RUNS_ON {environment: 'production'}]->(infra_ecs);
MERGE (svc_emr)-[:RUNS_ON {environment: 'production'}]->(infra_ecs);
MERGE (svc_export)-[:RUNS_ON {environment: 'production'}]->(infra_ecs);

MERGE (domain_hearth:Domain {id: 'domain-hearth'})
  SET domain_hearth.name = 'Hearth',
      domain_hearth.status = 'live',
      domain_hearth.domain_kind = 'application',
      domain_hearth.phi_sensitivity = 'phi',
      domain_hearth.access_role = 'internal',
      domain_hearth.access_mode = 'writable',
      domain_hearth.data_purpose = ['audit-grade', 'reporting'];
MERGE (domain_aquifer:Domain {id: 'domain-aquifer'})
  SET domain_aquifer.name = 'Aquifer',
      domain_aquifer.status = 'live',
      domain_aquifer.domain_kind = 'analytics',
      domain_aquifer.phi_sensitivity = 'non-phi',
      domain_aquifer.access_role = 'external-facing',
      domain_aquifer.access_mode = 'read-only',
      domain_aquifer.data_purpose = ['insight', 'reporting'];
MERGE (domain_audit:Domain {id: 'domain-audit-repository'})
  SET domain_audit.name = 'Audit Repository',
      domain_audit.status = 'live',
      domain_audit.domain_kind = 'audit',
      domain_audit.phi_sensitivity = 'phi',
      domain_audit.access_role = 'internal',
      domain_audit.access_mode = 'read-only',
      domain_audit.data_purpose = ['audit-grade', 'reporting'];
MERGE (svc_api)-[:BACKED_BY]->(domain_hearth);
MERGE (svc_ui)-[:BACKED_BY]->(domain_hearth);
MERGE (domain_hearth)-[:POWERS]->(svc_api);
MERGE (domain_aquifer)-[:POWERS]->(svc_ui);
MERGE (svc_billing)-[:BACKED_BY]->(domain_hearth);
MERGE (svc_billing)-[:BACKED_BY]->(domain_audit);
MERGE (svc_dashboard)-[:BACKED_BY]->(domain_aquifer);
MERGE (svc_api_platform)-[:BACKED_BY]->(domain_hearth);
MERGE (svc_notes)-[:BACKED_BY]->(domain_hearth);
MERGE (svc_device)-[:BACKED_BY]->(domain_hearth);
MERGE (svc_fhir)-[:BACKED_BY]->(domain_hearth);
MERGE (svc_emr)-[:BACKED_BY]->(domain_hearth);
MERGE (svc_export)-[:BACKED_BY]->(domain_aquifer);
MERGE (svc_export)-[:BACKED_BY]->(domain_audit);
MERGE (svc_device)-[:INTEGRATES_WITH]->(integ_dexcom);
MERGE (svc_device)-[:INTEGRATES_WITH]->(integ_abbott);
MERGE (svc_device)-[:INTEGRATES_WITH]->(integ_smartmeter);
MERGE (svc_fhir)-[:INTEGRATES_WITH]->(integ);
MERGE (svc_fhir)-[:INTEGRATES_WITH]->(integ_cerner);
MERGE (svc_emr)-[:INTEGRATES_WITH]->(integ_nextgen);
MERGE (svc_emr)-[:INTEGRATES_WITH]->(integ_athena);
MERGE (svc_export)-[:INTEGRATES_WITH]->(integ_baxter);
MERGE (svc_export)-[:INTEGRATES_WITH]->(integ_xealth);
MERGE (domain_audit)-[:POWERS]->(svc_billing);
MERGE (domain_hearth)-[:POWERS]->(svc_device);
MERGE (domain_hearth)-[:POWERS]->(svc_fhir);
MERGE (domain_hearth)-[:POWERS]->(svc_emr);
MERGE (domain_aquifer)-[:POWERS]->(svc_export);
MERGE (domain_aquifer)-[:POWERS]->(svc_dashboard);

MERGE (collection_hearth:Collection {id: 'collection-hearth-patient-records'})
  SET collection_hearth.name = 'Hearth Patient Records',
      collection_hearth.status = 'live',
      collection_hearth.collection_type = 'relational-table',
      collection_hearth.phi_sensitivity = 'phi',
      collection_hearth.access_role = 'internal',
      collection_hearth.access_mode = 'writable',
      collection_hearth.data_purpose = ['audit-grade', 'reporting'];
MERGE (domain_hearth)-[:CONTAINS_COLLECTION]->(collection_hearth);

MERGE (collection_aquifer:Collection {id: 'collection-aquifer-outcomes'})
  SET collection_aquifer.name = 'Aquifer Outcomes Insights',
      collection_aquifer.status = 'live',
      collection_aquifer.collection_type = 'parquet-dataset',
      collection_aquifer.phi_sensitivity = 'non-phi',
      collection_aquifer.access_role = 'external-facing',
      collection_aquifer.access_mode = 'read-only',
      collection_aquifer.data_purpose = ['insight', 'reporting'];
MERGE (domain_aquifer)-[:CONTAINS_COLLECTION]->(collection_aquifer);

MERGE (collection_audit:Collection {id: 'collection-audit-care-plans'})
  SET collection_audit.name = 'Audit Care Plan Archive',
      collection_audit.status = 'live',
      collection_audit.collection_type = 'document-store',
      collection_audit.phi_sensitivity = 'phi',
      collection_audit.access_role = 'internal',
      collection_audit.access_mode = 'read-only',
      collection_audit.data_purpose = ['audit-grade'];
MERGE (domain_audit)-[:CONTAINS_COLLECTION]->(collection_audit);

MERGE (feeder_aquifer:Feeder {id: 'feeder-aquifer'})
  SET feeder_aquifer.name = 'Aquifer Feeder',
      feeder_aquifer.status = 'live',
      feeder_aquifer.feeder_kind = 'batch',
      feeder_aquifer.phi_sensitivity = 'phi',
      feeder_aquifer.access_role = 'internal',
      feeder_aquifer.access_mode = 'writable',
      feeder_aquifer.data_purpose = ['ingestion', 'transformation', 'insight'];
MERGE (feeder_aquifer)-[:CONSUMES_FROM]->(domain_hearth);
MERGE (feeder_aquifer)-[:FEEDS]->(domain_aquifer);

MERGE (surface_bluejay:AnalyticsSurface {id: 'surface-bluejay'})
  SET surface_bluejay.name = 'Bluejay Dashboards',
      surface_bluejay.status = 'partial',
      surface_bluejay.surface_type = 'dashboard',
      surface_bluejay.phi_sensitivity = 'non-phi',
      surface_bluejay.access_role = 'internal',
      surface_bluejay.access_mode = 'read-only',
      surface_bluejay.data_purpose = ['ops', 'monitoring', 'reporting'];
MERGE (svc_api)-[:MONITORED_BY]->(surface_bluejay);
MERGE (surface_bluejay)-[:OBSERVES]->(svc_api);
MERGE (surface_bluejay)-[:REPORTS_ON]->(domain_hearth);

MERGE (seed_rpm:Seed {id: 'seed-rpm-device-signals'})
  SET seed_rpm.name = 'RPM Device Signals Seed',
      seed_rpm.status = 'planned',
      seed_rpm.phi_sensitivity = 'mixed',
      seed_rpm.access_role = 'internal',
      seed_rpm.access_mode = 'read-only',
      seed_rpm.data_purpose = ['exploratory', 'insight', 'training'];
MERGE (seed_rpm)-[:DERIVED_FROM]->(domain_aquifer);
MERGE (cap_billing:ProductCapability {id: 'capability-billing-insights'})
  SET cap_billing.name = 'Billing Insights & Compliance',
      cap_billing.status = 'live',
      cap_billing.owner_team = 'Product';
MERGE (cap_rm:ProductCapability {id: 'capability-remote-monitoring'})
MERGE (cap_billing)-[:RELATES_TO]->(cap_rm);
MERGE (cap_rm)-[:RELATES_TO]->(cap_billing);

MERGE (ka:KnowledgeArticle {id: 'ka-rpm-billing-periods'})
  SET ka.name = 'RPM Billing Period Expectations',
      ka.description = 'Explains how billing periods are calculated for RPM features and what clinicians should see in the UI.',
      ka.status = 'live',
      ka.source_system = 'confluence',
      ka.release_note = '2025-02-17 RPM Enhancements';
MERGE (ka)-[:EXPLAINS]->(cap);

MERGE (code:CodeArtifact {id: 'code-rimidi-container-api'})
  SET code.name = 'Rimidi Container API Module',
      code.description = 'Primary Django module powering Rimidi APIs.',
      code.status = 'live',
      code.source_system = 'git',
      code.release_note = '2025-02-17 RPM Enhancements';
MERGE (svc_api)-[:USES_CODE]->(code);
MERGE (wf)-[:IMPLEMENTED_BY]->(code);

MERGE (evt:Event {id: 'event-rpm-config-2025-03-01'})
  SET evt.name = 'RPM Billing Config Deployment',
      evt.description = 'Enabled new billing period calculation for RPM hypertension workflows.',
      evt.status = 'completed',
      evt.valid_from = datetime('2025-03-01T02:30:00Z'),
      evt.source_system = 'change-management',
      evt.jira_id = 'RPM-2410';
MERGE (evt)-[:TRIGGERS]->(svc_billing);
MERGE (evt)-[:RESULTED_IN]->(domain_audit);
