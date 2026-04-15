# Ryvex - High-Performance GPU Miner

NVIDIA CUDA miner with runtime-optimized kernels, desktop GUI, and enterprise-grade reliability.

## Supported Algorithms

| Algorithm | Coin | Dev Fee |
|-----------|------|---------|
| **KawPoW** | Ravencoin (RVN) | 1% |

*More algorithms coming in future releases (Autolykos2/ERG, FishHash/IRON).*

## Quick Start

1. Download the latest release from [Releases](https://github.com/ryvex-miner/ryvex/releases)
2. Extract the archive
3. Edit a launch script (e.g. `RVN-2miners.bat`) — replace `YOUR_RVN_WALLET` with your wallet address
4. Double-click the script to start mining

**Or use config.toml:**
```toml
algorithm = "kawpow"

[[pools]]
url = "stratum.ravenminer.com:13801"
wallet = "YOUR_RVN_WALLET"
tls = true
```
```bash
./ryvex --config config.toml
```

## Features

- **NVRTC Runtime Kernels** — Compiles optimized CUDA code per ProgPoW period (no stale kernels)
- **GPU-Aware Tuning** — Auto-detects your GPU architecture (Pascal to Blackwell) and adapts kernel parameters
- **DAG Disk Cache** — 3-4s reload instead of 16-21s generation on restarts
- **Double-Buffered Pipeline** — Overlapped kernel execution and result readback
- **Pool Failover** — Automatic reconnection with backup pool support
- **TLS/SSL** — Encrypted pool connections on all supported pools
- **Thermal Protection** — Auto-throttle and shutdown on overtemp
- **GPU Crash Recovery** — Automatic TDR detection, context reset, and DAG regeneration
- **Encrypted Wallets** — AES-256-GCM wallet encryption in config file
- **Web Dashboard** — Real-time hashrate, shares, power, and profit at `http://localhost:8081`

## CLI Options

```
Usage: ryvex [OPTIONS]

Options:
  --algo <ALGO>          Mining algorithm [default: kawpow]
  --pool <POOL>          Pool URL (stratum+ssl://host:port)
  --wallet <WALLET>      Wallet address
  --worker <WORKER>      Worker name [default: rig1]
  --password <PASS>      Pool password [default: x]
  --config <FILE>        Config file path [default: config.toml]
  --benchmark            Benchmark mode (60s, no pool)
  --api-port <PORT>      HTTP API port [default: 8080]
  --no-color             Disable colored output
  -h, --help             Print help
  -V, --version          Print version
```

## Validated Pools

| Pool | URL | Port (SSL) |
|------|-----|------------|
| **2miners** | rvn.2miners.com | 16060 |
| **Ravenminer** | stratum.ravenminer.com | 13801 |
| **WoolyPooly** | pool.woolypooly.com | 55556 |
| **Suprnova** | rvn.suprnova.cc | 6275 |
| **Nanopool** | rvn.nanopool.org | 12643 |
| **HeroMiners** | ravencoin.herominers.com | 10641 |

## Recommended Overclock (KawPoW)

| Setting | Range | Notes |
|---------|-------|-------|
| Memory | +800 to +1200 | Start low, increase gradually |
| Core | -100 to -200 | Reduces power without losing hashrate |
| Power Limit | 60-70% | Best efficiency sweet spot |

*Reduce memory OC if you get rejected shares. Every GPU is different.*

## Performance

Benchmarked on RTX 3070 (Zotac, driver 591.86):

| Config | Hashrate | Power | Efficiency |
|--------|----------|-------|------------|
| Stock | 25.5 MH/s | 219W | 117 kH/W |
| OC (+1200/-150/PL60%) | 23.2 MH/s | 131W | 179 kH/W |

*Performance varies by GPU model, driver, cooling, and OC settings.*

## Requirements

- NVIDIA GPU with CUDA support (Maxwell or newer, GTX 9xx / RTX series)
- NVIDIA driver 525.x or newer
- Windows 10/11 x64 or Linux x64

## Antivirus Notice

GPU miners are commonly flagged by antivirus software as "CoinMiner" due to heuristic detection (GPU usage + stratum protocol). This is a **false positive** — all GPU miners trigger this.

**To exclude Ryvex from your antivirus:**
- **Windows Defender:** Settings > Virus & threat protection > Exclusions > Add folder exclusion
- **Other AV:** Add the Ryvex folder to your exclusion list

See [Antivirus Exclusion Guide](docs/antivirus-exclusion.md) for detailed instructions per AV vendor.

## Verification

Each release includes SHA256 checksums. Verify your download:

**Windows (PowerShell):**
```powershell
Get-FileHash ryvex.exe -Algorithm SHA256
```

**Linux:**
```bash
sha256sum ryvex
```

Compare with `SHA256SUMS.txt` in the release.

## Support

- [GitHub Issues](https://github.com/ryvex-miner/ryvex/issues) — Bug reports and feature requests
- Discord — *Coming soon*

## License

Proprietary software. See [LICENSE](LICENSE) for details.
