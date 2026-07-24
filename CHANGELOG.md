# Changelog

## v1.16.1 (2026-07-24)

### Fixed
- Config-less mining: `ryvex --algo <algo> --pool <url> --wallet <addr>` now runs directly without a `config.toml`, like every other miner. When all three flags are present, Ryvex builds an in-memory config from the CLI identity instead of refusing to start; nothing is written to disk and `--first-run-setup` remains the persistence path. The refusal is kept (with the CLI trio now mentioned) when the wallet is missing.

## v1.16.0 (2026-07-23)

### Added
- Pearl/NoisyGEMM multi-GPU work coordinator: independent workers now partition work leases instead of repeating the same window/salt sequence.
- Multi-GPU dev-fee nonce partition: user and dev-fee nonce streams are partitioned across GPU workers for 2/4/8 topologies with disjoint seeds, standard extranonce placement, and reconnect reseeding.
- ProgPowZ release-safe clean-room CUDA path: a provenance-safe replacement for the excluded legacy kernel, compiled only in release-safe builds, with a 16-lane warp-cooperative search that reduces SM86 register usage from 128 to 106 and stack from 3,120 B to 224 B.
- FiroPoW release-safe CUDA integration: the authorized clean kernel and harness are integrated into the release-safe build while the legacy kernel remains excluded. FiroPoW dev fee is 1%; live FiroPoW pool validation is pending.
- ProgPowZ shipped-module embedding: the normal CUDA module is loaded from embedded bytes rather than a filesystem path, with CUDA availability bound to the module cfg.
- FishHash queued-grid multiplier: checked host-side `FISHHASH_QUEUED_GRID_MULTIPLIER=16` setting after an offline A/B/A confirming +49.4% hashrate on SM86.
- Pearl reference-release freshness policy: H2H reference versions now bind exact release markers and asset checksums through package, preflight, controller, and A/B/A metadata.
- Generic H2H evidence rail: manifest v3 binds every campaign to an exact reference version, comparison basis, pool route, fee status, source archive, and A/B/A metadata across Ampere SM86, Ada SM89, and Blackwell SM120.
- Competitive evidence ledger: strict 288-cell matrix across 6 algorithms, 3 architectures, 1/2/4/8 GPU topologies, pool/solo, and stock/best-stable-same-power profiles.
- NoisyGEMM runtime alias normalization: `noisygemm`, `noisy-gemm`, `noisy_gemm` all resolve to the registered `pearl` key.

### Changed
- ProgPowZ clean search rewritten as warp-cooperative 16-lane layout with +330.7% hashrate and +240.8% efficiency improvement over the serial clean oracle on SM86.
- Autolykos2 CUDA hot path optimized with 32-bit wrapped index-window extraction and header32 word-reuse, narrowing the Ada SM89 gap to -3.6%.
- Pearl Ampere same-pool H2H validated: 2x RTX 3060 median 73.0 TH/s vs 70.3 TH/s reference (+3.9%), 1x RTX 3070 58.0 TH/s vs 54.0 TH/s (+7.5%).
- ProgPowZ Blackwell SM120 offline benchmark: 2.79 MH/s, 117.6 W, 23.7 kH/W on release-safe clean CUDA.

### Fixed
- Independent CLI worker registries no longer repeat the same Pearl window/salt sequence across multi-GPU workers.
- Dev-fee Stratum transport hardened: SSL-only for ZANO/ProgPowZ dev pools after audit S-1 found cleartext wallet leakage on TCP endpoints.
- FiroPoW dev-fee TLS routes corrected: two invalid FIRO strict-TLS routes replaced with publicly trusted rplant endpoints.
- Stratum client tries resolved pool addresses with short per-address timeouts so dead pool IPs do not consume the whole connection window.
- `stratum+tcp://` URLs now override stale `tls = true` config; `stratum+ssl://` forces TLS on regardless of the `tls` field.

## v1.15.1 (2026-06-18)

### Fixed
- Aligned GUI package and Tauri metadata with the v1.15.1 release line.
- Replaced the GUI seed config's EUR-specific electricity setting with the neutral USD default while preserving legacy config compatibility.
- Classified Pearl/LuckyPool stale-share `msg` responses as stale timing events and simplified the live CLI message.

### Release hygiene
- Added a Windows package privacy gate for local user paths, local account names, and PDB references in packaged binaries.
- Added third-party notices for release compliance.

## v1.15.0 (2026-06-16)

### Added
- **Pearl (PRL) mining** on NVIDIA Ampere GPUs (RTX 30 series), selectable with `-a pearl`. Includes the coin profile, pool preset, one-command setup, and the mandatory 1% dev fee over SSL.

