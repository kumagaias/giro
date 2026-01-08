---
inclusion: always
---

# Common Project Standards (General)

General project standards applicable to various projects.

---

## Communication Standards

- **Global configuration (~/.kiro/)**: Always English
- **Project-specific files**: Use configured project language (see `language.md`)
  - README files (max 200 lines)
  - GitHub PRs/Issues
  - Commit messages
  - Code comments
  - Project documentation

**Note**: Agent chat language and project language are configured in `language.md` (set during installation)

## Default Workflow for All Changes

**IMPORTANT**: Unless explicitly told otherwise, ALWAYS follow this workflow:

1. Create GitHub issue first (with clear title and description in configured project language)
2. Create branch from issue (format: `feat/issue-{number}-{description}`, `fix/issue-{number}-{description}`, etc.)
3. Make changes and run tests (`make test`)
4. Commit with issue reference (format: `feat: Description (Refs #{number})` in project language)
5. Push to remote
6. Create PR with description in project language and link to issue (`Closes #{number}`)
7. Perform self-review of the PR (check diff, verify changes)
8. Request code review from GitHub Copilot (via MCP if available)
9. Check Copilot review status every 1 minute (max 5 minutes)
   - Exclude Copilot summary comments from review check
   - Only wait for actual review comments
10. Address Copilot review comments if any (fix issues, push updates)
11. Verify all CI/CD checks pass (tests, linting, security)
12. Notify when ready to merge (or auto-merge if configured)

**Do NOT ask for confirmation** - execute this flow automatically when user requests changes.

**Agent Hook**: Use "Full Workflow: Issue → Branch → PR → Review" hook to automate this entire process.

## Development Flow

### Basic Flow

All development work must start with a GitHub Issue.

```bash
# 1. Create GitHub Issue
gh issue create --title "Add user authentication" --body "Description..."
# Or use GitHub MCP
# Get issue number (e.g., #123)

# 2. Create specs document
# Create .kiro/specs/feature/issue-123-add-user-authentication.md
# Document requirements, design, and implementation plan

# 3. Create branch with issue number
git checkout -b feat/issue-123-add-user-authentication

# 4. Implement & test
make test

# 5. Commit with issue reference (English)
git add .
git commit -m "feat: Add user authentication (Refs #123)"

# 6. Push
git push origin feat/issue-123-add-user-authentication

# 7. Create PR with issue reference (English)
gh pr create --title "feat: Add user authentication" --body "Closes #123"

# 8. Review & merge
# 9. Close issue (auto-closed by PR merge)
```

**Key Points:**
- Always create Issue first
- Document in specs with `issue-{number}-{description}.md` format
- Include issue number in branch name
- Reference issue in commits (`Refs #123`)
- Link issue in PR (`Closes #123`)

### Commit Message Format

```
<type>: <subject> (Refs #<issue-number>)

<body>

<footer>
```

**Types**: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

**Examples:**
- `feat: Add user authentication (Refs #123)`
- `fix: Resolve memory leak (Fixes #456)`
- `docs: Update API documentation (Refs #789)`

### Branch Naming

```
<type>/issue-<number>-<description>
```

Examples:
- `feat/issue-123-add-user-authentication`
- `fix/issue-456-resolve-memory-leak`
- `docs/issue-789-update-readme`

## PR Review Process

### Automated Review Flow

Before merging, the following steps are executed automatically:

1. **Self-Review**
   - Review PR diff and verify all changes are intentional
   - Check for unintended changes or debug code
   - Verify commit messages follow conventions

2. **Copilot Review**
   - Request review from GitHub Copilot via MCP
   - Check review status every 1 minute (max 5 minutes)
   - Exclude Copilot summary comments (only check actual review comments)
   - Address any comments or suggestions
   - Push fixes if needed

3. **CI/CD Verification**
   - Verify all automated checks pass:
     - Unit tests
     - Integration tests
     - Linting
     - Security scans
     - Build verification
   - Wait for all checks to complete before proceeding

4. **Ready to Merge**
   - All reviews approved
   - All CI/CD checks passing
   - No merge conflicts
   - Notify or auto-merge (based on configuration)

### Manual Review (Optional)

For critical changes, request human review:
- Add reviewers via GitHub UI or MCP
- Wait for approval before merging
- Address feedback and update PR

## Bug Fix Workflow

### Quick Start (Using Scripts)

```bash
# 1. Create Issue and bugfix documentation
./.kiro/hooks/common/scripts/create-bugfix-issue.sh

# 2. Create fix branch (use suggested name from script output)
git checkout -b fix/issue-{number}-{description}

# 3. Fix & test
make test

# 4. Commit with issue reference
git commit -m "fix: [description] (Fixes #{number})"

# 5. Create PR (via GitHub CLI or MCP)
gh pr create --title "fix: [description]" --body "Fixes #{number}"

# 6. After merge, close issue and update documentation
./.kiro/hooks/common/scripts/close-bugfix-issue.sh {number}
```

### Manual Workflow

1. **Create GitHub Issue** (via GitHub MCP or CLI) - Get Issue number
2. **Document bug**: Create detailed report in `.kiro/specs/bugfix/issue-{number}-{description}.md`
3. **Create fix branch**: `fix/issue-{number}-{description}`
4. **Fix & test**: `make test`
5. **Commit**: Include `Fixes #{number}` in message
6. **Create PR** (via GitHub MCP or CLI) with `Fixes #{number}` in body
7. **Code review**
8. **Merge** (after approval)
9. **Issue auto-closed** by PR merge

