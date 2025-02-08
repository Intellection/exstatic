## How the Checksum is Used

The CI/CD pipeline generates the `checksum-Elixir.Exstatic.Native.exs` file and uses it to verify the integrity of the precompiled NIFs. Here's how it works:

### Where is the Checksum File Used?

#### During CI Builds
When the GitHub Actions workflow runs on a new release tag, it:
1. Compiles the Rust NIFs for different architectures.
2. Computes a SHA-256 checksum for each compiled binary.
3. Generates the `checksum-Elixir.Exstatic.Native.exs` file.
4. Uploads the binaries and the checksum file to GitHub Releases.

#### When Users Install Exstatic
When someone installs Exstatic, RustlerPrecompiled:
1. Downloads the appropriate precompiled NIF.
2. Verifies it against the `checksum-Elixir.Exstatic.Native.exs` file (which is in the release too).
3. If the checksum matches, the NIF is used.
4. If the checksum doesn't (e.g., due to corruption), compilation falls back to building the Rust code locally.

### Example `checksum-Elixir.Exstatic.Native.exs` File
Below is an example of what the `checksum-Elixir.Exstatic.Native.exs` file looks like for multiple architectures:

```elixir
%{
  "libexstatic-v0.1.1-nif-2.16-aarch64-apple-darwin.so.tar.gz" => "a2f7de6bae6f0562649f6e1c0a376978623f50a0be17aec92928355a534a906a",
  "libexstatic-v0.1.1-nif-2.16-x86_64-apple-darwin.so.tar.gz" => "b5c8d1e2f12a4747d03c4d92e913c8b9d5b8ea2c93a31492a123456789abcdef",
  "libexstatic-v0.1.1-nif-2.16-aarch64-unknown-linux-gnu.so.tar.gz" => "c3d7e5f8a1b2c34d56e7f890123abcde0987654321f4e56789abcdef01234567",
  "libexstatic-v0.1.1-nif-2.16-x86_64-unknown-linux-gnu.so.tar.gz" => "d4e5f6a7b8c9d01234567890abcdef1234567890abcdef1234567890abcdef12"
}
```

Each entry in the map corresponds to a precompiled NIF binary, with its respective SHA-256 checksum. These checksums ensure the integrity of the binaries when downloaded and used in different environments.
