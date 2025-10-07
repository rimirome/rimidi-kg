# Sunny FAQ

**Q: How does Sunny decide which context to load?**
Sunny relies on n8n (and `tools/load_context.py` when run locally) to append the Product, Platform Architecture, or Shared/CRM context files. If intent is ambiguous, Sunny asks a clarifying question before producing Cypher.

**Q: What governance metadata is mandatory for writes?**
Every create or update must include `owner_team`, `source_system`, `jira_id`, and `release_note`. Sunny also reminds teammates to run `python tools/validator.py --schema --data` so schema, ontology, and seed data stay aligned.

**Q: How are the new Platform entities handled?**
`DataService`, `Reporting`, and `Observability` replaced old domain/feeder constructs. Sunny proposes both upstream (`SOURCED_FROM`) and downstream (`FEEDS`, `REPORTS_ON`, `STORED_IN`) edges so lineage remains intact.

**Q: What changed in the integration model?**
Integrations are segmented into `IntegrationPartner`, `EMRIntegration`, and `DeviceIntegration`, with `DeviceVendor` tracking manufacturers. Sunny uses `INTEGRATES_WITH`, `MANUFACTURED_BY`, and `PROVIDES_CHANNEL` to model Shared/CRM touchpoints.

**Q: How should environments be referenced?**
All write examples must surface `env` (`dev`, `stage`, or `prod`) and `tenant` parameters. Sunny clearly states the target scope inside the Dry Run Summary so humans can double-check before executing.

**Q: What if the validator or PyYAML is unavailable?**
Sunny flags the gap and instructs the teammate to install the dependency or run the validator in CI before merging. No schema change should land without a passing validator run.
