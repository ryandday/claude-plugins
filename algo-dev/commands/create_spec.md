---
description: Guided algorithmic specification with codebase understanding and design focus
argument-hint: Algorithm description or problem statement
---

You are helping a developer create a specification for a new or existing algorithm or algorithmic solution. Follow a systematic approach: understand the problem and codebase deeply, identify and ask about all underspecified details, design robust solutions, write a spec for it.

## Core Principles

- **Ask clarifying questions**: Identify all ambiguities, edge cases, and underspecified behaviors. Ask specific, concrete questions rather than making assumptions. Wait for user answers before proceeding with design. Ask questions early (after understanding the codebase, before designing algorithm). Use askquestion tool when possible.
- **Understand before acting**: Read and comprehend existing code patterns first
- **Read files identified by agents**: When launching agents, ask them to return lists of the most important files to read. After agents complete, read those files to build detailed context before proceeding.
- **IMPORTANT**: Use the Read tool WITHOUT limit/offset parameters to read entire files
- **NEVER** read files partially - if a file is mentioned, read it completely
- **Use TodoWrite**: Track all progress throughout
- **No open questions in final spec**: Do NOT write specs with unresolved questions. If you encounter ambiguity during design, STOP and clarify immediately.

---

## Phase 1: Discovery

**Goal**: Understand what problem needs to be solved

**Actions**:
1. Create todo list with all phases
2. If problem statement is unclear, ask user for:
    - What problem are we solving?
    - What are the inputs and expected outputs?
    - Any performance constraints or requirements?
    - Examples of expected behavior?
3. Summarize understanding and confirm with user

---

## Phase 2: Codebase Exploration

**Goal**: Understand relevant existing algorithms and code patterns

**Actions**:
1. Launch 2-4 code-explorer agents in parallel. Each agent should:
   - Trace through similar algorithmic implementations comprehensively
   - Focus on understanding algorithm patterns, data structures used, and code organization
   - Target a different aspect (eg. similar algorithms, helper functions, data structure usage, testing patterns)
   - Include a list of 5-10 key files to read

   **Example agent prompts**:
   - "Find similar algorithmic implementations to [problem] and trace through their approach, data structures, and complexity comprehensively"
   - "Map the helper function patterns and utility code for [problem domain], tracing through code organization comprehensively"
   - "Analyze existing implementations in [module/area], tracing through algorithm choices, edge case handling, and testing approaches comprehensively"
   - "Identify common data structures, algorithm patterns, and optimization techniques relevant to [problem]"

2. Once the agents return, read ALL files identified by agents COMPLETELY (no limit/offset) to build deep understanding
3. Present comprehensive summary of findings and patterns discovered
4. **Play completion notification**: Run `afplay /System/Library/Sounds/Glass.aiff` to notify user that exploration is complete

---

## Phase 3: Clarifying Questions

**Goal**: Fill in gaps and resolve all ambiguities before designing algorithm

**CRITICAL**: This is one of the most important phases. DO NOT SKIP.

**Actions**:
1. Review the codebase findings and original problem statement
2. Identify underspecified aspects: edge cases, input constraints, complexity requirements, integration points, scope boundaries, correctness requirements
3. **Present all questions to the user in a clear, organized list**. Use askquestion tool.
4. **Wait for answers before proceeding to algorithm design**

If the user says "whatever you think is best", provide your recommendation and get explicit confirmation.

## Phase 4: Detailed Specification Writing

**Goal**: Create comprehensive algorithm specification document

**Actions**:
1. Write the specification to `docs/specifications/YYYY_MM/description/algo.yaml`

2. Use this template structure:

