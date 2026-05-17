# Ryvex - High-Performance GPU Miner

NVIDIA CUDA miner with runtime-optimized kernels, built-in web dashboard, and enterprise-grade reliability.

## Supported Algorithms

| Algorithm | Coin | Dev Fee |
|-----------|------|---------|
| **KawPoW** | Ravencoin (RVN) | 1% |
| **Autolykos2** | Ergo (ERG) | 1% |
| **FishHash** | IronFish (IRON) | 1% |

## Quick Start

1. Download the latest release from [Releases](https://github.com/ryvexminer/ryvex/releases)
2. Extract the archive
3. Edit a launch script (e.g. `RVN-2miners.bat`) — replace `YOUR_RVN_WALLET` with your wallet address
4. Double-click the script to start mining

**Or use config.toml:**
```toml
algorithm = "kawpow"

[[pools]]
url = "rvn.2miners.com:16060"
wallet = "YOUR_RVN_WALLET"
tls = true
```
```bash
./ryvex --config config.toml
```

## Features

- **NVRTC Runtime Kernels** — Compiles optimized CUDA code per ProgPoW period with dual-kernel rolling cache (zero stalls on period changes)
- **Native SASS Compilation** — Fatbin with native SASS for Pascal, Turing, Ampere, Ada, and Blackwell GPUs
- **Fast DAG** — 20s cold generation, 2s from disk cache, real-time progress display during generation
- **GPU-Aware Tuning** — Auto-detects your GPU architecture (Pascal to Blackwell) and adapts kernel parameters
- **Double-Buffered Pipeline** — Overlapped kernel execution and result readback
- **NiceHash Support** — Full KawPoW_NiceHash_v1.0 protocol
- **HiveOS Ready** — Custom miner package included
- **Pool Failover** — Automatic reconnection with backup pool support
- **Stale Share Prevention** — Detects new blocks before submitting outdated shares
- **TLS/SSL** — Encrypted pool connections on all supported pools
- **Thermal Protection** — Auto-throttle and shutdown on overtemp
- **GPU Crash Recovery** — Automatic TDR detection, context reset, and DAG regeneration
- **Encrypted Wallets** — AES-256-GCM wallet encryption in config file
- **Web Dashboard** — Real-time hashrate, shares, GPU stats, and profit at `http://localhost:8081` (auto-starts, no setup)
- **HTTP API** — JSON API at `http://localhost:8080` for monitoring and integration

## CLI Options

```
Usage: ryvex [OPTIONS]

Options:
  -c, --config <CONFIG>       Config file [default: config.toml]
  -u, --wallet <WALLET>       Wallet address (overrides config)
  -o, --pool <POOL>           Pool URL (host:port or stratum+ssl://host:port)
  -p, --pass <PASSWORD>       Pool password (e.g. "d=1" for difficulty)
  -a, --algo <ALGO>           Mining algorithm [default: kawpow]
  -n, --worker <WORKER>       Worker name (visible on pool)
  -d, --devices <DEVICES>     GPUs to use, e.g. "0,2" [default: all]
      --benchmark             Benchmark mode (60s, no pool)
      --flush-dag             Delete DAG cache and regenerate
      --api-port <PORT>       HTTP API port [default: 8080]
      --no-api                Disable HTTP API
      --dashboard-port <P>    Web dashboard port [default: 8081, 0=off]
      --config-key <KEY>      Encryption key (or env RYVEX_CONFIG_KEY)
      --encrypt-config        Encrypt wallets in config and exit
      --profile <NAME>        Load a mining profile
      --gpu-algo <GPU_ALGO>   Algo per GPU, e.g. "0:kawpow,1:kawpow"
  -h, --help                  Print help
  -V, --version               Print version
```

## Validated Pools

| Pool | URL | TCP Port | SSL Port |
|------|-----|----------|----------|
| **2Miners** | rvn.2miners.com | 15555 | 16060 |
| **Ravenminer** | stratum.ravenminer.com | 13801 | 13838 |
| **HeroMiners** | ravencoin.herominers.com | 10640 | 10641 |
| **WoolyPooly** | pool.woolypooly.com | 55555 | 55556 |
| **Suprnova** | rvn.suprnova.cc | 6275 | 6275 |
| **Nanopool** | rvn.nanopool.org | 12641 | 12643 |

Set `tls = true` in config.toml when using an SSL port, `tls = false` for TCP.

## Recommended Overclock (KawPoW)

| Setting | Range | Notes |
|---------|-------|-------|
| Memory | +800 to +1000 | Start low, increase gradually |
| Core | -100 to -200 | Reduces power without losing hashrate |
| Power Limit | 60-70% | Best efficiency sweet spot |

*Reduce memory OC if you get rejected shares. Every GPU is different.*

## Performance

Benchmarked on RTX 3070 (OC +950/-150/PL60%, driver 596.21, ravenminer SSL):

| Metric | Ryvex | Leading Alternative |
|--------|-------|---------------------|
| Hashrate | 23.7 MH/s | 23.9 MH/s |
| Power | 131W | 131W |
| Efficiency | 181 kH/W | 182 kH/W |
| DAG (cold) | 20s | 18s |
| DAG (cached) | **2s** | 18s |
| Pool latency | 33ms | 35ms |
| Share rate | 100% (0 rejected) | 98% |

*Performance varies by GPU model, driver, cooling, and OC settings.*

## Requirements

- NVIDIA GPU with CUDA support (GTX 9xx through RTX 50xx)
  - Native SASS: Pascal (GTX 10xx), Turing (RTX 20xx), Ampere (RTX 30xx), Ada (RTX 40xx), Blackwell (RTX 50xx)
  - PTX JIT fallback: Maxwell (GTX 9xx) and future architectures
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

- [GitHub Issues](https://github.com/ryvexminer/ryvex/issues) — Bug reports and feature requests

## License

Proprietary software. See [LICENSE](LICENSE) for details.
