# Changelog

## v1.5.0 (2026-05-21)

### Added
- Added one-command first-run setup for RVN, ERG, and IRON.
- Added generated Windows and Linux launch files that match the generated config.
- Added dry-run diagnostics to validate config, GPU detection, output permissions, and launcher consistency before mining.
- Added first-run documentation for setup, dry-run diagnostics, launchers, and redacted support reports.

### Changed
- Repositioned the release notes and README around usability instead of tuning or speed claims.
- Updated public examples to prefer setup-generated configs and launchers over manual edits.
- Kept manual config examples generic and prefix-explicit with `stratum+ssl://` or `stratum+tcp://`.

### Notes
- No mining kernel changes.
- No dev-fee logic changes.
- Dry-run mode does not mine or submit shares.

## v1.4.1 (2026-05-21)

### Added
- Added release launch scripts for Autolykos2 and FishHash.
- Added an automated release-launcher test that blocks stale pool ports and prefix-less pool URLs.

### Changed
- Updated release packaging so every `.bat` and `.sh` launcher is included.
- Updated public pool examples to use explicit `stratum+tcp://` or `stratum+ssl://` prefixes.

### Fixed
- Fixed stale RVN launch script endpoints.
- Fixed the default RVN TCP config example port.

## v1.4.0 (2026-05-21)

### Added
- Added kernel-only KawPoW autotune profiles saved from benchmark JSON reports.
- Added CLI commands to create, list, and apply autotune profiles.
- Added live profile monitoring with rollback to baseline launch settings.
- Added profile validation status to `/api/stats`.

### Changed
- Kept default live mining behavior unchanged unless an autotune profile is explicitly selected.
- Documented that autotune profiles adjust Ryvex launch settings only.

## v1.3.2 (2026-05-21)

### Added
- Added a local web dashboard diagnostics export button.
- Added `/api/diagnostics` for authenticated HTTP API diagnostics export.

### Changed
- Reused the same redaction model for CLI, dashboard, and HTTP diagnostics.

## v1.3.1 (2026-05-21)

### Added
- Added `--diagnostics` to write a redacted JSON support report and exit.
- Added `--diagnostics-output <PATH>` for choosing the diagnostics report path.

### Changed
- Updated the default RVN TCP example port.

### Fixed
- Redacted wallets, pool passwords, dashboard API keys, API tokens, webhook URLs, and sensitive log lines from diagnostics output.

## v1.3.0 (2026-05-21)

### Added
- Added benchmark-mode KawPoW grid autotune with fixed live-mining defaults.
- Added benchmark JSON autotune reporting for tested candidates, scoring, and selected launch settings.

### Changed
- Kept live mining on fixed launch settings unless the user manually applies benchmark guidance.
- Updated validation guidance to emphasize stability checks before changing launch settings.

### Fixed
- Prevented autotune candidate changes from reusing stale CUDA ping-pong state.
- Preserved exact nonce accounting when applying benchmark launch plans.

## v1.2.0 (2026-05-20)

### Added
- Added benchmark JSON reports for machine-readable device, power, efficiency, and duration data.
- Added KawPoW tuning configuration foundations with stable defaults.

### Changed
- Hardened Stratum request tracking, authorization handling, stale-job draining, and submit response accounting.
- Improved power and efficiency accounting in CLI output and the HTTP API.
- Refined KawPoW NVRTC cache keys and launch planning while keeping stable compiler defaults.

### Fixed
- Kept KawPoW target uploads stream-local in the ping-pong CUDA path.
- Preserved stable KawPoW defaults after live validation.

## v1.1.2 (2026-05-19)

### Fixed
- Stabilized KawPoW CUDA recovery after watchdog or fatal context errors by rebuilding GPU state safely.
- Fixed a dev-fee side-channel polling path that could reduce live mining work after the dev-fee connection opened.
- Restored CUDA context binding before KawPoW NVRTC mining and DAG operations after async waits.
- Hardened DAG cache verification so bad disk cache data is deleted and regenerated automatically.

## v1.1.1 (2026-05-19)

### Fixed
- Hardened Stratum log redaction so wallet, password, token, and submit data are not leaked by raw protocol logs.
- Hardened pool target parsing for malformed or oversized Stratum targets.
- Fixed startup ordering for an alternate KawPoW Stratum dialect.
- Preserved raw FishHash pool targets during dev-fee mining fragments.
- Stabilized dev-fee fragment timing so the configured fee percentage is exact.
- Improved GUI benchmark parsing for ANSI-colored decimal power output.

### Changed
- Updated Ravencoin pool examples and launch scripts to current public ports.
- Improved CI and local English-only guard rails for shipped files.
- Avoided embedding HTTP API tokens in rendered dashboard HTML.

## v1.1.0 (2026-05-16)

### New algorithms
- Added Autolykos2 support for Ergo.
- Added FishHash support for IronFish.

### Features
- Added standalone web dashboard on port 8081.
- Added session economics via `/api/stats`.
- Added multi-coin per-pool configuration with `coin` and `api_url` overrides.
- Added multi-epoch DAG regeneration and disk caching.

### Stability and fixes
- Added connection timeout handling for side-channel connections.
- Rebuilt datasets after GPU context reinitialization.
- Corrected Autolykos2 share target handling.
- Kept FishHash burst ranges disjoint across kernel launches.
- Normalized Autolykos2 and FishHash pool difficulty display.
- Improved Stratum latency measurement for concurrent submits.
- Added effective minimum share difficulty display.

### Compatibility
- NVIDIA GPUs from Pascal through current CUDA architectures.
- AMD support remains in progress and is not enabled in this release.

## v1.0.1 (2026-04-18)

### Runtime
- Improved DAG startup and disk-cache handling.
- Added native SASS compilation for supported NVIDIA architectures.
- Added CUDA context caching.
- Added header and target upload caching.
- Added NVRTC dual-kernel rolling cache for period changes.
- Improved socket-level pool latency measurement.

### Stability
- Added graceful shutdown handling.
- Added circuit breaker recovery.
- Added DAG coordinator timeout handling for multi-GPU runs.
- Added stale-share detection before submission.
- Added cleanup of old DAG cache files.
- Added config validation for silence timeout bounds.

### Quality
- Refactored the CLI into focused modules.
- Added integration tests for Stratum, pool parsing, and config.
- Cleaned compiler warnings.
- Added DAG generation progress display.

### Fixes
- Deferred DAG cache save to shutdown.
- Prevented incomplete DAG cache files with atomic temp-file rename.
- Persisted light cache to disk.
- Restored session summary ANSI colors.
- Removed dead heap allocations in ping-pong readback.

## v1.0.0 (2026-04-16)

### Initial release
- Added KawPoW mining with NVRTC runtime-compiled kernels.
- Added GPU-aware kernel tuning by CUDA architecture.
- Added DAG disk cache.
- Added double-buffered kernel pipeline.
- Added pool failover with automatic reconnection.
- Added TLS/SSL pool connections.
- Added Stratum V1 with extranonce subscribe.
- Added 1% dev fee.
- Added thermal protection with configurable thresholds.
- Added watchdog recovery.
- Added GPU crash recovery.
- Added encrypted wallet storage.
- Added web dashboard.
- Added detailed session summary on exit.

### Requirements
- NVIDIA GPU with CUDA support.
- NVIDIA driver 525.x or newer.
- Windows 10/11 x64 or Linux x64.
