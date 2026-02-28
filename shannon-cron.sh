#!/bin/bash
# Shannon Pentester - 3-day Recurring Check
# This script is intended to be run by cron every 3 days.

CDW=$(dirname "$0")
cd "$CDW"

# Source environment variables
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

# Configuration
TARGET_URL="http://host.docker.internal:8080"
REPO_NAME="hufolyamat"
WORKSPACE_NAME="periodic-audit-$(date +%Y-%m-%d)"

echo "Starting periodic Shannon audit for $REPO_NAME at $(date)"

# Run shannon
./shannon start URL=$TARGET_URL REPO=$REPO_NAME WORKSPACE=$WORKSPACE_NAME ROUTER=true >> ./audit-logs/cron-audit.log 2>&1

echo "Audit submitted. Monitor progress at http://localhost:8233"
