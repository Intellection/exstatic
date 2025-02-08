# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [v0.1.1] - 2024-02-07

### Added

- **RustlerPrecompiled Integration:** 
  - Updated `Exstatic.Native` to use RustlerPrecompiled instead of requiring users to build the Rust code themselves.
  - Precompiled NIFs are downloaded from GitHub Releases, reducing the need for local Rust dependencies.
  - Defined `nif_versions: ["2.16"]`.

- **GitHub Actions CI/CD for Precompiled NIF Builds (`release.yml`):** 
  - Builds NIFs for macOS & Linux (ARM and x86_64).
  - Uses [`philss/rustler-precompiled-action`](https://github.com/philss/rustler-precompiled-action) for cross-compilation and upload.
  - Automatically triggers on:
    - New GitHub tags (e.g., `v0.1.0`).
    - Main branch pushes.
    - PRs that modify native code or the `release.yml` file.
  - Uploads precompiled NIFs to GitHub Releases when a tag is pushed.

## [v0.1.0] - 2024-02-07

### Added
Initial Release: Introduced Exstatic, a statistical distribution library for Elixir with native Rust implementations.
