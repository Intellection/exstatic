# Release Guide for Exstatic

## **1. Update Version**
Before creating a new release, ensure that the version number is updated in the following files:

### **Update `mix.exs`**
Modify the `@version` field:
```elixir
defmodule Exstatic.MixProject do
  use Mix.Project

  @version "0.1.1"  # Update to the new version
  
  def project do
    [
      app: :exstatic,
      version: @version,
      elixir: "~> 1.18",
      ...
    ]
  end
end
```

---

## **2. Update `CHANGELOG.md`**
- Add a new section at the top for the new version.
- Summarize the key changes.

Example:
```markdown
## [0.1.1] - YYYY-MM-DD
### Added
- Support for additional platforms.
- Improved CI/CD workflows.
- Enhanced documentation.

### Fixed
- Resolved issue with downloading precompiled NIFs.
```

---

## **3. Commit Version Bump**
After updating the version, commit the changes:
```bash
git add mix.exs native.ex
git commit -m "Bump version to 0.1.1"
git push origin main
```

---

## **4. Tag the New Version**
To create a release, tag the new version and push it:
```bash
git tag -a v0.1.1 -m "Release version 0.1.1"
git push origin v0.1.1
```
This will trigger the GitHub Actions release workflow, compiling and uploading precompiled NIFs.

---

## **5. Monitor the Release Workflow**
- Go to **GitHub Actions** and check the **Compile & Upload NIFs** workflow.
- Verify that all jobs (for Linux and macOS targets) succeed.

---

## **5. Verify the Release**
Once the workflow completes:
- Go to [GitHub Releases](https://github.com/intellection/exstatic/releases) and confirm that the NIF artifacts are available.
- Download and test the precompiled NIFs using:
```elixir
EXSTATIC_BUILD=false mix rustler_precompiled.download Exstatic.Native --all --print
```
---
