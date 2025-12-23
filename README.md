# Kiro Configuration Template

Shared Kiro configuration for consistent development practices across projects.

## Installation Methods

### Method 1: Submodule (Recommended)

Use Git submodule for version-controlled template management:

```bash
# Must be in a git repository
git init  # if not already initialized

# Install as submodule
curl -fsSL https://raw.githubusercontent.com/kumagaias/giro/main/install-submodule.sh | bash

# Commit
git add .gitmodules .kiro-template .kiro .husky .github Makefile .tool-versions
git commit -m "chore: Add giro configuration as submodule"
```

**Benefits:**
- Version tracking of template updates
- Easy updates with `git submodule update --remote`
- Can contribute improvements back to giro
- Team uses same template version

### Method 2: Standalone Copy

Copy files without submodule (simpler but no version tracking):

```bash
curl -fsSL https://raw.githubusercontent.com/kumagaias/giro/main/install.sh | bash
```

### 1. Install required tools

```bash
# GitHub CLI (for GitHub MCP)
brew install gh
gh auth login

# Gitleaks (for security checks)
brew install gitleaks
```

### 2. Run installer

```bash
# One-line installation
curl -fsSL https://raw.githubusercontent.com/kumagaias/giro/main/install.sh | bash
```

The installer will ask you to:
- Choose language (English or Japanese)
- Optionally enable additional MCP servers (AWS, Terraform, Playwright)

### 3. Customize (optional)

Edit these files for project-specific settings:
- `.kiro/steering/project.md` - Project standards
- `.kiro/steering/tech.md` - Technical details
- `.kiro/steering/structure.md` - Project structure
- `.kiro/settings/mcp.local.json` - Additional MCP servers
- `Makefile` - Add your project-specific commands

## What's Included

- **Hooks** - Agent hooks for testing and security (in `.kiro/hooks/`)
- **Steering** - Development guidelines and best practices
- **Settings** - MCP server configurations (fetch, github)
- **Git Hooks** - Pre-commit security checks (`.husky/`)
- **GitHub** - Workflows, PR/Issue templates, Copilot review automation (`.github/`)
- **Makefile** - Common development tasks (test, install, clean)
- **Language** - Configurable language settings (English/Japanese)

## Structure (Submodule Version)

```
your-project/
├── .kiro-template/              # Git submodule (giro repository)
│   ├── .git/
│   ├── .kiro/
│   ├── install-submodule.sh
│   └── README.md
├── .kiro/                       # Your project configuration
│   ├── hooks/                  → symlink to .kiro-template/.kiro/hooks/
│   ├── steering/
│   │   ├── common/             → symlink to .kiro-template/.kiro/steering/common/
│   │   ├── steering-examples/  → symlink to .kiro-template/.kiro/steering/steering-examples/
│   │   ├── language.md         # Project-specific (gitignored)
│   │   ├── structure.md        # Project-specific (gitignored)
│   │   ├── project.md          # Project-specific (gitignored)
│   │   └── tech.md             # Project-specific (gitignored)
│   └── settings/
│       ├── mcp.json            → symlink to .kiro-template/.kiro/settings/mcp.json
│       └── mcp.local.json      # Project-specific (gitignored)
├── .husky/                      → symlink to .kiro-template/.kiro/husky/
├── .github/                     → symlink to .kiro-template/.kiro/github/
├── Makefile                     # Project-specific (gitignored)
└── .tool-versions               # Project-specific (gitignored)
```

**Note:** Symlinks point to submodule files, so updates to the submodule automatically reflect in your project.

## MCP Servers

**Default (always enabled):**
- `fetch` - HTTP requests
- `github` - GitHub operations

**Optional (enable in `mcp.local.json`):**
- `aws-docs` - AWS documentation
- `terraform` - Terraform operations
- `playwright` - Browser automation

See `.kiro/settings/README.md` for details.

## Usage

### Agent Hooks

Open Command Palette (`Cmd/Ctrl + Shift + P`) → "Agent Hooks"

- **Run Unit Tests** - Execute tests
- **Security Check** - Check for secrets

### Verify Setup

```bash
git add .
git commit -m "test: Verify setup" --allow-empty
# Should run security checks automatically
```

## Contributing Back to giro

### Submodule Version (Easy)

```bash
# Make improvements in .kiro-template
cd .kiro-template
git checkout -b feat/improve-hooks

# Edit files
vim .kiro/hooks/...

# Commit and push
git add .
git commit -m "feat: Improve hooks"
git push origin feat/improve-hooks

# Create PR on GitHub
gh pr create --title "feat: Improve hooks"

# Back to your project
cd ..
git add .kiro-template
git commit -m "chore: Update giro with improvements"
```

