# Release Notes

## 1.0.0-alpha.1

First release after SyndiKit was de-vendored from the brightdigit.com monorepo into a standalone package on the Swift 6.4 toolchain.

### Library
* Updates from brightdigit.com (sync of the `brightdigit-com-260621` subrepo branch into the default branch) by @leogdion in https://github.com/brightdigit/SyndiKit/pull/129
* v1.0.0 (de-vendored into a standalone package on the Swift 6.4 toolchain with complete strict concurrency) by @leogdion in https://github.com/brightdigit/SyndiKit/pull/133

### Documentation
* Adopt MistKit README header; pin install to 1.0.0-alpha.1 by @leogdion in https://github.com/brightdigit/SyndiKit/pull/135
* Fix v1.0.0 CI badge: correct SyndiKit.yml casing by @leogdion in https://github.com/brightdigit/SyndiKit/pull/134
* Wave 0 review feedback: CI hygiene, docs & agent tooling (adds `RELEASE_NOTES.md` and normalizes `.spi.yml` for Swift Package Index documentation builds) by @leogdion in https://github.com/brightdigit/SyndiKit/pull/130

### Tooling & CI
* Wave 0 review feedback: CI hygiene, docs & agent tooling (`sersoft-gmbh/swift-coverage-action@v5`, `fail-fast: true` on all matrix legs, watchOS gate removed, visionOS leg added, dev container on `swiftlang/swift:nightly-6.4.x-noble`) by @leogdion in https://github.com/brightdigit/SyndiKit/pull/130
* ci(android): cap API level at 34 and cover Swift 6.3 + 6.4-nightly by @leogdion in https://github.com/brightdigit/SyndiKit/pull/131
* ci(android): disable on-device tests (Swift 6.4 ELF) — Android legs run build-only on the 6.4 snapshot pending brightdigit/SyndiKit#137 by @leogdion in https://github.com/brightdigit/SyndiKit/pull/138

**Full Changelog**: https://github.com/brightdigit/SyndiKit/compare/0.8.1...1.0.0-alpha.1
