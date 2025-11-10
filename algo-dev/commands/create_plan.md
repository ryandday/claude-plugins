---
description: Guided algorithm implementation plan creation
argument-hint: Algorithm spec file path
---

You are helping a developer create a phased implementation plan from an existing algorithm specification. Follow a systematic approach: understand the spec deeply, analyze dependencies, create parallelizable phases with verification strategies.

## Core Principles

- **Keep the plan thin**: Reference spec IDs rather than duplicating details
- **Maximize parallelization**: Only add dependencies when truly blocking
- **Minimize phase count**: Create fewer, larger phases that still deliver coherent functionality and remain testable
- **Make phases verifiable**: Every phase should be testable for correctness and performance
- **Plain English tasks**: Actionable task descriptions with spec references
- **Use TodoWrite**: Track all progress throughout

---

## Phase 1: Discovery

**Goal**: Understand the specification and validate completeness

**Actions**:
1. Create todo list with all 8 phases (Discovery, Codebase Analysis, Dependency Analysis, Phase Design, Task Generation, Verification Strategy, Write Plan Specification, Validation)
2. Parse arguments to get algorithm spec path
3. Read the specification file COMPLETELY (no limit/offset)
4. Validate that spec is complete:
   - Problem statement is clear with examples
   - Algorithms are well-defined with clear purposes
   - Signatures, complexity targets, and approaches are specified
   - Test cases cover basic, edge, and performance scenarios
   - Call graph shows algorithm relationships
5. If spec is incomplete or has inconsistencies, stop and inform the user
6. Summarize what will be implemented and confirm with user

---

## Phase 2: Codebase Analysis

**Goal**: Determine which algorithms are new, modifications, or extractions by analyzing the codebase

**Actions**:
1. Extract all algorithms from spec (from `algorithms` section)
2. For each algorithm, search the codebase to determine:
   - **New**: Function doesn't exist yet
   - **Modified**: Function exists but needs algorithmic changes
   - **Extracted**: Common logic that should be pulled out from existing code
3. Document findings:
   - Which algorithms are truly new implementations
   - Which existing functions need to be modified and where they are
   - Which logic should be extracted into helper functions
4. Present codebase analysis to user

---

## Phase 3: Dependency Analysis

**Goal**: Understand which algorithms can be built in parallel vs sequentially

**Actions**:
1. Analyze dependencies from spec's `call_graph` section and findings from Phase 2:
   - Which algorithms call other algorithms?
   - Which modified algorithms depend on new helper functions?
   - Which test cases depend on which algorithms being complete?
   - Are there shared data structures or utilities needed?
2. Build dependency map
3. Identify clusters of related algorithms that form logical implementation units
4. Present dependency findings to user

---

## Phase 4: Phase Design

**Goal**: Group work into parallelizable implementation phases

**Actions**:
1. Group related algorithms into logical phases
2. Prefer fewer, larger phases over many small phases:
   - Combine related algorithms that can be implemented together
   - Only split into separate phases when there are true blocking dependencies or when a phase would become too large to test effectively
   - Aim for 3-5 phases total when possible, not 10+ micro-phases
3. For each phase, determine:
   - What functionality it delivers
   - Which algorithms it implements (ALGO-FUNC-*)
   - What it depends on (blocking dependencies only)
   - How it can be verified (correctness and performance tests)
4. Optimize for parallelization:
   - Minimize `depends_on` where possible
   - Suggest temporary stubs/mocks to enable parallel work
   - Add integration phases where parallel work needs connecting
5. Present proposed phasing to user for feedback
6. Adjust based on user input

---

## Phase 5: Task Generation

**Goal**: Generate plain English task lists for each phase

**Actions**:
1. For each phase, extract referenced algorithm IDs
2. Generate tasks by walking through implementation needs based on Phase 2 codebase analysis:
   - New functions to create (algorithms identified as new)
   - Existing functions to modify (algorithms identified as modifications)
   - Helper functions to extract (algorithms identified as extractions)
   - Data structures to implement
   - Test cases to write (from test_cases section)
   - Performance benchmarks to create
3. Order tasks logically (helpers → main algorithms → modifications → tests → benchmarks)
4. Keep tasks concrete and actionable
5. Include spec ID references in parentheses

---

## Phase 6: Verification Strategy

**Goal**: Define how each phase will be verified

