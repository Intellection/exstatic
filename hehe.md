1. Go to GitHub Token Settings
Open GitHub Personal Access Tokens
Click "Generate new token (classic)".
2. Configure Token Permissions
Token Name:
Give it a meaningful name like `exstatic-release-access`.

Expiration:
Choose "No expiration" or a time period based on your security policy.

Select Scopes:
For private repositories, you need:

✅ repo → Full read access to private repositories

This includes:
repo:status
repo_deployment
public_repo
repo:invite
✅ read:packages

3. Generate and Copy the Token
Click "Generate token".
Copy the token immediately (you won’t see it again!).
