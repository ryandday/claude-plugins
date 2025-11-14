---
description: Execute algorithm implementation plan phase by phase
argument-hint: Plain English description of what to implement
---

You are helping a developer implement a specific phase from an existing algorithm implementation plan. Follow a systematic approach: understand which phase to implement, execute tasks methodically, fix all automated checks, and verify correctness and performance.

## Core Principles

- **Auto-fix everything**: NEVER prompt user for compile/lint/test/format failures - fix them all
- **Ask for help sparingly**: Only ask user for guidance on implementation tasks after >4 failed attempts
- **Update <algo>-implementation-plan.yaml**: Mark phases as in_progress and completed
- **Use TodoWrite**: Track all task progress throughout
- **Verify thoroughly**: Run all automated checks and correctness/performance tests

---

## Phase 1: Load & Select Phase

**Goal**: Determine which phase to implement

**Actions**:
1. Create todo list with all phases of this document
2. Look for <algo>-implementation-plan.yaml file in `docs/implementation_plans/YYYY_MM/` (search by pattern if needed)
3. Read <algo>-implementation-plan.yaml and the algo spec (referenced in plan) COMPLETELY
4. Identify target phase. If unclear, find first phase with no `status` field (not started)
5. If phase has `depends_on: [PHASE-A, PHASE-B]`, verify those phases have `status: completed`
6. Show phase summary:
    - Phase name and what it implements
    - Number of tasks
    - Verification strategy
7. Update <algo>-implementation-plan.yaml: set phase `status: in_progress`

---

## Phase 2: Codebase Exploration

**Goal**: Understand existing patterns before implementing

**Actions**:
1. Launch 2-3 code-explorer agents in parallel to explore different aspects relevant to this phase
2. Each agent should:
   - Focus on a different aspect based on what the phase implements
   - Trace through existing implementations comprehensively
   - Return a list of 5-10 key files to read for context
3. Design agent prompts based on phase content. For example, if phase implements algorithms:
   - Agent 1: "Find similar algorithm implementations and trace through their structure, data structures, and complexity patterns comprehensively"
   - Agent 2: "Analyze helper function patterns and code organization for similar problems, focusing on reusable utilities"
   - Agent 3: "Trace testing approaches and performance benchmarking patterns for similar algorithms comprehensively"
4. Wait for all agents to complete
5. Read all key files identified by agents COMPLETELY (no limit/offset)
6. Summarize patterns and conventions discovered

---

## Phase 3: Task Execution

**Goal**: Implement all tasks in the phase

**Actions**:
1. Create TodoWrite list from phase tasks
2. For each task in the phase:
   1. Mark task as in_progress in TodoWrite
   2. Parse task to identify what needs to be done and which spec IDs are referenced
   3. Read all relevant spec sections for full context:
      - If task references ALGO-FUNC-*, read that algorithm definition from algo spec
      - If task references TEST-*, read that test case from algo spec
      - Read approach, complexity targets, invariants, and edge cases sections
   4. Implement the task:
      - Create or modify files as needed
      - Write complete, production-quality code
      - Follow existing codebase patterns and conventions
      - Ensure correctness and meet complexity targets
   5. After completing a substantial task (e.g., implementing main algorithms, complex helpers):
      - Run incremental checks: lint and compile/build
      - Run relevant test cases
      - Fix any issues immediately
   6. If task fails repeatedly:
      - Attempt to fix and retry automatically
      - After 4 failed attempts on the same issue, ask user: "This task keeps failing: [description]. What guidance can you provide?"
      - Incorporate user guidance and continue
   7. Mark task as completed in TodoWrite

---

## Phase 4: Verification & Finalization

**Goal**: Verify phase correctness, performance, and quality

**Actions**:
1. Run full automated checks:
   - Compile/build check
   - Lint check
   - Test suite (correctness tests)
   - Format check
   - Any other checks specified by the plan
2. Fix ALL automated check failures:
   - NEVER prompt user about these failures
   - Keep fixing until all checks pass
   - No limit on attempts for automated checks
4. Once all checks pass, launch applicable review agents in parallel:
   - **code-reviewer**: General code quality, guidelines compliance, bug detection
   - **test-analyzer**: Test coverage quality if tests written
   - **comment-analyzer**: Comment accuracy if documentation added
   - **silent-failure-hunter**: Error handling if error logic changed
   - **type-design-analyzer**: Type design if types added/modified
   - **code-simplifier**: Code clarity polish (run after others pass)

5. Wait for all review agents to complete
6. Address any critical issues identified by review agents
7. Review phase's `verification` section from <algo>-implementation-plan.yaml
8. Execute verification as specified:
   - Run correctness tests specified in `correctness_test`
   - Run performance tests specified in `performance_test`
   - Use test data from `test_data` if specified
9. Present verification results to user:
   - Correctness: Which test cases passed/failed
   - Performance: Actual vs target complexity, benchmark results
10. Wait for user confirmation that verification is acceptable
11. Update <algo>-implementation-plan.yaml: set phase `status: completed`
12. Suggest next available phase and wait for user input

---

## Key Principles

**Automated Problem Solving**: Fix compile errors, lint issues, test failures, and formatting automatically. Never ask the user to fix these - that's your job.

**Implementation Task Guidance**: For implementation tasks (creating algorithms, helpers, data structures), try 4 times before asking user for help. Automated checks have no retry limit.

**Complete Context**: Always read the full spec sections for tasks. Don't guess at implementation details - read ALGO-FUNC-*, TEST-* references completely.

**Plan Updates**: Keep <algo>-implementation-plan.yaml in sync. Mark phases as `in_progress` when starting, `completed` when done.

**Correctness First**: Every phase must pass correctness tests before performance optimization. Execute verification tests and confirm results with user.

**Performance Verification**: Run benchmarks to verify complexity targets are met. Report actual performance characteristics.

**Use TodoWrite**: Track every task throughout execution to show progress.
