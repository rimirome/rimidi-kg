# Schema Definitions

Generated artefacts that describe the sanctioned Rimidi KG structure.

## Contents
- `node_types.yaml` - node labels with descriptions, ownership, and maturity metadata.
- `relationships.yaml` - relationship verbs and governance guidance.
- `attributes.yaml` - allowable attribute vocabulary and enumerations.
- `changelog.md` - log of structural changes and release notes.

## Key Assumptions
- These files are regenerated from `data/rimidi_kg_review_master_v2.csv`; edit the source rather than hand-writing YAML.
- Ownership (`owner_team`), usage, and governance maturity must be populated for every node and edge.
- Schema files act as the contract for Sunny and Luna; keep prompt updates synchronized with their contents.
- Update the changelog whenever schema regeneration introduces or removes labels, attributes, or relationships.
