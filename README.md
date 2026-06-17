# Ryvex - GPU Miner

Ryvex is a multi-algorithm miner for Ravencoin, Ergo, IronFish, Zano, FiroPoW, and Pearl coins, with NVIDIA CUDA mining. v1.15.0 adds Pearl (PRL) mining on NVIDIA Ampere GPUs (RTX 30 series), raises Pearl hashrate, and improves the live stats display.

## Ryvex in action

![Ryvex CLI mining session](docs/images/ryvex-in-action.png)

![Ryvex web dashboard](docs/images/ryvex-web-dashboard-full.png)

## Release focus in v1.15.0

- **Pearl (PRL) mining** - new `pearl` algorithm for NVIDIA Ampere GPUs (RTX 30 series), with a coin profile, pool preset, and the mandatory 1% dev fee over SSL.
- **Higher Pearl hashrate** - about 11% faster on RTX 30 series with a steadier wall rate.
- **Cleaner live stats** - per-share difficulty, luck, hashrate, and pool difficulty now show with correct auto-scaled units for high-difficulty algorithms.
- **One-command setup** - create a usable `config.toml` for RVN, ERG, IRON, ZANO, FIRO, KIIRO, or PRL from the CLI.
- **Generated launchers** - write matching Windows and Linux launch files for the selected coin and config.
- **Preflight endpoint diagnostics** - check config syntax, GPU discovery, pool URL shape, DNS, TCP reachability, TLS mode, and certificate validation before mining.
- **Protocol readiness checks** - after transport checks pass, preflight verifies Stratum subscribe, authorization, and first-job parsing without mining.
- **Pool compatibility evidence** - documented rows distinguish accepted-share evidence from pending validation.
- **Troubleshooting guide** - first-run pool, network, TLS, authorization, and support-report guidance is included in release docs.
- **Download verification** - release archives include checksum and binary signature verification guidance.
- **Web dashboard** - local status view at `http://localhost:8081`.

## Supported algorithms

| Coin | Setup value | Algorithm | Status |
|------|-------------|-----------|--------|
| Ravencoin | `RVN` | `kawpow` | CUDA mining |
| Ergo | `ERG` | `autolykos2` | CUDA mining |
| IronFish | `IRON` | `fishhash` | CUDA mining |
| Zano | `ZANO` | `progpowz` | CUDA mining |
| Firo | `FIRO` | `firopow` | CUDA route, live FIRO shares pending |
| Kiirocoin | `KIIRO` | `firopow` | CUDA mining, accepted-share validated |
| Pearl | `PRL` | `pearl` | CUDA mining, NVIDIA Ampere only (RTX 30 series) |

Production mining algorithms use a 1% dev fee. FiroPoW uses coin-specific dev-fee routes for FIRO and KIIRO.

Pearl requires an NVIDIA Ampere GPU (RTX 30 series). The other algorithms run across the supported NVIDIA range.

## Quick start

### 1. Extract the release

Extract the Windows `.zip` or Linux `.tar.gz` into a folder you can write to.

### 2. Run setup

Windows:

```powershell
.\ryvex.exe --first-run-setup --setup-coin RVN --setup-wallet YOUR_RVN_WALLET --setup-worker my-rig
```

Linux:

```bash
./ryvex --first-run-setup --setup-coin RVN --setup-wallet YOUR_RVN_WALLET --setup-worker my-rig
```

Use `--setup-coin ERG`, `--setup-coin IRON`, `--setup-coin ZANO`, `--setup-coin FIRO`, `--setup-coin KIIRO`, or `--setup-coin PRL` for the other coins. FiroPoW coin profiles are separated by coin so FIRO and KIIRO use their own pool and dev-fee routes. Setup writes `config.toml` and generated launch files for the selected coin. The setup output prints the exact paths.

### 3. Check the install before mining

Windows:

```powershell
.\ryvex.exe --preflight --config config.toml
```

Linux:

```bash
./ryvex --preflight --config config.toml
```

Preflight mode does not mine or submit shares. It validates the local setup, checks pool transport endpoints, then probes Stratum subscribe, authorization, and first-job parsing when transport is reachable.

### 4. Start Ryvex

Use the generated `.bat` file on Windows or `.sh` file on Linux. You can also start manually:

Windows:

```powershell
.\ryvex.exe --config config.toml
```

Linux:

```bash
./ryvex --config config.toml
```

## Manual config

Setup is the recommended path for a new install. If you prefer to edit `config.toml` yourself, use explicit Stratum prefixes:

```toml
worker_name = "my-rig"
algorithm = "kawpow"

[[pools]]
url = "stratum+ssl://pool.example.com:1234"
wallet = "YOUR_WALLET"
tls = true
```

Use `stratum+ssl://` for TLS endpoints and `stratum+tcp://` for plaintext endpoints.

## Preflight Diagnostics

`--preflight` is intended for first-run checks and support triage. It verifies:

- config parsing and required fields;
- selected algorithm and coin mapping;
- GPU discovery without launching mining kernels;
- pool endpoint URL shape, including explicit `stratum+tcp://` or `stratum+ssl://`, host, port, and no embedded wallet or query string;
- DNS resolution and TCP reachability for configured pool endpoints;
- TLS negotiation and certificate validation for TLS endpoints;
- Stratum protocol readiness after transport passes: subscribe confirmation, authorization response, and a parseable first job.

