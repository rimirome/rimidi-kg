# Curated Cypher Queries

Reference queries aligned to the governed Rimidi KG schema.

## Contents
- `product.cypher` - capability and workflow mapping for product requirement analysis.
- `engineering.cypher` - service dependencies, infra ownership, and observability checks.
- `data.cypher` - governance and PHI coverage audits across domains and datasets.
- `client_success.cypher` - CRM, integration, and support lookups for customer teams.
- `compliance.cypher` - policy and audit helper queries.

## Key Assumptions
- Queries default to read-only patterns; destructive commands belong in controlled workflows.
- Environment (`env`) and tenant parameters should be provided when executing against shared clusters.
- Update these queries when schema or ontology changes adjust label/relationship names.
- Keep example IDs sanitized; replace with tenant-specific values only at runtime.
