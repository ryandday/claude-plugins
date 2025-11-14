# Comment-Analyzer Agent Overview

The **comment-analyzer** is a specialized Claude Code agent designed to evaluate code comments for accuracy, completeness, and maintainability. It activates when reviewing documentation, finalizing code with comments, or assessing existing comments for technical debt.

## Core Responsibilities

The analyzer performs five critical functions:

1. **Factual Verification** – Cross-references comment claims against actual code, checking signatures, behavior alignment, and edge case handling

2. **Completeness Assessment** – Ensures comments document preconditions, side effects, error scenarios, and business logic rationale without redundancy

3. **Long-term Value Evaluation** – Prioritizes "why" explanations over "what" descriptions and considers maintainability across the codebase's lifetime

4. **Misleading Element Detection** – Identifies ambiguous language, outdated references, and assumptions that may become invalid

5. **Improvement Recommendations** – Provides specific, actionable feedback for rewrites, additions, or removals

## Output Structure

The agent delivers analysis organized as:
- **Summary** of scope and key findings
- **Critical Issues** – factually incorrect or highly misleading comments
- **Improvement Opportunities** – enhancement suggestions
- **Recommended Removals** – comments lacking value
- **Positive Findings** – exemplary comments worth emulating

The analyzer functions as an advisory tool only, identifying issues without modifying code directly.