Plaintext TCP endpoints show TLS and certificate checks as not run. Protocol checks are skipped when URL, DNS, TCP, TLS, or certificate failures block transport.

Fix any reported issue, then run `--preflight` again before starting the miner. See [Troubleshooting](release/docs/troubleshooting.md) for first-run fixes and [Pool Compatibility Evidence](release/docs/pool-compatibility.md) for validation status by coin.

## Support report

If you need a support report, generate a redacted JSON file:

```powershell
.\ryvex.exe --support-report --support-report-output ryvex-support-report.json
```

The same report can be exported from the local dashboard at `http://localhost:8081`. The older `--diagnostics --diagnostics-output` command remains available as a compatibility alias.

Support reports include version, OS, GPU, driver, redacted config, config warnings, a privacy summary, and recent redacted logs. They do not include raw wallets, pool passwords, dashboard keys, API tokens, webhook URLs, or DAG/cache files.

## Web dashboard

Ryvex starts a local dashboard by default:

```text
http://localhost:8081
```

The dashboard shows device status, shares, pool status, session estimates, and recent events. To disable it, start Ryvex with `--dashboard-port 0`.

For remote access, set `bind_address = "0.0.0.0"` in the `[dashboard]` config section and protect the HTTP API with its configured token.

## CLI options

```text
ryvex [OPTIONS]

  -c, --config <CONFIG>       Config file [default: config.toml]
      --first-run-setup       Create config and launchers, then exit
      --setup-coin <COIN>     Coin for setup: RVN, ERG, IRON, ZANO, FIRO, KIIRO, or PRL
      --setup-wallet <WALLET>
                              Wallet address for setup
      --setup-pool <POOL>     Pool preset or full Stratum URL for setup
  -o, --pool <POOL>           Pool URL override
      --coin <COIN>           Coin symbol override for stats/API
  -p, --pass <PASSWORD>       Pool password [aliases: --password]
  -a, --algo <ALGO>           Mining algorithm: kawpow, autolykos2, fishhash, progpowz, firopow, or pearl
      --setup-worker <WORKER>
                              Worker name for setup
  -d, --devices <DEVICES>     GPUs to use, e.g. "0,2"
      --preflight             Validate setup without mining
      --support-report        Write a redacted support report JSON and exit
      --support-report-output <PATH>
                              Support report path
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
      --cpu                   Enable CPU worker
      --force-cpu             CPU-only mode
      --api-port <PORT>       HTTP API port [default: 8080]
      --no-api                Disable HTTP API
      --dashboard-port <P>    Web dashboard port [default: 8081, 0=off]
      --diagnostics           Compatibility alias for support report export
      --diagnostics-output <PATH>
                              Compatibility output path for --diagnostics
      --config-key <KEY>      Encryption key, or env RYVEX_CONFIG_KEY
      --encrypt-config        Encrypt wallets in config and exit
      --profile <NAME>        Load a mining profile
      --gpu-algo <GPU_ALGO>   Algorithm per GPU, e.g. "0:kawpow,1:progpowz"
  -h, --help                  Print help
  -V, --version               Print version
```

## Antivirus notice

Mining software can be flagged by antivirus heuristics because it uses GPU compute and Stratum networking. Verify Ryvex before running it or creating antivirus exclusions.

Each release includes archive checksums and binary signatures:

- `SHA256SUMS.txt` verifies downloaded archives.
- `ryvex.sig` verifies the extracted binary.
- `ryvex-ed25519-public-key.txt` contains the release public key.
- `verify-release-signature.py` verifies the binary signature.

Verify the archive before extracting it; do not hash the extracted binary for the archive checksum step.

Windows:

```powershell
Get-FileHash .\ryvex-vX.Y.Z-windows-x86_64.zip -Algorithm SHA256
```

Linux:

```bash
sha256sum ryvex-vX.Y.Z-linux-x86_64.tar.gz
```

HiveOS:

```bash
sha256sum ryvex-vX.Y.Z-hiveos.tar.gz
```

Compare the result with the matching archive line in `SHA256SUMS.txt`.

After extraction, verify the binary signature:

Windows:

```powershell
python .\verify-release-signature.py --binary .\ryvex.exe --signature .\ryvex.sig --public-key .\ryvex-ed25519-public-key.txt
```

Linux:

```bash
python3 ./verify-release-signature.py --binary ./ryvex --signature ./ryvex.sig --public-key ./ryvex-ed25519-public-key.txt
```

Expected result:

```text
OK: signature valid
```

Only add antivirus exclusions after checksum and signature verification pass.

Additional documentation is shipped in release archives under `docs/`, including download verification, release trust notes, antivirus guidance, troubleshooting, and pool compatibility evidence.

## Requirements

- NVIDIA GPU with CUDA support.
- NVIDIA driver 525.x or newer.
- Windows 10/11 x64 or Linux x64.
- Pearl (`pearl`) additionally requires an NVIDIA Ampere GPU (RTX 30 series).

## License

Proprietary. See [LICENSE](LICENSE) for details.
