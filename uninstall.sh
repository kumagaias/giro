#!/bin/bash

# Kiro Configuration Uninstaller
# Usage: 
#   curl -fsSL https://raw.githubusercontent.com/kumagaias/giro/main/uninstall.sh | bash

set -e

echo "🗑️  Uninstalling Kiro configuration..."
echo ""

# Remove .kiro directory
if [ -d ".kiro" ]; then
  echo "Removing .kiro directory..."
  rm -rf ".kiro"
  echo "✅ .kiro directory removed"
else
  echo "ℹ️  .kiro directory not found"
fi

# Remove symlinks
if [ -L ".husky" ]; then
  echo "Removing .husky symlink..."
  rm ".husky"
  echo "✅ .husky symlink removed"
elif [ -d ".husky" ]; then
  echo "⚠️  .husky is a directory (not a symlink). Skipping."
else
  echo "ℹ️  .husky not found"
fi

if [ -L ".github" ]; then
  echo "Removing .github symlink..."
  rm ".github"
  echo "✅ .github symlink removed"
elif [ -d ".github" ]; then
  echo "⚠️  .github is a directory (not a symlink). Skipping."
else
  echo "ℹ️  .github not found"
fi

# Optional: Remove Makefile and .tool-versions
echo ""
read -p "Remove Makefile? (y/N): " -n 1 -r REMOVE_MAKEFILE < /dev/tty
echo ""
if [[ $REMOVE_MAKEFILE =~ ^[Yy]$ ]]; then
  if [ -f "Makefile" ]; then
    rm "Makefile"
    echo "✅ Makefile removed"
  fi
fi

read -p "Remove .tool-versions? (y/N): " -n 1 -r REMOVE_TOOL_VERSIONS < /dev/tty
echo ""
if [[ $REMOVE_TOOL_VERSIONS =~ ^[Yy]$ ]]; then
  if [ -f ".tool-versions" ]; then
    rm ".tool-versions"
    echo "✅ .tool-versions removed"
  fi
fi

echo ""
echo "✨ Uninstallation complete!"
echo ""
