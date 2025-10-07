// Product management insights aligned with the dual-plane schema.

// Capabilities delivering the hypertension management use case.
MATCH (cap:ProductCapability)-[:DELIVERS]->(:UseCase {id: 'usecase-hypertension-management'})
RETURN cap.id AS capability_id, cap.name AS capability_name
ORDER BY capability_name;

// Workflows missing an explicit implementation partner or data service.
MATCH (wf:EndUserWorkflow)
WHERE NOT (wf)-[:IMPLEMENTS]->(:IntegrationPartner)
  AND NOT (wf)-[:IMPLEMENTS]->(:EMRIntegration)
  AND NOT (wf)-[:IMPLEMENTS]->(:DeviceIntegration)
  AND NOT (wf)-[:IMPLEMENTS]->(:DataService)
RETURN wf.id AS workflow_id, wf.name AS workflow_name
ORDER BY workflow_name;

// UI components attached to the remote monitoring capability.
MATCH (:ProductCapability {id: 'capability-remote-monitoring'})-[:HAS_COMPONENT]->(ui:UIComponent)
RETURN ui.id AS component_id, ui.name AS component_name
ORDER BY component_name;

// Support workflows tied to the device API service via troubleshooting documentation.
MATCH (:Service {id: 'service-device-api'})-[:SUPPORTS_TROUBLESHOOTING]->(sw:SupportWorkflow)
RETURN sw.id AS workflow_id, sw.name AS workflow_name;

// Release records that trigger product workflows.
MATCH (rel:ReleaseVersion)-[:TRIGGERS]->(wf:EndUserWorkflow)
RETURN rel.id AS release_id,
       rel.release_reference AS release_reference,
       wf.id AS workflow_id
ORDER BY release_reference DESC;
