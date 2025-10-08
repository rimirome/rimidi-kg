# AI Assets

This directory contains the prompt contracts, context packs, and automation playbooks that govern the Rimidi KG agents.

## Structure
- `prompts/` - system prompts for Skye, Sunny, and Luna.
- `context/` - subgraph knowledge cards referenced by Sunny and Luna.
- `prompt_context.md` - overview of how the three agents coordinate.
- `context_loader_instructions.md` - n8n guidance for assembling prompts and propagating alias summaries.
- `examples.md` / `faq.md` - supporting guidance for automation behaviour.
- `tools/` - docs for auxiliary integrations (Slack, GitHub, KG connection).

## Key Assumptions
- All runtime orchestration happens in n8n; this repository stores text assets only.
- Skye must load `data/aliases.yaml` on every turn and log which entries were applied.
- Sunny receives normalized inputs plus context bundles and remains read-only.
- Luna consumes Sunny's output to provide reasoning, documentation linkage, and next steps without executing Cypher.
- Updates to prompts require schema alignment and validator coverage before deployment.
