# Release Trust

Ryvex release artifacts use two public verification layers.

## Checksum Layer

`SHA256SUMS.txt` lists the SHA-256 digest for each downloadable archive:

- Windows `.zip`;
- Linux `.tar.gz`;
- HiveOS `.tar.gz`.

This proves that the archive you downloaded matches the archive published on the GitHub release page.

## Signature Layer

Each packaged binary is shipped with `ryvex.sig`.

`ryvex.sig` is an Ed25519 signature over the SHA-256 digest of the extracted binary. The matching public key is shipped as `ryvex-ed25519-public-key.txt` and is also published in the repository under `docs/security/ryvex-ed25519-public-key.txt`.

Current Ryvex Ed25519 public key:

```text
4141a08cff3da838daf524e9bddba11f67192eab03b1069f4d5978ab861db9e3
```

Use `verify-release-signature.py` to verify the signature after extraction.

## What This Proves

- Matching archive checksum: the downloaded archive matches the release asset checksum.
- Valid binary signature: the extracted binary matches the Ryvex release signing key.
- Both checks together: the archive and the executable inside it match the release process.

## What This Does Not Prove

- It does not prove a mining pool will accept every configuration.
- It does not prove profitability.
- It does not replace antivirus scanning.
- It does not prove that a file downloaded from a third-party mirror is safe.

Download Ryvex from the official GitHub release page and verify before running.
