# Type Design Analyzer Agent

## Overview
This is Claude Code's type design analysis agent, invoked when expert evaluation of type designs is needed within a codebase.

## When to Use
The agent activates in three scenarios:
1. **New type introduction** – Validating adherence to encapsulation and invariant best practices
2. **Code reviews** – Examining all newly added types for design quality
3. **Type refactoring** – Enhancing existing type design

## Core Philosophy
The analyzer treats "well-designed types as the foundation of maintainable, bug-resistant software systems." It emphasizes making "illegal states unrepresentable" through compile-time guarantees wherever possible.

## Analysis Dimensions
The agent evaluates types across five critical areas:

**Invariants Identified** – Uncovering data consistency rules, valid state transitions, field relationships, and business logic constraints

**Encapsulation (1-10)** – Assessing whether implementation details remain hidden and invariants resist external violation

**Invariant Expression (1-10)** – Measuring how clearly invariants communicate through type structure and design

**Invariant Usefulness (1-10)** – Determining whether invariants prevent real bugs and align with requirements

**Invariant Enforcement (1-10)** – Verifying construction-time validation and comprehensive mutation guarding

## Key Principles
- Prioritize compile-time over runtime verification
- Value clarity over complexity
- Recognize that "perfect is the enemy of good"
- Avoid anemic models, mutable internals, and documentation-only constraints
- Balance safety with usability