### Improved
- Pearl hashrate raised about 11% on RTX 30 series, with a steadier wall rate.
- Hashrate and pool difficulty now auto-scale their units (up to TH/s and PH) for high-difficulty algorithms.

### Fixed
- Pearl: accepted-share difficulty and luck now display correctly with proper units, and the new-block line shows the coin tag without an unused epoch field.
- All dev-fee routes now use SSL/TLS so the dev wallet is never sent in cleartext.
- Zano: fixed duplicate-share rejections that could occur when the dev fee shared a pool with your own wallet.
- DAG-less algorithms (Pearl) no longer print spurious "Generating DAG" messages.

### Validation
- Fresh accepted-share runs verified for every public algorithm before this release.
- Security, protocol, and UX review of the release candidate before packaging.

## v1.14.2 (2026-05-28)

### Fixed
- Stop mining immediately when DAG or dataset preparation fails instead of continuing with invalid hashrate output.
- Surface the exact dataset preparation failure in the CLI and set the shared stop flag so deterministic VRAM failures do not restart repeatedly.

### Validation
- Added a regression guard that requires dataset preparation failures to stop the worker before hashing.
- Re-ran the all-algorithm public v1.14.1 regression matrix before this hotfix: KawPoW/RVN, Autolykos2/ERG, FishHash/IRON, ProgPowZ/ZANO, and FiroPoW/KIIRO passed local CUDA benchmark checks under the recorded PL60 profile.
- Verified FIRO epoch 650 validation on the RTX 3070 test machine now fails closed with an insufficient-VRAM message instead of displaying fake hashrate.

## v1.14.1 (2026-05-28)

### Fixed
- Enforced the standard 1% commercial dev fee on public FiroPoW mining routes.
- Added separate FIRO and KIIRO dev-fee wallets and pool bundles so FiroPoW does not run as a free public algorithm.
- Routed FiroPoW dev-fee selection by algorithm and coin profile so KIIRO uses its own route instead of the FIRO route.

### Validation
- Added regression tests that require FiroPoW dev-fee wallets, pool bundles, startup banner reporting, and coin-specific route selection for FIRO and KIIRO.
- Kept public performance wording conservative: KIIRO has short accepted-share validation, while FIRO remains a compatible validation profile pending longer FIRO pool evidence.

## v1.14.0 (2026-05-27)

### Release status
- Withdrawn and superseded by v1.14.1 before normal rollout. Do not use v1.14.0 packages.

### Added
- Added FIRO/FiroPoW as a controlled pool-test preparation path.
- Added a placeholder-only FIRO setup preset and launcher for the WoolyPooly TCP route that passed Ryvex preflight.
- Added FIRO job parsing, setup validation, API coin tags, and dashboard labels so preflight and capture runs report the intended coin and algorithm.
- Added FIRO Stratum capture and fixture guards for subscribe, authorize, difficulty, extranonce/session updates, and two notify messages without submitting work.

### Validation
- Added FIRO algorithm tests for metadata, registry exposure, bounded CPU reference hashing, result records, reference vectors, and CUDA guardrails.
- Added FIRO config, launcher, release-surface, and Stratum protocol tests that keep wallets placeholder-only and block overclaiming before live pool validation.
- Validated the packaged FIRO TCP preflight route through DNS, TCP, authorization, and first-job parsing without mining; additional endpoints remain internal transport/protocol candidates, not release launchers.

### Notes
- Superseded by v1.14.1.

## v1.13.0 (2026-05-26)

### Changed
- Centralized the pool miner identity string and send `Ryvex/<version>` on Stratum subscribe paths so compatible pools can display Ryvex by name.
- Send the same `Ryvex/<version>` miner agent as EthProxy login metadata for ProgPowZ/ZANO pools using pool-compatible top-level `agent` and `worker` fields, with an automatic retry using the historical two-parameter login if a pool rejects the extension.

### Validation
- Added Stratum protocol tests for the miner agent format on standard and NiceHash subscribe paths.
- Added EthProxy request and connection tests for the agent login shape and legacy-login fallback.
- Validated short login/getWork probes with the agent metadata on five configured ZANO pool endpoints without submitting shares, then matched the LuckyPool-recognized ZANO login metadata shape.
- Validated a live LuckyPool ZANO run after the release-version bump with 10 accepted shares, no rejected shares reported, and pool API recognition as `Ryvex/1.13.0`.

## v1.12.0 (unreleased)

