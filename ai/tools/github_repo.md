# GitHub Repo Tool – rimidi-kg

**Description**
- Manage the `rimidi-kg` repository lifecycle once a change is approved. Create branches, commit updated files, push to GitHub, and open a pull request targeting the `dev` branch.

**Tool Prompt / Operating Contract**
1. Expect the agent to provide a short change summary, validation notes, and the reviewer handle (for example `reviewer_handle`).
2. Create or reuse a feature branch named `sunny/<slug-from-summary>` unless a branch name is explicitly supplied.
3. Stage the specified files, run formatting or validator commands that the agent provides, and commit with a concise message (prefix with `Sunny:` when your own message is chosen).
4. Push the branch to the `rimidi-kg` GitHub remote.
5. Open a pull request into `dev` with:
   - Title: `Sunny: <short change summary>`.
   - Body sections: `Summary`, `Testing / Validation`, and `Review Notes` (include links to validator output, dry-run details, and any follow-up steps).
   - Assign the reviewer listed in `reviewer_handle`; if multiple reviewers are provided, request them all.
   - Apply labels passed in the payload (for example `ontology`, `automation`); do not invent new labels.
6. Post the pull request URL back to the agent and note any failures so the workflow can re-run or request clarification.
