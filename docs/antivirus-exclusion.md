# Antivirus Exclusion Guide

## Why is Ryvex flagged?

GPU miners can be flagged by antivirus heuristics. The detection pattern is:

- CUDA/GPU API calls (`cuDeviceGet`, `cuModuleLoad`)
- Stratum network protocol (mining pool communication)
- High GPU utilization

These behaviors can match "CoinMiner" heuristic signatures. A detection can be a false positive, but do not treat that label as proof that a file is safe.

Do not use an antivirus label alone to decide whether a file is safe. Each release includes archive checksums and binary signatures. Verify both before running the miner or creating antivirus exclusions.

Before creating an exclusion or restoring a quarantined file:

1. Check the archive against `SHA256SUMS.txt`.
2. Extract the archive.
3. Verify the extracted binary with `ryvex.sig`.

See `docs/verify-download.md` for the full verification flow.

> **Important:** Only add an exclusion for a Ryvex folder after the checksum and signature checks pass. If the file was already quarantined, restore it only after verification.

---

## Windows Defender

### Add exclusion

1. Open **Settings** > **Windows Security** > **Virus & threat protection**
2. Scroll to "Virus & threat protection settings" > click **Manage settings**
3. Scroll to "Exclusions" > click **Add or remove exclusions**
4. Click **Add an exclusion** > **Folder** > select the Ryvex folder

### Restore quarantined file

1. Open **Windows Security** > **Virus & threat protection**
2. Click **Protection history**
3. Find the quarantined Ryvex file > click **Restore**

> Defender may re-enable real-time protection after Windows Update - re-check exclusions after major updates.

---

## Kaspersky

### Add exclusion

1. Open Kaspersky > **Settings** > **Security settings**
2. Click **Threats and exclusions**
3. Click **Manage exclusions** > **Add**
4. Browse to the Ryvex folder

### Restore quarantined file

1. Open Kaspersky > **More Tools** > **Quarantine**
2. Select the Ryvex file > click **Recover**

---

## Avast

### Add exclusion

1. Click the **Menu** (top-right) > **Settings**
2. Go to **General** > **Exceptions**
3. Click **Add exception** > **File/Folder** tab
4. Browse to the Ryvex folder

### Restore quarantined file

1. Go to **Settings** > **General** > **Quarantine**
2. Select the Ryvex file > click **Restore and add exception**

---

## Bitdefender

### Add exclusion

1. Open Bitdefender > **Protection** > **Antivirus** > **Settings**
2. Click **Manage Exceptions**
3. Click **+Add an Exception** > browse to the Ryvex folder
4. Ensure the **Antivirus** toggle is ON

### Restore quarantined file

1. Go to **Protection** > **Quarantine**
2. Select the Ryvex file > click **Restore** (auto-whitelisted)

---

## Norton 360

### Add exclusion

1. Open Norton > **Settings** > **Antivirus** > **Scans and Risks**
2. Find "Items to Exclude from Scans" > click **Configure**
3. Click **Add Folders** > select the Ryvex folder

### Restore quarantined file

1. Go to **Security History** > **Quarantine**
2. Select the Ryvex file > click **Create exception & restore**

---

## ESET NOD32

### Add exclusion

1. Open ESET > **Setup** > **Advanced setup** (F5)
2. Go to **Detection Engine** > **Exclusions** > **Performance exclusions**
3. Click **Add** > browse to the Ryvex folder

### Restore quarantined file

1. Go to **Tools** > **Quarantine**
2. Select the Ryvex file > right-click > **Restore**

---

## Malwarebytes

### Add exclusion

1. Open Malwarebytes > **Settings** > **Allow List**
2. Click **Add** > **Allow a file or folder**
3. Browse to the Ryvex folder

### Restore quarantined file

1. Go to **Detection History** > **Quarantined items**
2. Select the Ryvex file > click **Restore**

---

## Verify download integrity

Each release includes `SHA256SUMS.txt`, `ryvex.sig`, `ryvex-ed25519-public-key.txt`, and `verify-release-signature.py`.

`SHA256SUMS.txt` hashes the downloaded archives, not the extracted binaries. Verify the archive before extracting it:

**Windows (PowerShell):**
```powershell
Get-FileHash .\ryvex-vX.Y.Z-windows-x86_64.zip -Algorithm SHA256
```

**Windows (CMD):**
```cmd
certutil -hashfile ryvex-vX.Y.Z-windows-x86_64.zip SHA256
```

**Linux:**
```bash
sha256sum ryvex-vX.Y.Z-linux-x86_64.tar.gz
```

**HiveOS:**
```bash
sha256sum ryvex-vX.Y.Z-hiveos.tar.gz
```

Compare the output with the matching archive line in `SHA256SUMS.txt` from the [release page](https://github.com/ryvexminer/ryvex/releases).

After extraction, verify the binary signature:

**Windows:**
```powershell
python .\verify-release-signature.py --binary .\ryvex.exe --signature .\ryvex.sig --public-key .\ryvex-ed25519-public-key.txt
```

**Linux:**
```bash
python3 ./verify-release-signature.py --binary ./ryvex --signature ./ryvex.sig --public-key ./ryvex-ed25519-public-key.txt
```

The expected result is `OK: signature valid`.
