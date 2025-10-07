# n8n GitHub Repo Tool Configuration – rimidi-kg

**Purpose**
- This file provides configuration details for the n8n automation tool to clone and interact with the `rimidi-kg` GitHub repository.

**Configuration**

- **Repository URL:** `https://github.com/rimidi/rimidi-kg.git`
- **Default Branch:** `dev`
- **Authentication:** Use a GitHub personal access token (PAT) with `repo` scope.
- **Clone Directory:** `/data/repos/rimidi-kg` (or as specified by the n8n workflow)
- **n8n Node:** Use the official [n8n GitHub node](https://docs.n8n.io/integrations/builtin/app-nodes/n8n-nodes-base.github/) for all repo operations.

**Required n8n Environment Variables**
- `GITHUB_TOKEN`: The GitHub PAT for authentication.
- `GIT_AUTHOR_NAME`: Name for commit author (optional).
- `GIT_AUTHOR_EMAIL`: Email for commit author (optional).

**Example n8n Workflow Steps**
1. **Clone Repository:**  
   Use the `Execute Command` node or a custom script to run:  
   `git clone https://github.com/rimidi/rimidi-kg.git /data/repos/rimidi-kg`
2. **Checkout Branch:**  
   `git checkout dev`
3. **Pull Latest Changes:**  
   `git pull origin dev`
4. **Push Changes:**  
   Use the GitHub node or `git push` with authentication.

**Notes**
- Ensure the n8n instance has network access to GitHub and the correct permissions.
- All automation should target the `dev` branch unless otherwise specified.
