# Ryvex v1.5.0

Ryvex is a multi-algorithm NVIDIA CUDA miner for Ravencoin, Ergo, and IronFish. v1.5.0 focuses on first-run setup, generated launchers, and preflight diagnostics.

## Quick start

### 1. Run setup

Windows:

```powershell
.\ryvex.exe --first-run-setup --setup-coin RVN --setup-wallet YOUR_RVN_WALLET --setup-worker my-rig
```

Linux:

```bash
./ryvex --first-run-setup --setup-coin RVN --setup-wallet YOUR_RVN_WALLET --setup-worker my-rig
```

Use `--setup-coin ERG` or `--setup-coin IRON` for the other supported coins. Setup creates `config.toml` and matching launch files for your platform.

### 2. Run preflight diagnostics

Windows:

```powershell
.\ryvex.exe --preflight --config config.toml
```

Linux:

```bash
./ryvex --preflight --config config.toml
```

Preflight mode checks the local setup before mining. It does not mine or submit shares.

### 3. Start mining

Use the generated `.bat` file on Windows or `.sh` file on Linux. You can also start directly:

Windows:

```powershell
.\ryvex.exe --config config.toml
```

Linux:

```bash
./ryvex --config config.toml
```

## Supported algorithms

| Coin | Setup value | Algorithm | Dev fee |
|------|-------------|-----------|---------|
| Ravencoin | `RVN` | `kawpow` | 1% |
| Ergo | `ERG` | `autolykos2` | 1% |
| IronFish | `IRON` | `fishhash` | 1% |

## Manual config

The setup command is recommended for first run. Manual configs should use explicit Stratum prefixes:

```toml
worker_name = "my-rig"
algorithm = "kawpow"

[[pools]]
url = "stratum+ssl://pool.example.com:1234"
wallet = "YOUR_WALLET"
tls = true
```

Use `stratum+ssl://` for TLS endpoints and `stratum+tcp://` for plaintext endpoints.

## Features

- **One-command setup** - writes a usable config for RVN, ERG, or IRON.
- **Generated launchers** - creates Windows and Linux launch files that match the generated config.
- **Preflight diagnostics** - validates config, GPU detection, and pool settings before mining.
- **Pool failover** - reconnects to backup pools when configured.
- **Stale share prevention** - detects new jobs before submitting outdated work.
- **Encrypted wallets** - AES-256-GCM wallet encryption for config files.
- **Support diagnostics** - redacted reports for support without raw wallets, passwords, API tokens, or webhook URLs.
- **Web dashboard** - local dashboard at `http://localhost:8081`.
- **HTTP API** - JSON API at `http://localhost:8080` for local monitoring and integration.

## CLI options

```text
Usage: ryvex [OPTIONS]

Options:
  -c, --config <CONFIG>       Config file [default: config.toml]
      --first-run-setup       Create config and launchers, then exit
      --setup-coin <COIN>     Coin for setup: RVN, ERG, or IRON
      --setup-wallet <WALLET>
                              Wallet address for setup
      --setup-pool <POOL>     Pool preset or full Stratum URL for setup
  -o, --pool <POOL>           Pool URL override
  -p, --pass <PASSWORD>       Pool password
  -a, --algo <ALGO>           Mining algorithm: kawpow, autolykos2, fishhash
      --setup-worker <WORKER>
                              Worker name for setup
  -d, --devices <DEVICES>     GPUs to use, e.g. "0,2"
      --preflight             Validate setup without mining
      --benchmark             Benchmark mode without a pool
      --benchmark-duration <S> Benchmark duration in seconds
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
      --config-key <KEY>      Encryption key, or env RYVEX_CONFIG_KEY
      --encrypt-config        Encrypt wallets in config and exit
      --profile <NAME>        Load a mining profile
      --gpu-algo <GPU_ALGO>   Algorithm per GPU, e.g. "0:kawpow,1:autolykos2"
  -h, --help                  Print help
  -V, --version               Print version
```

## Support diagnostics

Generate a redacted diagnostics report:

```powershell
.\ryvex.exe --diagnostics --diagnostics-output ryvex-diagnostics.json
```

You can also export the same report from the local web dashboard at `http://localhost:8081`.

## Verification

Each release includes SHA-256 checksums. Verify your download before first launch:

Windows:

```powershell
Get-FileHash .\ryvex.exe -Algorithm SHA256
```

Linux:

```bash
sha256sum ryvex
```

Compare the result with the checksum file included in the release.

## Requirements

- NVIDIA GPU with CUDA support.
- NVIDIA driver 525.x or newer.
- Windows 10/11 x64 or Linux x64.

## Support

- GitHub Issues: https://github.com/ryvexminer/ryvex/issues

## License

Proprietary software. See [LICENSE](LICENSE) for details.
