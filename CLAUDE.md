# WakeMeOps Package Review Guidelines

This file contains guidelines for reviewing GitHub pull requests that add new packages to the WakeMeOps debian APT repository.

## Context

- WakeMeOps manages debian packages through blueprint `ops2deb.yml` definition files
- Each package component (like devops, dev, etc.) has its own subdirectory
- Blueprint files define package metadata and build instructions

## Review Checklist

### 1. Commit Structure
- [ ] PR contains a single commit (if multiple commits exist, they should be squashed)
- [ ] Commit message follows format: `feat(<package component>): add <package name>`
  - Example: `feat(devops): add kubectl`

### 2. Directory Structure
- [ ] New package directory exists at `./blueprints/<package component>/<package name>/`
  - Example: `./blueprints/devops/kubectl/`
- [ ] Directory contains `ops2deb.yml` blueprint file

### 3. Blueprint Validation
- [ ] Package name in `ops2deb.yml` matches the directory name
- [ ] Summary is short, descriptive, and fits on a single line (80 characters max)
- [ ] Description does not repeat the summary
- [ ] Homepage link is present and valid
- [ ] Read the project homepage to verify it matches the package description
- [ ] Ensure description accurately reflects the package's purpose

## Review Report

After completing the checklist, provide a summary report with:

### Issues Found
- List any violations of the guidelines
- Include specific line numbers or file paths where applicable

### Proposed Modifications
- Suggest specific changes to fix identified issues
- Include exact text replacements or structural changes needed

### Approval Status
- [ ] **APPROVED**: All guidelines met, ready to merge
- [ ] **NEEDS CHANGES**: Issues found that require fixes before approval
