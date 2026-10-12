# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.1]
### 2026-10-12
### Changed
- Homepage now points to the repository root
- Removed the original author's donation links from the README

## [0.1.0]
### 2026-10-12
### Changed
- Published as `pwa_install_wasm`, a WASM-compatible fork of `pwa_install`. Import `package:pwa_install_wasm/pwa_install_wasm.dart`

## [0.0.7]
### 2026-10-12
### Added
- `onPromptAvailable` callback, fired when the install prompt becomes available
### Fixed
- `hasPrompt` stayed false when `beforeinstallprompt` fired after `setup()` (requires the updated index.html script)
- SDK constraint raised to Dart 3.3, the minimum for `dart:js_interop` with WASM

## [0.0.6]
### 2025-02-14
### Changed
- Migrate to dart:js_interop to support WASM

## [0.0.5]
### 2022-12-03
### Added
- Added instructions for adding screenshots to PWA prompt

## [0.0.4]
### 2022-11-30
### Added
- Error is thrown when PWA install prompt is called but not supported

## [0.0.3]
### 2022-11-15
### Added
- Added supported browsers link to readme
### Changed
- If the browser does not support the installation prompt, promptInstall_() won't do anything

## [0.0.2]
### 2022-11-04
### Changed
- Updated package README

## [0.0.1]
### 2022-11-04
### Added
- Initial pre-release

# Types of Changes
- Added
- Changed
- Deprecated
- Removed
- Fixed
- Security
