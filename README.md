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
url = "stratum+ssl://rvn.2miners.com:16060"
wallet = "YOUR_RVN_WALLET"
tls = true
```
```bash
./ryvex --config config.toml
```

## Ryvex in Action

![Ryvex mining RVN on an RTX 3070](docs/images/ryvex-in-action.png)

Example RVN/KawPoW session on an RTX 3070: accepted shares, live hashrate, power, efficiency, pool latency, and uptime.

## Web Dashboard

![Ryvex web dashboard full view](docs/images/ryvex-web-dashboard-full.png)

The built-in dashboard shows hashrate, shares, GPU stats, pool latency, session profit, and live mining status at `http://localhost:8081`.

## KawPoW Autotune Profiles

Run `--benchmark -a kawpow --autotune --benchmark-json autotune.json`, then save the selected result with `--autotune-profile-create NAME --from-benchmark autotune.json`. Apply it later with `--autotune-profile NAME`.

Autotune profiles adjust Ryvex kernel launch settings only. They do not change GPU clocks, fan speed, voltage, or power limit, and Ryvex rolls back to baseline launch settings if live validation fails.

## Features

- **NVRTC Runtime Kernels** — Compiles optimized CUDA code per ProgPoW period with dual-kernel rolling cache (zero stalls on period changes)
- **Native SASS Compilation** — Fatbin with native SASS for Pascal, Turing, Ampere, Ada, and Blackwell GPUs
- **Fast DAG** — 20s cold generation, 2s from disk cache, real-time progress display during generation
- **Benchmark Autotune** — Tests safe KawPoW grid candidates in benchmark mode and reports the selected launch settings
- **Applied Autotune Profiles** — Saves a benchmark result as a named KawPoW launch profile and applies it explicitly with live rollback
- **Double-Buffered Pipeline** — Overlapped kernel execution and result readback
- **NiceHash Support** — Full KawPoW_NiceHash_v1.0 protocol
- **HiveOS Ready** — Custom miner package included
- **Pool Failover** — Automatic reconnection with backup pool support
- **Stale Share Prevention** — Detects new blocks before submitting outdated shares
- **TLS/SSL** — Encrypted pool connections on all supported pools
- **Thermal Protection** — Auto-throttle and shutdown on overtemp
- **GPU Crash Recovery** — Automatic TDR detection, context reset, and DAG regeneration
- **Encrypted Wallets** — AES-256-GCM wallet encryption in config file
- **Support Diagnostics** — Redacted CLI, dashboard, and HTTP API JSON reports for support without exposing wallets, passwords, API tokens, or webhooks
- **Web Dashboard** — Real-time hashrate, shares, GPU stats, and profit at `http://localhost:8081` (auto-starts, no setup)
- **HTTP API** — JSON API at `http://localhost:8080` for monitoring and integration
- **API auth** — use `Authorization: Bearer <api_token>` or `X-API-Key: <api_token>` for remote HTTP API access

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
      --benchmark-duration <S> Benchmark duration in seconds [default: 60]
      --benchmark-json <PATH> Write a benchmark JSON report
      --autotune              Run KawPoW grid autotune during benchmark mode
      --autotune-profile-create <NAME>
                              Create a KawPoW autotune profile from a benchmark JSON report
      --from-benchmark <PATH> Benchmark JSON report used by --autotune-profile-create
      --autotune-profile-list List saved KawPoW autotune profiles
      --autotune-profile <NAME>
                              Apply a saved KawPoW autotune profile to live mining
      --flush-dag             Delete DAG cache and regenerate
      --api-port <PORT>       HTTP API port [default: 8080]
      --no-api                Disable HTTP API
      --dashboard-port <P>    Web dashboard port [default: 8081, 0=off]
      --diagnostics           Write a redacted diagnostics JSON report and exit
      --diagnostics-output <PATH>
                              Diagnostics report path
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
| **2Miners** | rvn.2miners.com | 6060 | 16060 |
| **Ravenminer** | stratum.ravenminer.com | 13801 | 13838 |
| **HeroMiners** | ravencoin.herominers.com | 10640 | 10641 |
| **WoolyPooly** | pool.woolypooly.com | 55555 | 55556 |
| **Suprnova** | rvn.suprnova.cc | 6275 | - |
| **Nanopool** | rvn-eu1.nanopool.org | 12641 | 12643 |

Set `tls = true` in config.toml when using an SSL port, `tls = false` for TCP.

## Support Diagnostics

If you need help, generate a redacted diagnostics report:

```bash
ryvex.exe --diagnostics --diagnostics-output ryvex-diagnostics.json
```

You can also export the same redacted report from the local web dashboard at `http://localhost:8081`.

The report includes version, OS, GPU, driver, redacted config, config warnings, and recent redacted logs. It does not include raw wallets, pool passwords, dashboard API keys, API tokens, webhook URLs, or raw DAG/cache files.

## Recommended Overclock (KawPoW)

| Setting | Range | Notes |
|---------|-------|-------|
| Memory | +800 to +900 | Start low, increase gradually; validate DAG generation after changes |
| Core | +0 or modest undervolt profile | Keep simple unless your own card proves a better stable profile |
| Power Limit | 60-70% | Best efficiency sweet spot |

*Reduce memory OC if you get rejected shares. Every GPU is different.*

## Performance

Validated on RTX 3070 (OC +900/+0/PL60%, driver 596.21, Ravenminer SSL):

| Metric | Result |
|--------|--------|
| Late 5m hashrate | 24.72-25.08 MH/s |
| Power | 131W |
| Efficiency | 194-195 kH/W |
| DAG (cold) | 20.74s |
| DAG (cached) | 1.5-2s |
| Pool latency | 35-45ms typical |
| Live validation | 172 accepted, 0 invalid, 1 stale job at block change |

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
