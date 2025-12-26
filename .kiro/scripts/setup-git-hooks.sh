#!/bin/bash

# Setup Git Hooks for Project
# Copies husky configuration from ~/.kiro/templates/ and sets up hooks
# Usage: Run from project root
#   ~/.kiro/scripts/setup-git-hooks.sh

set -e

KIRO_HOME="$HOME/.kiro"
TEMPLATE_DIR="$KIRO_HOME/templates"

echo "🔧 Setting up Git hooks..."
echo ""

# Check if we're in a git repository
if [ ! -d ".git" ]; then
  echo "❌ Not a git repository"
  echo "   Run this script from your project root"
  exit 1
fi

# Check if templates exist
if [ ! -d "$TEMPLATE_DIR/husky" ]; then
  echo "❌ Templates not found at: $TEMPLATE_DIR"
  echo ""
  echo "Please install kiro-best-practices first:"
  echo "  curl -fsSL https://raw.githubusercontent.com/kumagaias/kiro-best-practices/main/install.sh | bash"
  exit 1
fi

# Install husky if not already installed
if [ ! -d "node_modules" ]; then
  echo "⚠️  node_modules not found. Installing husky..."
  npm install --save-dev husky
fi

# Initialize husky
if [ ! -d ".husky/_" ]; then
  echo "📦 Initializing husky..."
  npx husky install
fi

# Copy hook templates
echo "📁 Copying hook templates..."
cp -r "$TEMPLATE_DIR/husky/"* ".husky/"

# Set execute permissions
chmod +x .husky/pre-commit 2>/dev/null || true
chmod +x .husky/pre-push 2>/dev/null || true

echo ""
echo "✅ Git hooks setup complete!"
echo ""
echo "📋 Installed hooks:"
echo "  ✓ pre-commit  - Calls ~/.kiro/scripts/security-check.sh"
echo "  ✓ pre-push    - Calls ~/.kiro/scripts/security-check.sh"
echo ""
echo "💡 Tip: Hooks will use shared scripts from ~/.kiro/scripts/"
echo ""
