# Slack Notifications Tool – Rimidi Ops Updates

**Description**
- Deliver short status updates to the designated Slack channel or user whenever a KG change, pull request, or incident needs to be broadcast.

**Tool Prompt / Operating Contract**
1. Inputs include `destination` (channel ID or user ID), `headline`, `body`, and optional `links` (array of `{title, url}`).
2. Craft approachable language: lead with the outcome, then note next steps or approvals needed. Keep messages under 1000 characters.
3. If a pull request URL is available, include it as the first link; append validator results or Cypher dry-run IDs afterwards.
4. Use lightweight formatting (`*bold*`, bullet lists) but avoid code blocks unless sharing a short identifier. Do not paste full Cypher or diff output.
5. Confirm delivery by returning `status=sent` and the timestamp Slack reports; surface any delivery errors so the workflow can retry or escalate.