### Changed
- Added a package-only release publisher mode so signed Windows, Linux, HiveOS archives and `SHA256SUMS.txt` can be regenerated locally without GitHub credentials or release creation.
- Added a documented `dist/` retention policy and a non-destructive checker for final release artifacts, checksums, verification assets, and publication evidence.
- Added a release package content checker for Windows, Linux, and HiveOS archives.
- Added a release readiness checker that combines retention, package contents, archive checksum verification, release-script syntax checks, and optional release-launcher tests into one verdict.
- Added a GitHub release asset checker that verifies remote asset names, sizes, upload state, download counts, and optional public download URL health.
- Updated the release workflow so future package, deploy, and monitor phases use the readiness and remote verification gates.
- Cleaned public workflow wording to keep market-miner comparisons generic and avoid profitability framing.
- Translated legacy French workflow notes to English in the public workflow.

### Validation
- Added a release-script regression test that keeps package-only completion before GitHub token lookup.
- Added a regression test that keeps the `dist/` retention checker non-destructive and aligned with the documented policy.
- Added a regression test that keeps the release package content checker aligned with platform package expectations.
- Added a regression test that keeps the release readiness checker wired to all local release gates.
- Added a regression test that keeps the GitHub release asset checker aligned with remote asset expectations.

## v1.11.0 (2026-05-26)

### Changed
- Added public ProgPowZ/Zano mining support through the `progpowz` algorithm.
- Added EthProxy/getWork login, work polling, and submit handling for Zano pools.
- Added ZANO first-run setup presets, config examples, release launchers, and dev-fee routing.
- Expanded ZANO release presets to HeroMiners, AlphaPool EU, WoolyPooly, LuckyPool, and Cedric Crispin.
- Added a per-period NVRTC ProgPowZ hot path; RTX 3070 validation improved from ~1.31 MH/s to ~23-25 MH/s live.
- Normalized `zano:` wallet URI prefixes before EthProxy pool login.
- Tightened release hygiene and deterministic parser checks around the new protocol path.

### Notes
- HeroMiners ZANO live validation passed on 2026-05-25 with 2 accepted shares and 0 rejected shares.

## v1.10.0 (2026-05-25)

### Added
- Added pool preflight diagnostics that report endpoint, TLS, authentication, and GPU readiness before mining starts.
- Added troubleshooting and compatibility notes for common first-run connection and launcher setup issues.

### Changed
- Refreshed bundled endpoint reliability for supported algorithms.
- Refreshed launcher and configuration defaults used by first-run setup.

### Fixed
- Improved endpoint selection reliability when multiple bundled connection modes are available.
- Made first-run diagnostics clearer when a pool, TLS, wallet, or driver setting needs attention.

### Notes
- No mining kernel changes.

## v1.9.0 (2026-05-24)

### Added
- Added public download verification documentation covering archive checksums and extracted binary signatures.
- Added the Ryvex Ed25519 public key as a public verification asset.
- Added a release signature verifier script for `ryvex.sig`.
- Added a public RVN/KawPoW benchmark pack and RVN pool compatibility matrix.

### Changed
- Updated antivirus guidance to verify downloads before creating exclusions.
- Updated release packaging to include and upload public verification assets.

### Notes
- No mining kernel changes.
- No dev-fee logic changes.

## v1.8.1 (2026-05-23)

### Fixed
- Aligned `Luck` with pool-style effort semantics: `100%` is expected work, lower is luckier, and higher means more work than expected.
- Kept accepted share `diff` visible without using unusually strong share difficulty to inflate the Luck value.
- Updated terminal, session summary, and local dashboard wording so Luck has one consistent meaning.

### Validation
- Live Ravenminer SSL validation passed for the corrected Luck display with accepted shares and zero rejects.

### Notes
- No mining kernel changes.
- No dev-fee logic changes.
- No privileged GPU overclocking or admin-only controls were added.

## v1.8.0 (2026-05-23)

### Added
- Added a runtime health verdict in `/api/stats` so Ryvex can explain whether mining is warming up, healthy, affected by pool display lag, or needs attention.
- Added matching health wording to the terminal session summary, local dashboard, and support reports.
- Added support-report health context to the dashboard diagnostics endpoint.

### Changed
- Pool-effective hashrate now uses pool-assigned accepted-share credit instead of lucky best-share difficulty.
- Stale timing responses such as `job not found` are treated as timing/stale events instead of actionable low-difficulty failures.
- Updated the GUI Ravenminer TCP preset to the current TCP endpoint while keeping the SSL preset on `13838`.

### Validation
- Live Ravenminer SSL validation passed with accepted shares, zero rejects, zero stale shares, no GPU restarts, and a final `healthy` verdict.

