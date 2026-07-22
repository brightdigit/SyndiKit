# Release Notes

## Unreleased

Summary of brightdigit/SyndiKit PR #129 ("Sync subrepo branch brightdigit-com-260621", head `brightdigit-com-260621`).

### CI / Infrastructure

- Migrated macOS and Apple-platform CI legs from the self-hosted runner
  (`[self-hosted, macOS]`, `/Applications/Xcode-beta.app`) to the GitHub-hosted
  `xcode-27` runner (`/Applications/Xcode_27.0.app`).
- Added `download-platform: true` to the Apple-platform (iOS/watchOS/tvOS) build
  step so simulator runtimes are downloaded on the hosted runner.
- Updated workflow header comments to reflect the hosted-runner setup.

### Tooling

- Added a reusable composite action `.github/actions/setup-tools` that restores
  (or builds and saves) the mise tool cache and puts the binaries on PATH.
- Reworked the lint job to consume the new `setup-tools` action instead of
  calling `jdx/mise-action` directly.
