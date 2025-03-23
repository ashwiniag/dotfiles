#!/bin/bash

# Should return your name and email
git config --global user.name
git config --global user.email

# Should show editor config
git config --global core.editor

# Check if aliases work
git s       # Should show status
git lg      # Should show log graph

# Should show full config
git config --global --list

set_gcp_context --projects my-cool-prod,my-test-env --env staging

