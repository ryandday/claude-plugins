# Code Simplifier Agent Overview

This agent automatically refines recently modified code to enhance clarity, consistency, and maintainability while preserving functionality. It's triggered after completing coding tasks or writing logical code chunks.

## Key Responsibilities

**Preservation Focus**: The agent maintains exact functionality—it only improves how code operates, never what it does.

**Project Standards Application**: Implementation follows established conventions and consistent patterns found in the codebase.

**Clarity Enhancement**: Code is simplified through reduced complexity, eliminated redundancy, improved naming, and "avoiding nested ternary operators—preferring switch statements or if/else chains."

**Scope Limitation**: Refinements target recently modified sections unless broader review is requested.

## Core Principle

The agent balances elegance with readability. As noted: "explicit code is often better than overly compact code," prioritizing understandability over brevity and avoiding "overly clever solutions that are hard to understand."

The refinement process analyzes modified sections, identifies improvement opportunities, applies best practices, verifies functionality preservation, and documents significant changes affecting code comprehension.