**❌ Prohibited:**
- Skipping Issue creation
- Fixing directly on main branch
- Merging without approval
- Working without issue number

**File Naming**: Always use `issue-{number}-{description}.md` format to prevent number conflicts

**Helper Scripts**:
- `.kiro/hooks/common/scripts/create-bugfix-issue.sh` - Create Issue + bugfix doc
- `.kiro/hooks/common/scripts/close-bugfix-issue.sh` - Close Issue + update doc

### Bug Report Format

Create detailed bug reports in `.kiro/specs/bugfix/` directory:

```markdown
# Bug Report #issue-{number}: {Title}

**Date**: YYYY-MM-DD
**Status**: Open/In Progress/Resolved
**Severity**: Low/Medium/High/Critical
**Component**: {Component name}

## Summary
Brief description of the bug

## Error Details
Error messages, stack traces, logs

## Reproduction Steps
1. Step 1
2. Step 2
3. ...

## Expected Behavior
What should happen

## Actual Behavior
What actually happens

## Possible Causes
List of potential root causes

## Investigation Needed
- [ ] Check logs
- [ ] Review code
- [ ] Test edge cases

## Impact
User experience and scope

## Next Steps
Action items
```

## Testing Requirements

**For detailed testing standards, see**: #[[file:testing-standards.md]]

```bash
make test              # All tests
make test-unit         # Unit tests only
make test-security     # Security checks
```

**Coverage Target**: 60% or higher

## Documentation Requirements

### Required Files
- `README.md` - Project overview (max 200 lines)
- `structure.md` - Project-specific structure
- `tech.md` - Project-specific tech details
- `deployment-workflow.md` - Project standards (this file)

### File Size Guidelines
- **README.md**: Max 200 lines
- **Source files**: Max 500 lines per file
- **Documentation**: Keep concise and focused

### Specs File Naming

All specs files should include issue/task number as prefix to prevent conflicts:

**Format**: `issue-{number}-{description}.md` or `task-{number}-{description}.md`

**Examples**:
- `.kiro/specs/bugfix/issue-123-fix-login-error.md`
- `.kiro/specs/feature/issue-456-add-user-profile.md`
- `.kiro/specs/task/task-789-refactor-api-client.md`

**Benefits**:
- Prevents filename conflicts
- Easy to link with GitHub Issues
- Clear traceability
- Consistent organization

### Update Timing
- When features change
- When specs change
- When structure changes

## Deployment Standards

**For detailed deployment procedures, see**: #[[file:deployment-workflow.md]]

### Pre-deployment Checklist
- [ ] All tests pass
- [ ] Security checks pass
- [ ] Documentation updated
- [ ] Code reviewed
- [ ] Changes tested locally

### Basic Deployment Flow
1. Pull latest changes
2. Run all tests
3. Deploy to staging (if available)
4. Verify in staging
5. Deploy to production
6. Monitor logs
7. Verify in production

## Postmortem Guidelines

### When to Create
- Security incidents
- Production failures
- Critical bugs
- Process issues

### Postmortem Structure
1. **Overview**: What happened (1-2 sentences)
2. **Timeline**: Chronological events
3. **Root Cause**: Why it occurred
4. **Impact**: What was affected
5. **Resolution**: How it was fixed
6. **Prevention**: Future countermeasures

### Best Practices
- Don't blame individuals
- Be concise and specific
- Focus on system improvements
- Create promptly after resolution
- Share learnings with team

## Tool Version Management

### .tool-versions
Define required tools and versions:
- Runtime (Node.js, Python, etc.)
- Infrastructure (Terraform, etc.)
- CLI tools (AWS CLI, etc.)
- Security tools (Gitleaks, etc.)

### Installation
```bash
# Check tools
make check-tools

# Install tools (if using asdf)
asdf install
```

## Makefile Standards

### Required Commands

All projects must implement these commands:

```bash
make help              # Display available commands
make install           # Install dependencies
make test              # Run all tests (unit + security)
make test-unit         # Run unit tests only
make test-security     # Run security checks
make clean             # Clean build artifacts
make check-tools       # Check required tools
```

### Optional Commands

Add these as needed:

```bash
make test-e2e          # Run E2E tests
make test-lint         # Run linting
make dev               # Start development server
make build             # Build for production
make deploy            # Deploy to production
```

### Implementation

A basic `Makefile` is provided. Customize it for your project:

```bash
# Edit Makefile
vim Makefile

# See example
cat Makefile.example
```

## Agent Hooks

### Common Hooks
- `run-tests.json` - Run tests
- `security-check.json` - Security check
- `lint-check.json` - Linting check

### Execution
- Via Command Palette: "Agent Hooks"
- Manual: `make <command>`

---

**For project-specific details, refer to:**
- `structure.md` - Project structure
- `tech.md` - Technical details
- `deployment-workflow.md` - Project standards (this file)

**For specialized topics:**
- #[[file:security-policies.md]] - Security guidelines
- #[[file:testing-standards.md]] - Testing approach and patterns
- #[[file:languages/typescript-code-conventions.md]] - TypeScript coding standards
