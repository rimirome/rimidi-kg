# Sunny Context Loader Instructions

Sunny uses a modular prompt so n8n can supply only the context that matches a teammate’s request.

## Required files
- Base system prompt: `ai/prompts/base_prompt.md`
- Product context: `ai/context/product.md`
- Platform Architecture context: `ai/context/platform_architecture.md`
- Shared / CRM context: `ai/context/shared_crm.md`

## Loader algorithm for n8n
1. Detect intent from the inbound message using classification or keyword matching.
   - Product signals: capability, workflow, UI, roadmap.
   - Platform signals: service, pipeline, reporting, observability, release.
   - Shared/CRM signals: client, deployment, integration partner, channel.
2. Build the prompt string by concatenating:
   1. contents of `ai/prompts/base_prompt.md`
   2. matching context file(s) based on detected intent (multiple allowed when ambiguous)
   3. the last three user/assistant turns of chat history (oldest to newest)
3. Provide the combined text to the LLM invocation node in n8n.

Example (TypeScript Function node):
```ts
const base = $json["files"]["base_prompt"]; // load via Binary node
const context = $json["files"]["platform_architecture"]; // chosen context
const history = inputs[0].map(turn => turn.text).join('\n');
return base + '\n\n' + context + '\n\n' + history;
```

## Reference loader script
`tools/load_context.py` can be executed as `python tools/load_context.py --subgraph platform --history history.txt` to reproduce the same concatenation locally. The script resolves paths relative to the repo root so it works inside CI or n8n containers.

## Validator reminder
Whenever Sunny proposes schema or seed updates, instruct the teammate to run `python tools/validator.py --schema --data` before merging. n8n should surface validator results in the automation flow.
