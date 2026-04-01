#!/bin/bash
set -e

# Run this script to receive $DEVOPS_PAT
export_pat.sh

DEVOPS_REMOTE="https://${DEVOPS_PAT}@dev.azure.com/NexusGroup/Ongedo/_git/Ongedo"
REPO_DIR=$(pwd)

# ── 1. Clone repo from Azure DevOps ──────────────────────────────────────────
echo "Removing existing git history..."
rm -rf "${REPO_DIR}/.git"

echo "Cloning repo from Azure DevOps..."
git clone "${DEVOPS_REMOTE}" /tmp/ongedo-clone
cp -a /tmp/ongedo-clone/. "${REPO_DIR}/"
rm -rf /tmp/ongedo-clone

echo "Resetting working tree to match Azure DevOps..."
git reset --hard HEAD
git clean -fd


# ── 2. Remove any GitHub remotes ─────────────────────────────────────────────
echo "Removing any GitHub remotes..."
for remote in $(git remote); do
  url=$(git remote get-url "$remote")
  if echo "$url" | grep -q "github.com"; then
    git remote remove "$remote"
    echo "  Removed remote '$remote' ($url)"
  fi
done

echo "Repo ready on branch: $(git branch --show-current)"

# ── Summary ───────────────────────────────────────────────────────────────────
echo "Setup complete. DevOps environment ready."
