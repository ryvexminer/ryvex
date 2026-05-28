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
| Evidence dates | 2026-05-24 to 2026-05-27 |
| Evidence source | RVN accepted-share smoke tests, ZANO live validation, FIRO preflight-only validation, and KIIRO transport preflight |
| Ryvex binaries recorded | `ryvex 1.8.1` baseline rows; `ryvex 1.11.0` ZANO rows; `ryvex 1.14.1` FIRO/KIIRO rows |
| GPU | NVIDIA GeForce RTX 3070, 8 GB |
| NVIDIA driver | 596.21 |
| Power limit | 60% |
| Core offset | +0 MHz |
| Memory offset | +900 MHz |
| Worker names | `trust-*` and `ryvex-test` test workers |
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

## ZANO

| Pool preset | Endpoint | Evidence status | Notes |
| --- | --- | --- | --- |
| HeroMiners TCP | `stratum+tcp://de.zano.herominers.com:1110` | Accepted-share validation passed on 2026-05-25 | RTX 3070 live run: epoch 123 DAG ready in 4.4s, ~23-25 MH/s after warmup, 2 accepted, 0 rejected. |
| AlphaPool EU TCP | `stratum+tcp://eu1.alphapool.tech:5336` | Accepted-share validation passed on 2026-05-25 | RTX 3070 live run: epoch 123 DAG ready in 4.2s, 1 accepted, 0 rejected. |
| WoolyPooly TCP | `stratum+tcp://pool.woolypooly.com:3146` | Accepted-share validation passed on 2026-05-25 | RTX 3070 live run: epoch 123 DAG ready in 4.3s, 2 accepted, 0 rejected. |
| LuckyPool TCP | `stratum+tcp://zano.luckypool.io:8866` | Accepted-share validation passed on 2026-05-25 | RTX 3070 live run: epoch 123 DAG ready in 4.3s, 12 accepted, 0 rejected. |
| Cedric Crispin TCP | `stratum+tcp://zano.cedric-crispin.com:4424` | Accepted-share validation passed on 2026-05-25 with `x,d=64000000` | The release launcher pins the documented low-difficulty password so a single GPU can validate shares quickly. |

## FIRO

FIRO/FiroPoW has a separate v1.14.1 coin profile and dev-fee route. Current FIRO rows are preflight evidence, not accepted-share evidence.

| Pool preset | Endpoint | Evidence status | Notes |
| --- | --- | --- | --- |
| WoolyPooly TCP | `stratum+tcp://pool.woolypooly.com:3104` | Preflight validation passed on 2026-05-27 | DNS, TCP, Stratum authorization, and first-job parsing passed with `--preflight`; no mining and no share submission were performed. |

## KIIRO

KIIRO/FiroPoW has short accepted-share validation in v1.14.1. These rows are still short validation windows, not long-duration pool-side benchmarks.

| Pool preset | Endpoint | Evidence status | Notes |
| --- | --- | --- | --- |
| Rplant SSL | `stratum+ssl://stratum-eu.rplant.xyz:17098` | Accepted-share validation passed on 2026-05-27 | Short RTX 3070 live runs reached accepted shares with 0 rejected shares; use longer pool-side windows for benchmark comparisons. |
| Rplant TCP | `stratum+tcp://stratum-eu.rplant.xyz:7098` | Transport passed on 2026-05-27 | DNS and TCP reachability passed from the validation host. Prefer Rplant SSL unless testing TCP specifically. |
