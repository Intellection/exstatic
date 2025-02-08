# Exstatic Release Process

This document outlines the steps required to release a new version of Exstatic, ensuring that both Elixir and native Rust code are properly updated and distributed via precompiled NIFs.

## **1️⃣  Bump version in `mix.exs`**

After you've made your code changes, update the version in mix.exs (`@version "x.y.z"`)

Now follow the steps below to release the update.

## **2️⃣  Merge Changes to `main`**

- Open a **Pull Request** including:
  - Code changes (including the version bump in mix.exs)
  - A CHANGELOG.md entry for this release.

Once approved and CI passes - **merge to `main`**.

## **3️⃣  Tag & Create a GitHub Release**

1. To create a release, check out the latest `origin/main` (this should be what you just merged), tag the new version and push it:

    ```sh
    git tag -a vX.Y.Z -m "Release version X.Y.Z"
    git push origin vX.Y.Z
    ```

    <strong>Ensure the tag (`vX.Y.Z`) matches the version in `mix.exs`, otherwise, precompiled binaries might not align correctly.</strong>

2. **Go to GitHub → Releases → Create New Release**

   - Use `vX.Y.Z` as the tag.
   - Copy the corresponding section from CHANGELOG.md as the release notes.

This triggers the `release.yml` GitHub Action, which:

- ✅ Builds precompiled NIFs.
- ✅ Uploads them to GitHub Releases.
- ✅ Makes them available for `RustlerPrecompiled`.

## **4️⃣  Generate & Include Checksum File**

**After the GitHub release is live and the CI has built the precompiled NIFs**, you need to generate the checksum file:

```sh
mix rustler_precompiled.download Exstatic.Native --all --print
```

This pulls the NIF binaries from the latest GitHub release and uses them to generate a `checksum-Elixir.Exstatic.Native.exs` file. 

Run the following command to verify the package contents before publishing:

```sh
mix hex.build --unpack
```

You should see `checksum-Elixir.Exstatic.Native.exs` included in th list of files. Don't check the checksum file into version control.

## **5️⃣  Publish to Hex.pm**

Once the GitHub release is live and the checksum file is included, publish the package to Hex.pm:

```sh
mix hex.user auth   # Authenticate if not already logged in
mix hex.publish     # Publish the package
```

### Important Notes:
- You **must have write access** to Zappi's Hex registry to publish (ask Brendon if you don't).
- **Ensure you are on the `main` branch**, and it matches `origin/main`, as `mix hex.publish` publishes from your **local copy**, not GitHub.
