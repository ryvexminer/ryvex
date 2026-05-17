# Changelog

## v1.1.0 (2026-05-16)

### New algorithms
- **Autolykos2 (ERG)** — full GPU implementation with auto-detection of pool Stratum variants and disk DAG cache for fast epoch transitions.
- **FishHash (IronFish)** — full GPU implementation, body-based Stratum protocol.

### Performance
- KawPoW: kernel tuning aligned with industry-standard patterns for competitive hashrate.
- Autolykos2 and FishHash: cp.async prefetch optimizations on SM 8.0+ for memory-bound mining loops.
- Disk DAG cache maintains a high mining duty cycle on coins with frequent epoch transitions, delivering strong effective hashrate in real-world pool conditions.

### Features
- **Web dashboard** standalone (port 8081):
  - 3 GPU view modes (Detailed / Compact / Table / Auto)
  - Lifetime records, share notifications, theme toggle, latency sparkline, CSV export
  - Effective HR, pool latency, session earnings, luck tier coloring
  - Toasts, next-share ETA, stale share detection, DAG regen banner
- Session economics via `/api/stats`: revenue, electricity cost, net profit.
- Multi-coin per-pool configuration (`coin` + `api_url` override).
- Multi-epoch DAG with automatic regen and disk caching.

### Stability & fixes
- Connection robustness: 5s timeout on side-channel connect prevents mining loop suspension.
- Watchdog restart rebuilds dataset after GPU context reinit.
- Autolykos2 share target uses pool boundary (params[6]).
- FishHash burst ranges disjoint across kernel launches.
- Display normalizes Autolykos2 + FishHash pool difficulty.
- Stratum latency measurement: keyed map for concurrent submits.
- Pool diff banner shows effective minimum share difficulty.

### Compatibility
- Nvidia GPUs (Pascal through Ada/Blackwell, sm_61 to sm_120).
- AMD support is in progress and not enabled in this release.

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
