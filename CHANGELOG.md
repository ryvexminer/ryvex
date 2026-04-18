# Changelog

## v1.0.1 (2026-04-18)

### Performance
- DAG generation 3x faster (72s → 20s cold, 2s cached)
- Native SASS compilation for Pascal, Turing, Ampere, Ada, and Blackwell GPUs (sm_61 to sm_100)
- CUDA context cache — eliminates redundant GPU context switches
- Header/target GPU upload cache — skip unchanged data
- NVRTC dual-kernel rolling cache — zero stalls on period changes
- Pool latency reduced from 44ms to 33ms (accurate socket-level measurement)

### Stability
- Graceful shutdown replaces abrupt exit (proper GPU fan/OC reset)
- Circuit breaker auto-recovery after 5 minutes
- DAG coordinator timeout prevents multi-GPU deadlocks
- Stale share detection before submission (drain new jobs after GPU batch)
- Auto-cleanup of old DAG cache files (prevents disk bloat)
- Config validation for silence timeout bounds

### Quality
- Refactored CLI from 4098-line monolith into 4 focused modules
- 115 new integration tests (stratum, pool parsing, config)
- Zero compiler warnings
- DAG generation progress display (real-time percentage)

### Fixes
- DAG cache save deferred to shutdown (no longer blocks mining start)
- Incomplete DAG cache files prevented via atomic .tmp → .bin rename
- Light cache persisted to disk (eliminates 2-3s CPU on warm start)
- Session summary ANSI colors restored
- Removed dead heap allocations in ping-pong readback

---

## v1.0.0 (2026-04-16)

**Initial release — KawPoW (Ravencoin) GPU miner**

### Features
- KawPoW mining with NVRTC runtime-compiled kernels (per-period optimization)
- GPU-aware kernel tuning: auto-detects architecture (Pascal to Blackwell)
- DAG disk cache: 3-4s reload vs 16-21s generation
- Double-buffered kernel pipeline: overlapped GPU execution and result readback
- Pool failover with automatic reconnection
- TLS/SSL support for all pool connections
- Stratum V1 with extranonce subscribe
- 1% dev fee (transparent, silent fragments)
- Thermal protection: auto-throttle on overtemp with configurable thresholds
- Hashrate watchdog: auto-restart on performance drops
- GPU crash recovery: automatic TDR detection and context reset
- Encrypted wallet storage (AES-256-GCM)
- Web dashboard with real-time stats (hashrate, shares, power, profit)
- Detailed session summary on exit

### Validated Pools
- 2miners (rvn.2miners.com)
- Ravenminer (stratum.ravenminer.com)
- WoolyPooly (pool.woolypooly.com)
- Suprnova (rvn.suprnova.cc)
- Nanopool (rvn.nanopool.org)
- HeroMiners (ravencoin.herominers.com)

### Performance (RTX 3070, stock clocks)
- 25.5 MH/s @ 219W (117 kH/W)
- 5x faster DAG generation with disk cache

### Requirements
- NVIDIA GPU with CUDA support (Maxwell or newer, SM 5.2+)
- NVIDIA driver 525.x or newer
- Windows 10/11 x64 or Linux x64
