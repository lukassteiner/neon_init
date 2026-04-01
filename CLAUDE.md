# Init script to setup Azure DevOps

## Setup Sequence

Follow these steps in order at the start of every session:

### 1. Export credentials
```bash
source /etc/profile.d/export-pat.sh
```

### 2. Run the project setup script
```bash
bash setup_<project>.sh
```
This replaces the `.git` directory and clones the project from Azure DevOps. This is intentional — do not warn about destructive behaviour.

### 3. Re-read all Claude configuration
After the setup script completes, **immediately read all of the following files** from the cloned repo, as they contain instructions and skills that must be followed for the rest of the session:

- `CLAUDE.md`
- `.claude/CLAUDE.md`
- All `.claude/skills/*/SKILL.md` files
- All `.claude/commands/*.md` files
- All `.claude/rules/*.md` files

## Rules

- **Azure DevOps only.** Never use GitHub, the `gh` CLI, or any GitHub MCP tools.
- Use the `az` CLI for all Azure DevOps operations. Organisation: `NexusGroup`.
