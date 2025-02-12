#!/bin/bash
set -e

# Replace with your GitHub username and desired repo name.
GITHUB_USER="taylortechdigital"
REPO_NAME="weather-alert-system"

echo "== Creating GitHub repository =="
gh repo create $REPO_NAME --public --confirm

echo "== Initializing Git repository locally =="
git init
git remote add origin https://github.com/$GITHUB_USER/$REPO_NAME.git

echo "== Adding all files and committing =="
git add .
git commit -m "Initial commit"
git push -u origin main

echo "Git repository setup complete!"
