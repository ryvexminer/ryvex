# RVN/KawPoW Benchmark Evidence

This page records one reproducible RVN/KawPoW validation run from the last public benchmark baseline. It is not a profitability promise and it is not a claim about every GPU or pool.

## Test Setup

| Field | Value |
| --- | --- |
| Ryvex binary recorded | `ryvex 1.9.0` |
| Date | 2026-05-24 |
| Algorithm | KawPoW |
| Coin | RVN |
| Mode | Benchmark mode, no pool |
| GPU | NVIDIA GeForce RTX 3070, 8 GB |
| NVIDIA driver | 596.21 |
| Power limit | 60% |
| Temperature limit | 70 C |
| Core offset | +0 MHz |
| Memory offset | +900 MHz |
| Fan setting | 65% |

## Command

```powershell
target\release\ryvex.exe --benchmark --benchmark-duration 120 --benchmark-json target\codex-tmp\v190-release\kawpow-benchmark-120s.json --algo kawpow --config config.toml --no-api --dashboard-port 0 --log-console-level info
```

The config file provided the local wallet and normal miner defaults. Benchmark mode did not submit pool shares.

## Result

| Metric | Value |
| --- | ---: |
| Requested benchmark duration | 120 s |
| Mining duration | 119.105 s |
| Total elapsed duration | 141.276 s |
| DAG epoch | 588 |
| DAG generation time | 21.103 s |
| DAG verification | OK, 50 samples |
| Average mining hashrate | 24.764 MH/s |
| End-of-run hashrate | 24.653 MH/s |
| Average power | 131 W |
| Average efficiency | 189.0 kH/W |
| End-of-run GPU temperature | 65 C |
| Warnings in JSON report | 0 |

## Notes

- The session average including DAG time was lower than the mining-only average. Use the mining-only average for steady-state comparison.
- Share counts are not meaningful in benchmark mode because no pool was used.
- Different drivers, cards, cooling, power limits, and memory clocks can produce different results.
- Public comparison should use reproducible settings, not lucky share count.
- New benchmark claims should use a fresh run from the release binary being announced.
