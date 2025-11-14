# Code Reviewer Agent Documentation

This document defines Claude Code's code-reviewer agent, an automated system for validating code quality against project standards.

## Purpose

The agent reviews code for adherence to project guidelines, style standards, and best practices. It's designed for proactive use after code modifications and before submitting code.

## Key Operational Parameters

**Default Review Scope**: Unstaged changes, with user ability to specify alternative files

**Model**: Opus
**Status Indicator**: Green

## Review Framework

The agent evaluates three dimensions:

1. **Project Guidelines Compliance** - Verifies adherence to rules in CLAUDE.md or equivalent documentation
2. **Bug Detection** - Identifies functional issues including logic errors, null handling, security vulnerabilities
3. **Code Quality** - Assesses duplication, error handling gaps, accessibility concerns, and test coverage

## Confidence Scoring System

Issues are rated 0-100, with reporting threshold at 80+:

- **80-89**: Important issues requiring attention
- **90-100**: Critical bugs or explicit guideline violations

The system filters aggressively to minimize false positives, prioritizing actionable findings.

## Output Structure

Reviews identify scope, then list high-confidence issues by severity with file locations, rule citations, and remediation guidance. When standards are met, the agent confirms compliance with a summary.
