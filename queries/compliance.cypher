// Compliance and traceability checks.

// Workflows touching PHI without an assigned owner team.
MATCH (c:ProductCapability)-[:ENABLES]->(w:Workflow)
WHERE c.status = 'live' AND (w.owner_team IS NULL OR w.owner_team = '')
RETURN c.name AS capability, w.name AS workflow;

// Integrations missing vendor metadata.
MATCH (i:Integration)
WHERE i.vendor IS NULL OR i.vendor = ''
RETURN i.id AS integration_id, i.name AS integration_name;

// Domains that handle PHI but are exposed outside the organization.
MATCH (d:Domain)
WHERE d.phi_sensitivity = 'phi' AND d.access_role = 'external-facing'
RETURN d.id AS domain_id, d.name AS domain_name;

// Seeds containing mixed PHI that lack explicit data purpose tags.
MATCH (s:Seed)
WHERE s.phi_sensitivity = 'mixed' AND (s.data_purpose IS NULL OR size(s.data_purpose) = 0)
RETURN s.id AS seed_id, s.name AS seed_name;

// Audit repository collections missing linkage to the billing toolkit.
MATCH (c:Collection {id: 'collection-audit-care-plans'})
WHERE NOT (:Service {id: 'service-billing-toolkit'})-[:BACKED_BY]->(:Domain)-[:CONTAINS_COLLECTION]->(c)
RETURN c.id AS collection_id, c.name AS collection_name;
