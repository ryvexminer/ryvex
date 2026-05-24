# RVN Pool Compatibility

This matrix records short RVN/KawPoW smoke tests with the release launcher endpoints. It means Ryvex connected, received work, mined, submitted at least one share, and the pool accepted it during the test window.

It is not a guarantee that every future pool configuration, pool region, or temporary pool state will behave the same way. Pool endpoints can change, so check the date.

## Test Setup

| Field | Value |
| --- | --- |
| Date | 2026-05-24 |
| Ryvex binary | `ryvex 1.8.1` baseline for v1.9.0 trust docs |
| Algorithm | KawPoW |
| Coin | RVN |
| GPU | NVIDIA GeForce RTX 3070, 8 GB |
| NVIDIA driver | 596.21 |
| Power limit | 60% |
| Core offset | +0 MHz |
| Memory offset | +900 MHz |
| Worker names | `trust-*` test workers |
| Pool password | `x` |

## Matrix

| Pool preset | Endpoint tested | Result | Accepted | Rejected | Stale | First accepted share latency |
| --- | --- | --- | ---: | ---: | ---: | ---: |
| Ravenminer SSL | `stratum+ssl://stratum.ravenminer.com:13838` | Pass | 17 | 0 | 0 | 36 ms |
| 2Miners SSL | `stratum+ssl://rvn.2miners.com:16060` | Pass | 1 | 0 | 0 | 27 ms |
| HeroMiners TCP | `stratum+tcp://ravencoin.herominers.com:10240` | Pass | 1 | 0 | 0 | 32 ms |
| Nanopool TCP | `stratum+tcp://rvn-eu1.nanopool.org:10400` | Pass | 1 | 0 | 0 | 70 ms |
| Suprnova TCP | `stratum+tcp://rvn.suprnova.cc:8888` | Pass | 1 | 0 | 0 | 47 ms |
| WoolyPooly TCP | `stratum+tcp://pool.woolypooly.com:55555` | Pass | 1 | 0 | 0 | 37 ms |

## Notes

- The v1.9.0 release changed public verification and release documentation only; no mining kernel, Stratum, or dev-fee logic changed after this pool baseline.
- 2Miners used a higher initial pool difficulty during this run, so it needed a longer window before the first accepted share.
- The matrix uses the public release launcher endpoints.
- Results should be refreshed before making new release claims if pool URLs, ports, Stratum behavior, or Ryvex pool code changes.
