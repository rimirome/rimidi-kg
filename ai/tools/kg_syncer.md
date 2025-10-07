# GitHub PR Tool – KgSyncer

**Description**
- Own the pull request workflow for `rimidi-kg` changes that have already been pushed. Triggered by KgSyncer after node-type audits are reconciled and branch updates are ready for review.

**Tool Prompt / Operating Contract**
1. Expect the payload to include `branch`, a short change summary, validation notes (tests or validator commands plus results), and optional reviewer handles or labels.
2. Confirm the feature branch exists on the `rimidi-kg` remote and target `dev` as the base branch.
3. Open a pull request titled `KgSyncer: <short change summary>`.
4. Populate the body with the sections `Summary`, `Testing / Validation`, and `Review Notes`. Link to any validator output, dry runs, or Slack follow-ups that KgSyncer referenced in the audit.
5. Request reviewers `@ctarto3` and `@rimirome` along with any additional handles supplied by the agent. Apply only the labels provided in the payload.
6. Return the pull request URL, reviewer/label status, and any API failures so teammates can rerun or follow up manually if needed.
