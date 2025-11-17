# Algo Dev Plugin

A systematic toolkit for algorithm development that helps you create specs, generate implementation plans, and execute phase-by-phase with correctness and performance verification.

## Installation

Install with one command:

```bash
curl -sSL https://raw.githubusercontent.com/ryandday/claude-plugins/main/install.sh | bash
```

This installs the commands and agents to `~/.claude/` so you can use them in Claude Code.

## Features

### Commands

- **`/create_or_update_spec`** - Create or update a detailed algorithm specification with input/output examples, edge cases, and constraints
- **`/create_dev_plan_from_spec`** - Generate a structured development plan from a new or modified spec, broken down into phases
- **`/execute_dev_plan`** - Execute the development plan phase-by-phase with testing and verification

**Note**: These commands heavily utilize the claude code builtin [AskUserQuestion tool](https://code.claude.com/docs/en/tools/askuserquestion) to gather requirements, clarify ambiguities, and make decisions collaboratively throughout the process. Read documentation for better understanding of this tool to use it effectively.

### Agents

**Used by `/create_or_update_spec`:**
- **`codebase-explorer`** - Explores existing algorithmic implementations and patterns
- **`spec-structure-reviewer`** - Reviews spec YAML structure and template compliance
- **`spec-correctness-reviewer`** - Reviews algorithmic correctness and complexity analysis
- **`spec-simplifier`** - Identifies if specs should be split into multiple specs

**Used by `/execute_dev_plan`:**
- **`code-reviewer`** - Reviews code quality, guidelines compliance, and bug detection
- **`test-analyzer`** - Analyzes test coverage quality and completeness
- **`comment-analyzer`** - Reviews comment accuracy and maintainability
- **`silent-failure-hunter`** - Identifies inadequate error handling and silent failures
- **`type-design-analyzer`** - Reviews type design when types are added/modified
- **`code-simplifier`** - Polishes code for clarity and simplicity

## Usage

1. Start with `/create_or_update_spec` to define your algorithm requirements
2. Use `/create_dev_plan_from_spec` to create a phased development plan from your spec
3. Execute with `/execute_dev_plan` to build and verify each phase

