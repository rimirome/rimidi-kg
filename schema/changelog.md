# Schema Changelog

## 0.6.0 - UI & CRM Alignment
- Added node types for UI components, support workflows, report templates, tooling services, device vendors, communication channels, and CRM entities (Client, Implementation, Contract, AccountContact).
- Extended relationship vocabulary with HAS_COMPONENT, PROVIDES_CHANNEL, MANUFACTURED_BY, USES_TEMPLATE, SUPPORTS_TROUBLESHOOTING, and ADMINISTERED_BY.
- Introduced optional `ui_area` attribute for product-facing artifacts and refreshed ontology documentation to reinforce the Product / TechOps / Shared split.

## 0.5.0 - Governance & Ownership
- Added governance attributes (valid_from/valid_to/source) across core node types.
- Introduced Policy, Team, and Actor node types plus ownership/policy relationships.
- Documented ontology in `docs/ontology.md` and wired validator to ensure it exists.

## 0.4.0 - Device & Interop Links
- Added `INTEGRATES_WITH` relationship type to describe service connections to external device and partner systems.
- Prepared schema for expanded device ingestion, EHR interoperability, and integration partner modeling.

## 0.3.0 - Product Insights from Release Notes
- Added product-focused capabilities, use cases, and services reflecting release note enhancements.
- Extended relationships to capture UI collaboration, analytics usability, and audit-ready domains.

## 0.2.0 - Service and Data Ecosystem Modeling
- Introduced node types for services, infrastructure primitives, data domains, feeders, collections, seeds, analytics surfaces, and use cases.
- Added governance attributes for PHI sensitivity, access roles, access modes, and data purpose tags.
- Expanded relationship taxonomy to cover service dependencies, infra hosting, domain feeders, observability, and data lineage.

## 0.1.0 - Initial draft
- Added baseline node types for capabilities, workflows, and integrations.
- Documented reusable attributes and relationship scaffolding.