**Actions**:
1. For each phase, determine verification approach:
   - Correctness tests: Which test cases validate this phase?
   - Performance tests: How to verify complexity targets?
   - Integration tests: How algorithms work together?
   - Edge case coverage: Which edge cases are tested?
2. Add `verification` section to each phase with:
   - `correctness_test`: How to verify algorithm correctness
   - `performance_test`: How to validate complexity targets
   - `test_data`: What test inputs to use (if needed)
   - `temporary_stubs`: Temporary mocks/stubs (if needed)
   - `workaround`: Known limitations during this phase (if needed)
   - `cleanup`: What gets removed in later phases (if temporary code added)
3. Ensure every phase is independently verifiable

---

## Phase 7: Write Plan Specification

**Goal**: Create the implementation plan YAML file

**Actions**:
1. Write plan to `docs/specifications/YYYY_MM/description/algo-plan.yaml`

2. Use this structure:

```yaml
# algo_implementation_plan: v1
id: PLAN-ALGO-[DESCRIPTION]
title: [Plan Title]
created: YYYY-MM-DD
algo_spec: ALGO-[ID]

phases:
  - id: PHASE-1
    name: "[Phase Name]"
    implements: [ALGO-FUNC-01, ALGO-FUNC-03]  # Which algorithms
    depends_on: []
    tasks:
      - "Implement helper function [name] (ALGO-FUNC-03)"
      - "Implement main algorithm [name] (ALGO-FUNC-01)"
      - "Add test cases (TEST-01, TEST-02)"
    verification:
      correctness_test: "Run test cases TEST-01, TEST-02 - expect all pass"
      performance_test: "Benchmark with input size 10^5 - expect O(n) behavior"
      test_data: "Use provided examples from spec"  # optional

  - id: PHASE-2
    name: "[Another Phase]"
    implements: [ALGO-FUNC-02]
    depends_on: []  # parallelizable with PHASE-1
    tasks:
      - "Implement algorithm [name] (ALGO-FUNC-02)"
      - "Add performance benchmarks"
    verification:
      correctness_test: "Run test cases TEST-03, TEST-04"
      performance_test: "Compare against baseline - expect 10x speedup"
      temporary_stubs: "Stub out ALGO-FUNC-01 calls for now"  # optional
      workaround: "Won't integrate with PHASE-1 until PHASE-3"  # optional

  - id: PHASE-3
    name: "Integration & Optimization"
    implements: [ALGO-FUNC-04]
    depends_on: [PHASE-1, PHASE-2]
    tasks:
      - "Wire up algorithm calls between PHASE-1 and PHASE-2"
      - "Remove temporary stubs from PHASE-2"
      - "End-to-end correctness testing"
      - "Full performance benchmark suite"
    verification:
      correctness_test: "Run all test cases - expect 100% pass"
      performance_test: "Benchmark full call graph - verify complexity targets met"
      cleanup: "All temporary stubs removed"
```

---

## Phase 8: Validation

**Goal**: Verify plan is complete and optimal

**Actions**:
1. Validate coverage:
   - Every algorithm from spec is in some phase's `implements`
   - All test cases are assigned to phases
   - All implementation items from Phase 2 analysis are covered in tasks
2. Check for issues:
   - Circular dependencies in `depends_on`
   - Missing verification strategies
   - Tasks without spec references
3. Optimize parallelization:
   - Could any `depends_on` be removed with temporary stubs?
   - Are integration phases in the right place?
4. Present validation results to user

---

## Key Principles

**Thin Plan**: The plan is orchestration only. All details live in algorithm spec. Tasks reference spec IDs heavily.

**Parallelization**: Maximize parallel work. Only add `depends_on` for true blocking dependencies. Use temporary stubs/mocks to enable parallel development.

**Algorithm-Centric**: Phases deliver vertical slices of functionality - complete algorithms with their tests, not just "write all helpers" then "write all main functions".

**Minimize Phases**: Prefer fewer, larger phases (3-5 total) over many small phases. Combine related work unless there are blocking dependencies or testability concerns.

**Verification**: Every phase must be verifiable for both correctness and performance. Define specific test cases and benchmarks for each phase.

**Integration Phases**: When parallel phases need wiring together, create explicit integration phases that connect them and clean up temporary code.

**Use TodoWrite**: Track all progress throughout the planning process.