### Standalone Version

Use the sync script:

```bash
# Set giro repository path (optional)
export GIRO_PATH=~/projects/giro

# Sync improvements
make sync-to-giro
```

## Updating

### Submodule Version

Update to the latest giro template:

```bash
# Update submodule to latest
git submodule update --remote .kiro-template

# Review changes
git diff .kiro-template

# Commit the update
git add .kiro-template
git commit -m "chore: Update giro template"
git push
```

**Your customizations are preserved:**
- `.kiro/steering/language.md`
- `.kiro/steering/structure.md`
- `.kiro/steering/project.md`
- `.kiro/steering/tech.md`
- `.kiro/settings/mcp.local.json`

### Standalone Version

Re-run the installer (choose "Update only" mode):

```bash
curl -fsSL https://raw.githubusercontent.com/kumagaias/giro/main/install.sh | bash
# Choose "1) Update only" when prompted
```

## Uninstalling

### Submodule Version

```bash
# Remove submodule
git submodule deinit -f .kiro-template
git rm -f .kiro-template
rm -rf .git/modules/.kiro-template

# Remove symlinks and directories
rm -rf .kiro .husky .github

# Optionally remove
rm Makefile .tool-versions

# Commit
git add .
git commit -m "chore: Remove giro configuration"
```

### Standalone Version

```bash
curl -fsSL https://raw.githubusercontent.com/kumagaias/giro/main/uninstall.sh | bash
```

This will remove:
- `.kiro` directory
- `.husky` directory (if installed by this tool)
- `.github` directory (if installed by this tool)
- Optionally: `Makefile` and `.tool-versions`

## Structure

### Submodule Version

```
.kiro-template/     # Git submodule (giro repository)
.kiro/              # Project configuration (symlinks + custom files)
.husky/             # Symlink to .kiro-template/.kiro/husky
.github/            # Symlink to .kiro-template/.kiro/github
```

### Standalone Version

```
.kiro/              # Copied files
.husky/             # Copied files
.github/            # Copied files
```

## Contributing

### Submodule Version (Recommended)

If you've made improvements to the template:

1. Work directly in the submodule:
   ```bash
   cd .kiro-template
   git checkout -b feat/amazing-feature
   ```

2. Make changes:
   ```bash
   vim .kiro/hooks/...
   vim .kiro/steering/common/...
   ```

3. Commit and push:
   ```bash
   git add .
   git commit -m 'feat: Add amazing feature'
   git push origin feat/amazing-feature
   ```

4. Create PR on GitHub:
   ```bash
   gh pr create --title "feat: Add amazing feature"
   ```

5. Update your project to use the changes:
   ```bash
   cd ..
   git add .kiro-template
   git commit -m "chore: Update giro with improvements"
   ```

### Standalone Version

Use the sync script to contribute improvements:

```bash
# Set giro repository path (optional, defaults to ~/projects/giro)
export GIRO_PATH=/path/to/giro

# Sync improvements
make sync-to-giro

# Or run script directly
./.kiro/scripts/sync-to-giro.sh
```

**What gets synced:**
- `.kiro/hooks/` - Agent hooks
- `.kiro/steering/common/` - Common guidelines
- `.kiro/settings/` - MCP templates
- `.kiro/husky/` - Git hooks
- `.kiro/github/` - GitHub configuration

**What doesn't get synced (project-specific):**
- `.kiro/steering/language.md`
- `.kiro/steering/structure.md`
- `.kiro/steering/project.md`
- `.kiro/steering/tech.md`
- `.kiro/settings/mcp.local.json`

### Contributing to giro Repository

For direct contributions to the template:

1. Fork this repository
2. Create feature branch (`git checkout -b feat/amazing-feature`)
3. Commit changes (`git commit -m 'feat: Add amazing feature'`)
4. Push to branch (`git push origin feat/amazing-feature`)
5. Open Pull Request

## Comparison: Submodule vs Standalone

| Feature | Submodule | Standalone |
|---------|-----------|------------|
| Version tracking | ✅ Yes | ❌ No |
| Easy updates | ✅ `git submodule update` | ⚠️ Re-run installer |
| Contribute back | ✅ Direct PR | ⚠️ Via sync script |
| Simplicity | ⚠️ Requires Git knowledge | ✅ Simple copy |
| Team sync | ✅ Same version | ⚠️ Manual sync |
| Git required | ✅ Yes | ❌ No |

**Recommendation:** Use submodule for team projects, standalone for quick prototypes.

## License

MIT
