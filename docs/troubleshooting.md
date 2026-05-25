# Troubleshooting First-Run Issues

Use this guide when setup finishes but Ryvex cannot connect cleanly, receive work, or record accepted shares.

## Run Preflight First

Run preflight from the release directory before mining:

Windows:

```powershell
.\ryvex.exe --preflight --config config.toml
```

Linux:

```bash
./ryvex --preflight --config config.toml
```

Preflight checks config loading, GPU discovery, pool endpoint URL shape, DNS, TCP reachability, TLS negotiation, and certificate validation. It does not mine or submit shares. After transport checks pass, it probes Stratum subscribe, authorization, and first-job parsing. If transport checks fail first, the `protocol` line appears as not run.

Fix the first error shown, then run preflight again.

## Pool URL Problems

Use only the endpoint authority in `config.toml`:

```toml
[[pools]]
url = "stratum+ssl://pool.example.com:1234"
wallet = "YOUR_WALLET"
password = "x"
tls = true
ssl_verify = true
```

Valid pool URLs use lowercase `stratum+ssl://host:port` for TLS ports or `stratum+tcp://host:port` for plaintext TCP ports.

Do not put a wallet, worker name, password, path, or query string in the pool URL. Put those values in their dedicated config fields.

## DNS Failed

Preflight reports this as `dns: error`.

Check the pool hostname, spelling, internet access, DNS resolver, VPN, and local firewall. If the same pool publishes regional hostnames, try the region closest to the rig. Run preflight again after changing the hostname.

## Port Not Reachable

Preflight reports this as `tcp: error`.

Check that the hostname and port match the pool documentation. Make sure antivirus, firewall, router rules, VPN, ISP filtering, or datacenter egress rules are not blocking outbound TCP traffic. Try another documented port from the same pool if one is available.

## TLS Or Certificate Failed

Preflight reports TLS issues as `tls: error` and certificate issues as `certificate: error` or `certificate: warning`.

Use `stratum+ssl://` and `tls = true` only for TLS pool ports. Use `stratum+tcp://` and `tls = false` for plaintext ports.

For certificate errors, check the system clock, pool hostname, certificate chain, and `ssl_verify` setting. Keep `ssl_verify = true` unless the pool explicitly requires an untrusted certificate.

## Authorization Failed

Preflight can report authorization failures when the protocol check reaches the pool. Mining may still expose account, worker, or pool-side rules that are not visible during the short readiness probe.

Check the wallet format for the selected coin, worker name rules, pool password field, and account requirements on the pool. If you used first-run setup, confirm `--setup-coin` matches the wallet type and algorithm.

## No Jobs Received

Preflight waits only for a first parseable job during the protocol readiness probe. A clean preflight means the endpoint was reachable and the initial Stratum flow completed during the probe, not that continuous job delivery is guaranteed after startup.

If mining starts but no jobs arrive, check pool status, selected coin, algorithm, endpoint, TLS mode, and worker authorization. Try a documented backup endpoint for the same coin.

## No Accepted Shares Yet

Accepted shares require mining long enough to find work that meets the pool difficulty. A clean preflight does not guarantee an immediate accepted share.

If accepted shares do not appear after a reasonable test window, check rejected-share messages, wallet and worker settings, overclock stability, GPU temperature limits, and whether the pool assigned a high starting difficulty. Restore stock GPU memory settings when investigating share validity.

## Generate A Support Report

Generate a redacted support report after reproducing the issue:

Windows:

```powershell
.\ryvex.exe --support-report --support-report-output ryvex-support-report.json
```

Linux:

```bash
./ryvex --support-report --support-report-output ryvex-support-report.json
```

Support reports redact wallets, pool passwords, dashboard keys, API tokens, webhook URLs, and recent logs. Review the file before sharing it because paths, GPU names, worker names, and pool hosts may still identify your environment.
