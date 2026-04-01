#!/bin/bash
set -e

# Run this script to receive $DEVOPS_PAT
/etc/profile.d/export-pat.sh

DEVOPS_REMOTE="https://${DEVOPS_PAT}@dev.azure.com/NexusGroup/Neon/_git/Neon"
REPO_DIR=$(pwd)

# ── 0. Install Azure CLI ──────────────────────────────────────────────────────
echo "Installing Azure CLI..."
if ! command -v az &>/dev/null; then
  echo "  Trying pip install..."
  if command -v pip3 &>/dev/null; then
    pip3 install --ignore-installed azure-cli
  elif command -v pip &>/dev/null; then
    pip install --ignore-installed azure-cli
  else
    echo "ERROR: Neither apt nor pip available to install Azure CLI." >&2
    exit 1
  fi
  echo "  Azure CLI installed: $(az version --query '"azure-cli"' -o tsv)"
else
  echo "  Azure CLI already installed: $(az version --query '"azure-cli"' -o tsv)"
fi

# ── 1. Clone repo from Azure DevOps ──────────────────────────────────────────
echo "Removing existing git history..."
rm -rf "${REPO_DIR}/.git"
rm -rf "${REPO_DIR:?}"/*

echo "Cloning repo from Azure DevOps..."
git clone "${DEVOPS_REMOTE}" .

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
