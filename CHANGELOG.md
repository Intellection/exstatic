# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [v.0.2.0] - 2025-02-13

### Changed
- The way precompiled binaries are downloaded from Github releases.

## [v0.1.3] - 2025-02-10

### Fixed

- Includes the native source code in the hex release if folks want to build rust backend locally (can be done by setting `EXSTATIC_BUILD=true`


## [v0.1.2] - 2025-02-08

### Fixed

- **Enabled authenticated downloads from the Exstatic repo:**
  - Exstatic is a private, direct public URLs are not an option. In v0.1.2 we implement GitHub's private asset download flow, for retrieving the NIF binaries. 
  - Users must provide a Github Personal Access Token (PAT) (in `EXSTATIC_GITHUB_TOKEN` env var) with sufficient priveleges to download precompiled binaries.

## [v0.1.1] - 2025-02-07

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

## [v0.1.0] - 2025-02-07

### Added
Initial Release: Introduced Exstatic, a statistical distribution library for Elixir with native Rust implementations.

[Unreleased]: https://github.com/Intellection/exstatic/compare/v0.2.0...HEAD
[v0.2.0]: https://github.com/Intellection/exstatic/compare/v0.2.0...v0.1.3
[v0.1.3]: https://github.com/Intellection/exstatic/compare/v0.1.3...v0.1.2
[v0.1.2]: https://github.com/Intellection/exstatic/compare/v0.1.2...v0.1.1
[v0.1.1]: https://github.com/Intellection/exstatic/compare/v0.1.1...v0.1.0
[v0.1.0]: https://github.com/Intellection/exstatic/releases/tag/v0.1.0
