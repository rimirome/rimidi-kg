# Rimidi Knowledge Graph Agent Context

The Rimidi KG automations now rely on three modular agents orchestrated in n8n:
- **Skye** (`ai/prompts/base_prompt_lexi.md`) normalizes teammate language using `data/aliases.yaml` so downstream prompts receive canonical labels and relationships.
- **Sunny** (`ai/prompts/base_prompt_sunny.md`) generates safe, parameterized Cypher backed by the focused context packs in `ai/context/*.md`.
- **Luna** (`ai/prompts/base_prompt_luna.md`) interprets query outputs, connects them to documentation, and recommends next steps without executing Cypher.

Supporting assets include:
- **Context packs** (`ai/context/*.md`) that scope Sunny/Luna to Product, Platform Architecture, or Shared/CRM subgraphs.
- **Loader guidance** (`ai/context_loader_instructions.md` and `tools/load_context.py`) showing how n8n assembles prompts and propagates Skye’s alias results.

Refer to these files before updating prompt content or wiring automations. The ontology, schema, and validator remain the single source of truth:
- `docs/ontology.md`
- `schema/node_types.yaml`
- `schema/relationships.yaml`
- `schema/attributes.yaml`
- Validator command: `python tools/validator.py --schema --data`

Sunny responses stay consistent: intent summary, validation checklist, Cypher block, and optional hand-off notes for Luna. Luna references documentation sources, while Skye logs which aliases were applied so analysts can trace transformations.
