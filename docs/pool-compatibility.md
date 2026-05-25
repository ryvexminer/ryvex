# Pool Compatibility Evidence

This document records pool compatibility evidence for the release setup endpoints. It separates accepted-share evidence from endpoints that are present in first-run setup but still need live validation.

## What This Means

An accepted-share row means Ryvex connected to the endpoint, received work, mined, submitted at least one share, and the pool accepted it during the recorded test window.

A pending row means the endpoint is included in setup presets or documentation, but no accepted-share validation result is recorded here yet.

## What This Does Not Mean

- It does not guarantee that every pool region, account setting, port, or temporary pool state will behave the same way.
- It does not prove future availability of any endpoint.
- It does not prove that pending rows will accept shares.
- It does not estimate earnings.
- It does not replace `--preflight`; run preflight on the machine and network that will mine.

## Test Setup

| Field | Value |
| --- | --- |
| Evidence date | 2026-05-24 |
| Evidence source | RVN accepted-share smoke tests from the release launcher baseline |
| Ryvex binary recorded | `ryvex 1.8.1` |
| GPU | NVIDIA GeForce RTX 3070, 8 GB |
| NVIDIA driver | 596.21 |
| Power limit | 60% |
| Core offset | +0 MHz |
| Memory offset | +900 MHz |
| Worker names | `trust-*` test workers |
| Pool password | `x` |

New release claims should use fresh accepted-share validation if pool URLs, ports, Stratum handling, submit formatting, or mining kernels changed after this baseline.

## RVN

| Pool preset | Endpoint tested | Evidence status | Accepted | Rejected | Stale | First accepted share latency |
| --- | --- | --- | ---: | ---: | ---: | ---: |
| Ravenminer SSL | `stratum+ssl://stratum.ravenminer.com:13838` | Accepted-share evidence recorded | 17 | 0 | 0 | 36 ms |
| 2Miners SSL | `stratum+ssl://rvn.2miners.com:16060` | Accepted-share evidence recorded | 1 | 0 | 0 | 27 ms |
| HeroMiners TCP | `stratum+tcp://ravencoin.herominers.com:10240` | Accepted-share evidence recorded | 1 | 0 | 0 | 32 ms |
| Nanopool TCP | `stratum+tcp://rvn-eu1.nanopool.org:10400` | Accepted-share evidence recorded | 1 | 0 | 0 | 70 ms |
| WoolyPooly TCP | `stratum+tcp://pool.woolypooly.com:55555` | Accepted-share evidence recorded | 1 | 0 | 0 | 37 ms |

## ERG

| Pool preset | Endpoint | Evidence status | Notes |
| --- | --- | --- | --- |
| 2Miners TCP | `stratum+tcp://erg.2miners.com:8888` | Pending live accepted-share validation | Run `--preflight` first, then complete a live validation window before claiming acceptance. |
| HeroMiners TCP | `stratum+tcp://de.ergo.herominers.com:1180` | Pending live accepted-share validation | Run `--preflight` first, then complete a live validation window before claiming acceptance. |
| Nanopool TCP | `stratum+tcp://ergo-eu1.nanopool.org:10600` | Pending live accepted-share validation | Run `--preflight` first, then complete a live validation window before claiming acceptance. |
| WoolyPooly TCP | `stratum+tcp://pool.woolypooly.com:3100` | Pending live accepted-share validation | Run `--preflight` first, then complete a live validation window before claiming acceptance. |

## IRON

| Pool preset | Endpoint | Evidence status | Notes |
| --- | --- | --- | --- |
| HeroMiners TCP | `stratum+tcp://ironfish.herominers.com:1145` | Pending live accepted-share validation | Run `--preflight` first, then complete a live validation window before claiming acceptance. |
| HeroMiners EU TCP | `stratum+tcp://de.ironfish.herominers.com:1145` | Pending live accepted-share validation | Run `--preflight` first, then complete a live validation window before claiming acceptance. |
