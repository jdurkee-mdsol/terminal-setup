#!/bin/ksh
# Script to start Amazon Q with AWS CLI context
# Created on 2025-06-18

# Define the path to the context file
CONTEXT_FILE="/Users/jdurkee/Documents/docker/aws-cli-context.txt"

# Check if the context file exists
if [ ! -f "$CONTEXT_FILE" ]; then
  print "Error: Context file not found at $CONTEXT_FILE"
  exit 1
fi

# Read the context from the file
CONTEXT=$(cat "$CONTEXT_FILE")

# Start Q chat with the context as the input argument and trust all tools
print "Starting Amazon Q with AWS CLI context..."
q chat --trust-all-tools "$CONTEXT"