```yaml
# algo_spec: v1
id: ALGO-[DESCRIPTION]
title: [Algorithm Title]
created: YYYY-MM-DD

problem:
  statement: "[What are we solving?]"
  examples:
    - input: "[example input]"
      output: "[example output]"
      invariants: "[example invariants]"
      explanation: "[why]"

constants:
  CONSTANT_NAME:
    value: [value]
    purpose: "[what it does]"
    file: "[optional: path/to/file.ts:line]"

# ALGORITHMS (implementation details - HOW to implement)
algorithms:
  - id: ALGO-FUNC-01
    function: "[actualFunctionName]"  # Use real function name from codebase
    purpose: "[what this does]"
    signature:
      inputs:
        - name: "[param]"
          type: "[type - consider shorthand: int8/16/24/32, float32/64, bool]"
          constraints: "[e.g., 1 <= n <= 10^5, non-null, etc]"
      output:
        type: "[return type]"
        invariants: "[what's guaranteed about output]"
    complexity_targets:
      time: "[O(n), O(n log n), etc]"
      space: "[O(1), O(n), etc]"
      justification: "[why this is optimal/acceptable]"
    approach:
      strategy: "[greedy, DP, divide & conquer, two pointers, etc]"
      key_insight: "[the main insight that makes this work]"
      steps:
        - "[Concrete step 1 with pseudocode/formula]"
        - "[Concrete step 2 with implementation details]"
        - "[Step 3 - use high level HOW, not too detailed]"
    data_structures:
      - name: "[structure name OR 'constants' to reference constants section]"
        type: "[array, hashmap, heap, tree, OR list of constant names like 'CONST1, CONST2']"
        purpose: "[why we need this structure]"
    edge_cases:
      - condition: "[edge case condition - ONLY non-trivial ones]"
        handling: "[how to handle it]"
    execution_invariants:
      - condition: "[what must always be true during execution - algorithm-specific]"
        why: "[what breaks if this is violated]"
    calls: ["ALGO-FUNC-Y"]  # What algorithms this depends on
    impl: "path/to/file.ts::functionName"  # Direct link to implementation

# TEST COVERAGE
test_cases:
  - id: TEST-01
    tests: ALGO-FUNC-01
    input: "[test input]"
    expected: "[expected output]"
    category: "[basic/edge/performance/correctness]"
    why: "[what this validates]"

# DESIGN CONSTRAINTS (system-wide design decisions affecting multiple algorithms)
design_constraints:
  - constraint: "[design decision that affects multiple algorithms]"
    rationale: "[why we made this choice]"
    affects: ["ALGO-FUNC-X", "ALGO-FUNC-Y"]

# KNOWN LIMITATIONS (cross-cutting limitations spanning multiple algorithms or external code)
known_limitations:
  - limitation: "[limitation affecting multiple algorithms or external dependencies]"
    description: "[detailed explanation]"
    severity: "[critical/acceptable/data-loss/architectural]"
    affects: ["ALGO-FUNC-X", "ALGO-FUNC-Y", "ExternalClass"]
    workaround: "[optional: how to work around it]"
    impact: "[what are the consequences]"

# RECOMMENDED IMPROVEMENTS (future enhancements affecting multiple algorithms)
recommended_improvements:
  - description: "[improvement that would affect multiple algorithms]"
    priority: "[high/medium/low]"
    rationale: "[why this would be valuable]"
    affects: ["ALGO-FUNC-X", "ALGO-FUNC-Y"]
    effort: "[low/medium/high - optional]"

# CORRECTNESS REASONING
correctness:
  - algorithm: ALGO-FUNC-01
    argument: |
      [Informal proof or reasoning why this algorithm is correct]
      - [Why the approach works]
      - [Why invariants hold]
      - [Why edge cases are handled]
      - LIMITATION: [any known limitations specific to this algorithm]

notes: |
  [ONLY super important considerations that don't fit elsewhere - NOT phased plans]
```

---

## Phase 5: Expert Review

**Goal**: Validate specification against correctness, complexity, and simplicity principles

**Actions**:
1. Spawn expert review agents in parallel using the Task tool (spawn ALL agents concurrently):

   - **architecture-compliance-checker** agent - Review code organization, ensure patterns match existing conventions, check integration points

   - **spec-simplifier** agent - Identify over-engineering and unnecessary complexity. Look for simpler algorithmic approaches, unnecessary data structures, and opportunities to leverage existing helper functions

   Provide all agents with:
   - The full path to the created algorithm specification file
   - The original problem statement/context

2. Wait for all reviews to complete before proceeding

3. Present the experts' feedback to the user and apply recommendations as needed

4. **Play completion notification**: Run `afplay /System/Library/Sounds/Glass.aiff` to notify user that reviews are complete

---

## Key Principles

**Algorithmic Foundation**: Focus on correctness first, then complexity. Question approach feasibility and identify bottlenecks. Consider edge cases and invariants from the start.

**Code Organization**: Follow existing patterns and conventions. Leverage existing helper functions rather than duplicating logic. Define clear function contracts and call graphs.

**Quality**: Read all context files completely. Research algorithmic patterns thoroughly using parallel agents. Include specific file:line references. Define measurable complexity targets and test cases. Plan for correctness verification.

**Non-negotiable**: No open questions in final spec. If you encounter ambiguity, STOP and clarify immediately. Use TodoWrite to track all progress.
