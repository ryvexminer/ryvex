# Antivirus Exclusion Guide

## Why is Ryvex flagged?

All GPU miners are flagged by antivirus heuristics. The detection pattern is:

- CUDA/GPU API calls (`cuDeviceGet`, `cuModuleLoad`)
- Stratum network protocol (mining pool communication)
- High GPU utilization

These behaviors match the "CoinMiner" heuristic signature. This is a **false positive** — it's the same detection that flags every major GPU miner.

No major miner signs their binaries. The industry standard is SHA-256 checksums, which are included in every Ryvex release (`SHA256SUMS.txt`).

> **Important:** Add the exclusion *before* running Ryvex. If the file was already quarantined, restore it first, then add the exclusion.

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

> Defender may re-enable real-time protection after Windows Update — re-check exclusions after major updates.

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

Each release includes `SHA256SUMS.txt`. Verify your download matches:

**Windows (PowerShell):**
```powershell
Get-FileHash ryvex.exe -Algorithm SHA256
```

**Windows (CMD):**
```cmd
certutil -hashfile ryvex.exe SHA256
```

**Linux:**
```bash
sha256sum ryvex
```

Compare the output with the hash in `SHA256SUMS.txt` from the [release page](https://github.com/ryvexminer/ryvex/releases).