### Notes
- No mining kernel changes.
- No dev-fee logic changes.
- No privileged GPU overclocking or admin-only controls were added.

## v1.7.3 (2026-05-22)

### Fixed
- Added `--password <PASSWORD>` as a visible alias for the existing `--pass <PASSWORD>` pool password option.
- Added a preflight regression test so the alias remains accepted before mining starts and does not print the password value.

### Notes
- No mining kernel changes.
- No Stratum behavior changes.
- No dev-fee logic changes.

## v1.7.2 (2026-05-22)

### Fixed
- Fixed HiveOS packaging so `ryvex.sig` is generated from the exact Linux binary placed inside the HiveOS archive.
- Updated the release publisher to rebuild HiveOS after signing the canonical Linux binary, before checksums are generated.
- Added a regression test to prevent stale HiveOS signatures from being shipped again.

### Notes
- No mining kernel changes.
- No dev-fee logic changes.
- This hotfix replaces the v1.7.1 HiveOS package, whose signature did not match the packaged binary.

## v1.7.1 (2026-05-22)

### Fixed
- Fixed Linux and HiveOS release packaging validation so packaged binaries stay executable.
- Fixed HiveOS release packaging so the miner signature is included with the binary.
- Disabled the stale tag-triggered GitHub release workflow path that could publish incomplete no-CUDA archives.
- Clarified checksum instructions for archive-level SHA-256 verification.

### Notes
- No mining kernel changes.
- No dev-fee logic changes.
- This is a packaging and release-safety hotfix for v1.7.0.

## v1.7.0 (2026-05-21)

### Added
- Added `--support-report` and `--support-report-output <PATH>` as the friendly support export command.
- Added an explicit support-report schema and privacy summary to redacted troubleshooting reports.

### Changed
- Dashboard support export now downloads `ryvex-support-report-*.json` and labels the action as a support report.
- Kept `--diagnostics` and `--diagnostics-output` as compatibility aliases for existing scripts.
- Updated version metadata for the v1.7.0 support report release.

### Notes
- No mining kernel changes.
- No dev-fee logic changes.
- Support reports are still redacted and should be reviewed before sharing.

## v1.6.0 (2026-05-21)

### Added
- Added a shared pool catalog for setup presets and release launcher validation.
- Added catalog coverage tests so every release pool preset resolves through first-run setup.

### Changed
- Release launcher validation now uses the same pool matrix as first-run setup instead of duplicating pool URLs.
- Updated version metadata for the v1.6.0 pool reliability release.

### Notes
- No mining kernel changes.
- No dev-fee logic changes.
- Pool URLs are not changed in this release; v1.6.0 reduces future drift risk.

## v1.5.1 (2026-05-21)

### Fixed
- Hardened release publishing so prepared versions, changelogs, keys, docs, and archives are validated before GitHub upload.
- Fixed HiveOS stats version reporting so packaged releases do not report a stale miner version.
- Added release-script line-ending guards to prevent Bash scripts from breaking on Windows checkouts.

### Changed
- Release Docker builds now use Rust 1.94.1 and Cargo.lock.
- GitHub release uploads now fail closed, retry transient errors, and verify uploaded asset sizes.
- Publishing no longer mutates source version files during release.

### Notes
- No mining kernel changes.
- No protocol behavior changes.
- Follow-up security and release reproducibility items are tracked in `docs/audits/audit-9-v1.5.1-release-hardening.md`.

## v1.5.0 (2026-05-21)

### Added
- Added one-command first-run setup for RVN, ERG, and IRON.
- Added generated Windows and Linux launch files that match the generated config.
- Added preflight diagnostics to validate config, GPU detection, and pool settings before mining.
- Added first-run documentation for setup, preflight diagnostics, launchers, and redacted support reports.

### Changed
- Repositioned the release notes and README around usability instead of tuning or speed claims.
- Updated public examples to prefer setup-generated configs and launchers over manual edits.
- Kept manual config examples generic and prefix-explicit with `stratum+ssl://` or `stratum+tcp://`.

### Notes
- No mining kernel changes.
- No dev-fee logic changes.
- Preflight mode does not mine or submit shares.

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
- Added `--autotune-profile-create`, `--from-benchmark`, `--autotune-profile-list`, and `--autotune-profile`.
- Added live profile monitoring with rollback to baseline launch settings on sustained validation failure, CUDA faults, or GPU worker restarts.
- Added profile validation status to `/api/stats` under `autotune_profile`.

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
- Fixed startup ordering for an alternate KawPoW Stratum dialect when `mining.notify` arrives before `mining.set_difficulty`.
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
