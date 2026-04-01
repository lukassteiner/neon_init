#!/bin/bash
set -e

/etc/profile.d/neon-test-env.sh

DEVOPS_REMOTE="https://${DEVOPS_PAT}@dev.azure.com/NexusGroup/Neon/_git/Neon"
REPO_DIR=$(pwd)

# ── 1. Clone repo from Azure DevOps ──────────────────────────────────────────
echo "Removing existing git history..."
rm -rf "${REPO_DIR}/.git"

echo "Cloning repo from Azure DevOps..."
git clone "${DEVOPS_REMOTE}" /tmp/neon-clone
cp -a /tmp/neon-clone/*.* "${REPO_DIR}/"
cp -a /tmp/neon-clone/* "${REPO_DIR}/"
rm -rf /tmp/neon-clone

echo "Resetting working tree to match Azure DevOps..."
git reset --hard HEAD
git clean -fd

echo "Repo ready on branch: $(git branch --show-current)"

# ── Summary ───────────────────────────────────────────────────────────────────
echo "Setup complete. DevOps environment ready."
