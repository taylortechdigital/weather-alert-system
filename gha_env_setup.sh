#!/bin/bash
# Script to set GitHub repository secrets using the GitHub CLI
# Replace with your repository slug (e.g., "myusername/my-repo")
export REPO="taylortechdigital/weather-alert-system"

gh secret set AWS_ACCESS_KEY_ID --repo "$REPO" --body "$AWS_ACCESS_KEY_ID"
gh secret set AWS_SECRET_ACCESS_KEY --repo "$REPO" --body "$AWS_SECRET_ACCESS_KEY"
gh secret set AWS_REGION --repo "$REPO" --body "$AWS_REGION"
gh secret set AWS_ACCOUNT_ID --repo "$REPO" --body "$AWS_ACCOUNT_ID"
gh secret set GITHUB_TOKEN --repo "$REPO" --body "$GITHUB_TOKEN"