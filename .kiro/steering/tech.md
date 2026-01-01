---
inclusion: always
---

# Common Technical Practices (General)

General best practices applicable to various programming languages and projects.

**Language-specific guides**: Use `#tech-typescript`, `#tech-python`, `#tech-go` in chat to include language-specific practices.

---

## Project Setup

### Existing Project

```bash
git clone <repository-url>
cd <project-name>

# Install dependencies (see language-specific guide)
# Setup Git hooks: ~/.kiro/scripts/setup-git-hooks.sh
# Run tests: make test
```

### New Project

```bash
# Install kiro-best-practices
curl -fsSL https://raw.githubusercontent.com/kumagaias/kiro-best-practices/main/install.sh | bash

# See README for template setup
```

## Essential Commands

```bash
make help              # Show all commands
make install           # Install dependencies
make test              # Run all tests (unit + security)
make test-security     # Security checks only
make clean             # Clean build artifacts
```

**Note**: Always run `make test` before pushing

---

## Best Practices

### Code Quality
- Write clear, self-documenting code
- Keep functions small and focused (< 50 lines)
- Max file size: 500 lines
- Handle errors appropriately
- Follow language-specific conventions

### Testing
- Coverage target: 60% or higher
- Test edge cases
- Keep tests independent

### Security
- Never hardcode sensitive information
- Use environment variables
- Sanitize all inputs
- See `#security-policies` for details

### Performance
- Optimize critical paths
- Use caching strategies
- Monitor resource usage

## Prohibited Practices

- ❌ Hardcoding sensitive data
- ❌ Large files (> 500 lines)
- ❌ Omitting error handling
- ❌ Direct commits to main branch
- ❌ Oversized PRs (> 500 lines)
- ❌ N+1 query problems

## Deployment

**For detailed procedures, see**: `#deployment-workflow`

```bash
# Always test before push
make test
git push origin feat/issue-123-feature
```

---

**For language-specific practices, refer to:**
- `.kiro/steering/tech-typescript.md` - TypeScript/React/Node.js (use `#tech-typescript`)
- `.kiro/steering/tech-python.md` - Python (use `#tech-python`)
- `.kiro/steering/tech-go.md` - Go (use `#tech-go`)

**For specialized topics, use:**
- `#security-policies` - Security guidelines
- `#deployment-workflow` - Deployment procedures
