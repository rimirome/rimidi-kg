// Data ecosystem and governance queries.

// Domains with PHI access that are still proposed or partial.
MATCH (d:Domain)
WHERE d.phi_sensitivity = 'phi' AND d.status IN ['proposed', 'partial']
RETURN d.id AS domain_id, d.name AS domain_name, d.status;

// Feeders without both source and target mappings.
MATCH (f:Feeder)
WHERE NOT (f)-[:CONSUMES_FROM]->(:Domain)
   OR NOT (f)-[:FEEDS]->(:Domain)
RETURN f.id AS feeder_id, f.name AS feeder_name;

// Collections lacking domain ownership tags.
MATCH (c:Collection)
WHERE NOT ( (:Domain)-[:CONTAINS_COLLECTION]->(c) )
RETURN c.id AS collection_id, c.name AS collection_name;

// Analytics surfaces reporting on PHI domains.
MATCH (a:AnalyticsSurface)-[:REPORTS_ON]->(d:Domain)
WHERE d.phi_sensitivity = 'phi'
RETURN a.id AS surface_id, a.name AS surface_name, d.id AS domain_id;

// Seeds derived from Aquifer but not yet writing results anywhere.
MATCH (s:Seed)-[:DERIVED_FROM]->(:Domain {id: 'domain-aquifer'})
WHERE NOT (s)-[:WRITES_TO]->(:Domain)
RETURN s.id AS seed_id, s.name AS seed_name;

// Audit repository collections and the services backed by them.
MATCH (:Domain {id: 'domain-audit-repository'})-[:CONTAINS_COLLECTION]->(c:Collection)
OPTIONAL MATCH (svc:Service)-[:BACKED_BY]->(:Domain)-[:CONTAINS_COLLECTION]->(c)
RETURN c.id AS collection_id, collect(DISTINCT svc.id) AS consuming_services;
