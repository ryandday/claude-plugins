# Test Analyzer Agent Overview

This agent specializes in evaluating test coverage quality and completeness. It focuses on behavioral coverage rather than achieving arbitrary metrics.

## Key Responsibilities

The agent examines whether tests adequately cover "critical code paths, edge cases, and error conditions that must be tested to prevent regressions." It prioritizes identifying untested error handling, missing edge cases, and uncovered business logic branches.

## Analysis Approach

The methodology involves:
- Examining code changes to understand new functionality
- Reviewing accompanying tests for coverage mapping
- Identifying critical paths that could fail in production
- Checking for implementation-coupled tests
- Evaluating negative cases and error scenarios
- Assessing integration point coverage

## Criticality Rating System

Recommendations range from 1-10, with guidance including:
- **9-10**: Functionality affecting data integrity, security, or system stability
- **7-8**: Important business logic that impacts user experience
- **5-6**: Edge cases causing potential confusion or minor issues
- **3-4**: Optional completeness improvements
- **1-2**: Minor enhancements

## Core Philosophy

The agent emphasizes pragmatism over perfection, focusing on "tests that prevent real bugs, not academic completeness." It avoids suggesting unnecessary coverage for trivial code while being specific about what each test should verify and why it matters.
