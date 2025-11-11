#!/bin/bash

# Install script for algo-dev agents and commands
# This script clones the repo and copies agents and commands to ~/.claude

set -e  # Exit on error

REPO_URL="https://github.com/ryandday/claude-plugins.git"
TEMP_DIR=$(mktemp -d)
CLAUDE_DIR="$HOME/.claude"

echo "📦 Installing algo-dev agents and commands..."
echo ""

# Clone the repository
echo "🔄 Cloning repository..."
git clone "$REPO_URL" "$TEMP_DIR"
echo "✅ Repository cloned to $TEMP_DIR"
echo ""

# Create .claude directories if they don't exist
echo "📁 Creating .claude directories..."
mkdir -p "$CLAUDE_DIR/agents"
mkdir -p "$CLAUDE_DIR/commands"
echo "✅ Directories created"
echo ""

# Copy agents
echo "🤖 Copying agents..."
if [ -d "$TEMP_DIR/algo-dev/agents" ]; then
    cp -v "$TEMP_DIR/algo-dev/agents/"*.md "$CLAUDE_DIR/agents/"
    AGENT_COUNT=$(ls "$TEMP_DIR/algo-dev/agents/"*.md 2>/dev/null | wc -l | tr -d ' ')
    echo "✅ Copied $AGENT_COUNT agent(s)"
else
    echo "⚠️  No agents directory found"
fi
echo ""

# Copy commands
echo "⚡ Copying commands..."
if [ -d "$TEMP_DIR/algo-dev/commands" ]; then
    cp -v "$TEMP_DIR/algo-dev/commands/"*.md "$CLAUDE_DIR/commands/"
    COMMAND_COUNT=$(ls "$TEMP_DIR/algo-dev/commands/"*.md 2>/dev/null | wc -l | tr -d ' ')
    echo "✅ Copied $COMMAND_COUNT command(s)"
else
    echo "⚠️  No commands directory found"
fi
echo ""

# Cleanup
echo "🧹 Cleaning up..."
rm -rf "$TEMP_DIR"
echo "✅ Temporary files removed"
echo ""

echo "🎉 Installation complete!"
echo ""
echo "Installed to:"
echo "  Agents:   $CLAUDE_DIR/agents/"
echo "  Commands: $CLAUDE_DIR/commands/"
echo ""
echo "You can now use these commands and agents in Claude Code."
