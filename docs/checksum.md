# **Checksum in Exstatic**

The `checksum-Elixir.Exstatic.Native.exs` file is used to verify the integrity of the precompiled NIFs when users install Exstatic. This ensures that the correct binaries are downloaded and prevents tampering or corruption.

## **How the Checksum is Used**

### **Where is the Checksum File Used?**

#### **During Release Process**
1. The precompiled NIFs are built by **GitHub Actions** when a new release is created.
2. Once all precompiled binaries are available in the GitHub release, the checksum file must be **manually generated** using:
   ```sh
   mix rustler_precompiled.download Exstatic.Native --all --print
   ```
3. This command fetches all precompiled binaries and generates a `checksum-Elixir.Exstatic.Native.exs` file.
4. The generated checksum file is **included in the Hex package** but is **not committed to the repository**.

#### **When Users Install Exstatic**
1. RustlerPrecompiled automatically downloads the appropriate precompiled NIF.
2. The NIF's SHA-256 checksum is **verified** against the `checksum-Elixir.Exstatic.Native.exs` file.
3. If the checksum matches, the precompiled binary is used.
4. If the checksum does **not** match (e.g., due to corruption or missing binary), Rustler falls back to compiling the Rust code locally.

---

## **Example `checksum-Elixir.Exstatic.Native.exs` File**
Below is an example of what the `checksum-Elixir.Exstatic.Native.exs` file looks like for multiple architectures:

```elixir
%{
  "libexstatic-v0.1.1-nif-2.16-aarch64-apple-darwin.so.tar.gz" => "sha256:a2f7de6bae6f0562649f6e1c0a376978623f50a0be17aec92928355a534a906a",
  "libexstatic-v0.1.1-nif-2.16-x86_64-apple-darwin.so.tar.gz" => "sha256:b5c8d1e2f12a4747d03c4d92e913c8b9d5b8ea2c93a31492a123456789abcdef",
  "libexstatic-v0.1.1-nif-2.16-aarch64-unknown-linux-gnu.so.tar.gz" => "sha256:c3d7e5f8a1b2c34d56e7f890123abcde0987654321f4e56789abcdef01234567",
  "libexstatic-v0.1.1-nif-2.16-x86_64-unknown-linux-gnu.so.tar.gz" => "sha256:d4e5f6a7b8c9d01234567890abcdef1234567890abcdef1234567890abcdef12"
}
```

Each entry in the map corresponds to a precompiled NIF binary, with its respective SHA-256 checksum. These checksums ensure the integrity of the binaries when downloaded and used in different environments.

---

## **Important Notes**
- The checksum file **must be generated manually** after the precompiled NIFs are available in the GitHub release.
- The file must be **included in the Hex package** by ensuring `"checksum-*.exs"` is listed in the `files` field of `mix.exs`.
- You can verify that the checksum file is included before publishing with:
  ```sh
  mix hex.build --unpack
  ```
- If any **native Rust code changes**, you **must** regenerate the checksum file before the next release.
