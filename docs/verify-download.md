# Verify Your Download

Verify Ryvex before running it. Use both layers when possible:

1. Verify the downloaded archive against `SHA256SUMS.txt`.
2. Extract the archive and verify the binary signature with `ryvex.sig`.

Checksums confirm that the archive matches the file published on the release page. The binary signature confirms that the extracted `ryvex` or `ryvex.exe` file was signed with the Ryvex release key.

## 1. Verify the archive checksum

Download the archive for your platform and `SHA256SUMS.txt` from the same GitHub release.

Windows PowerShell:

```powershell
Get-FileHash .\ryvex-vX.Y.Z-windows-x86_64.zip -Algorithm SHA256
```

Linux:

```bash
sha256sum ryvex-vX.Y.Z-linux-x86_64.tar.gz
```

HiveOS package:

```bash
sha256sum ryvex-vX.Y.Z-hiveos.tar.gz
```

Compare the output with the matching line in `SHA256SUMS.txt`. The values must match exactly.

## 2. Extract the archive

After the checksum matches, extract the archive. The package includes:

- `ryvex.exe` or `ryvex`;
- `ryvex.sig`;
- `ryvex-ed25519-public-key.txt`;
- `verify-release-signature.py`.

## 3. Verify the binary signature

Windows PowerShell:

```powershell
python .\verify-release-signature.py --binary .\ryvex.exe --signature .\ryvex.sig --public-key .\ryvex-ed25519-public-key.txt
```

Linux:

```bash
python3 ./verify-release-signature.py --binary ./ryvex --signature ./ryvex.sig --public-key ./ryvex-ed25519-public-key.txt
```

HiveOS package extracted locally:

```bash
python3 ./verify-release-signature.py --binary ./ryvex/ryvex --signature ./ryvex/ryvex.sig --public-key ./ryvex/ryvex-ed25519-public-key.txt
```

Expected output:

```text
OK: signature valid
SHA256: ...
```

If Python reports that `cryptography` is missing, install it or use a Python environment that already includes it:

```bash
python -m pip install cryptography
```

The verification helper can also fall back to Node.js if the Python package is not installed.

## If Verification Fails

Do not run the binary if the checksum or signature check fails.

- Re-download the archive and `SHA256SUMS.txt` from the GitHub release page.
- Make sure you are checking the downloaded archive for the checksum step.
- Make sure you are checking the extracted binary for the signature step.
- Keep `ryvex.sig` next to the binary it came with.
