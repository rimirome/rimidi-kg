# Agent Context Loader Instructions

<!-- Lexi, Sunny, and Luna run inside n8n workflows: Lexi pre-processes input, Sunny generates Cypher, Luna reasons on results. Keep orchestration code in n8n, not this repo. -->

The Rimidi KG agents share modular prompts so n8n can supply only the context that matches a teammate’s request while keeping each role isolated.

## Required Files
- Lexi base prompt: `ai/prompts/base_prompt_lexi.md`
- Sunny base prompt: `ai/prompts/base_prompt_sunny.md`
- Luna base prompt: `ai/prompts/base_prompt_luna.md`
- Product context: `ai/context/product.md`
- Platform Architecture context: `ai/context/platform_architecture.md`
- Shared / CRM context: `ai/context/shared_crm.md`
- Alias source for Lexi: `data/aliases.yaml`

## Lexi Pre-Processing (n8n)
1. Load `data/aliases.yaml` into memory before routing the teammate message.
2. Run Lexi with the base prompt and the raw teammate text; capture normalized output plus match metadata.
3. Pass the normalized message and alias summary forward to Sunny and log any unresolved ambiguities.

## Sunny Prompt Assembly (n8n)
1. Detect intent from Lexi’s normalized message using classification or keyword matching.
   - Product signals: capability, workflow, UI, roadmap.
   - Platform signals: service, pipeline, reporting, observability, release.
   - Shared/CRM signals: client, deployment, integration partner, channel.
2. Build the prompt string by concatenating:
   1. contents of `ai/prompts/base_prompt_sunny.md`
   2. matching context file(s) based on detected intent (multiple allowed when ambiguous)
   3. the last three user/assistant turns of chat history (oldest to newest)
   4. Lexi’s alias resolution summary when additional clarification is helpful
3. Provide the combined text to the LLM invocation node in n8n.

Example (TypeScript Function node):
```ts
const base = $json["files"]["sunny_base"]; // load via Binary node
const context = $json["files"]["platform_architecture"]; // chosen context
const history = inputs[0].map(turn => turn.text).join('\n');
const aliasSummary = $json["lexi"]?.matchSummary ?? "";
return [base, context, history, aliasSummary].filter(Boolean).join('\n\n');
```

## Luna Follow-Up (n8n)
1. Supply Luna with `ai/prompts/base_prompt_luna.md`, relevant context packs, Sunny’s Cypher output (or results), and Lexi’s alias notes.
2. Ask Luna to synthesize reasoning, documentation links, and recommended next steps without executing Cypher.

## Reference Loader Script
`tools/load_context.py` can be executed as `python tools/load_context.py --subgraph platform --history history.txt` to reproduce the Sunny concatenation locally. The script resolves paths relative to the repo root so it works inside CI or n8n containers.

## Validator Reminder
Whenever Sunny proposes schema or seed updates, instruct the teammate to run `python tools/validator.py --schema --data` before merging. n8n should surface validator results in the automation flow.
