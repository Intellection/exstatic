# Setting Up a GitHub Personal Access Token for Exstatic

This guide walks you through creating a **GitHub Personal Access Token (PAT)** to allow Exstatic to authenticate and fetch precompiled NIFs from a private repository.

## 1️⃣  Generate a New Token

1. **Go to GitHub Token Settings:**
   - Navigate to [GitHub Personal Access Tokens](https://github.com/settings/tokens).
   - Click **"Generate new token (classic)"**.

## 2️⃣  Configure Token Permissions

1. **Token Name:**
   - Give it a meaningful name like `exstatic-release-access`.

2. **Expiration:**
   - Choose an expiration date.

3. **Select Scopes:**
   - The following scopes are required for accessing private repositories:
     
     ✅ **repo** → Full read access to private repositories  
     ✅ **read:packages** → Read access to GitHub Packages (under write:packages)

## 3️⃣  Generate and Store the Token

1. Click **"Generate token"**.
2. **Copy the token** – it will not be shown again.

---

### 4️⃣  Set Environment Variable
1. Exstatic needs this to during installation:

    ```sh
    export EXSTATIC_GITHUB_TOKEN="your-token-here"
    ```
