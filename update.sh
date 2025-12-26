#!/bin/bash

# Kiro Best Practices Updater
# Updates shared configuration in ~/.kiro/
# Usage: 
#   curl -fsSL https://raw.githubusercontent.com/kumagaias/kiro-best-practices/main/update.sh | bash

set -e

KIRO_HOME="$HOME/.kiro"
REPO_DIR="$KIRO_HOME/kiro-best-practices"

echo "🔄 Kiro Best Practices Updater"
echo "=============================="
echo ""

if [ ! -d "$REPO_DIR" ]; then
  echo "❌ Repository not found at: $REPO_DIR"
  echo ""
  echo "Please install first:"
  echo "  curl -fsSL https://raw.githubusercontent.com/kumagaias/kiro-best-practices/main/install.sh | bash"
  exit 1
fi

if [ ! -d "$REPO_DIR/.git" ]; then
  echo "❌ $REPO_DIR is not a git repository"
  exit 1
fi

echo "📦 Updating repository..."
cd "$REPO_DIR"
git fetch origin
git reset --hard origin/main
echo "✅ Repository updated"

echo ""
echo "✅ Update complete!"
echo ""
echo "💡 All files are automatically updated via symlinks"
echo ""
echo "📋 Recent changes:"
git log --oneline -5
echo ""
