// Client Success focused queries.

// Expected behavior articles for a given capability.
:param capability_id => 'capability-billing-insights';
MATCH (ka:KnowledgeArticle)-[:EXPLAINS]->(:ProductCapability {id: $capability_id})
RETURN ka.id AS article_id, ka.name AS article_name, ka.url AS reference_url;

// Workflows documented by knowledge articles.
MATCH (ka:KnowledgeArticle)-[:DOCUMENTS]->(wf:Workflow)
RETURN ka.name AS article_name, wf.name AS workflow_name;
