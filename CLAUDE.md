# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

SyndiKit is a Swift package for decoding RSS feeds built on top of XMLCoder. It supports multiple feed formats (RSS 2.0, Atom, JSONFeed) and various extensions (iTunes podcasts, YouTube, WordPress). The architecture uses protocol-based abstractions to allow format-agnostic parsing.

## Build and Test Commands

### Building
```bash
swift build
```

### Running Tests
```bash
swift test
```

### Running a Single Test
```bash
swift test --filter <TestClassName>.<testMethodName>
```

Example:
```bash
swift test --filter RSSCodedTests.testPodcastDecode
```

### Linting
```bash
./Scripts/lint.sh
```

The linting script uses [mise](https://mise.jdx.dev) to run swift-format and SwiftLint. Tools are pinned in `.mise.toml`:
- `swift-format@604.0.0-prerelease-2025-12-17` for code formatting
- `SwiftLint@0.63.2` for linting rules
- `periphery@3.7.4` for unused code detection

Linting behavior is controlled by `LINT_MODE` environment variable:
- `NONE`: Skip linting entirely
- `STRICT`: Fail on any linting errors
- Default: Run linting with warnings

Set `FORMAT_ONLY=1` to skip linting checks and only apply formatting.

## Code Architecture

### Abstraction Layers

SyndiKit uses a three-tier abstraction system:

1. **Abstract Protocols** (`Common/`):
   - `Feedable`: Protocol defining common feed properties across all formats
   - `Entryable`: Protocol defining common entry/item properties
   - `EntryCategory`: Protocol for categorization across formats
   - `Author`, `Link`: Shared value types

2. **Format-Specific Types** (`Formats/Feeds/`):
   - `RSSFeed` / `RSSItem`: RSS 2.0 implementation
   - `AtomFeed` / `AtomEntry`: Atom format implementation
   - `JSONFeed` / `JSONItem`: JSONFeed implementation
   - Each format conforms to `Feedable` and `Entryable` protocols

3. **Media Extensions** (`Formats/Media/`):
   - `MediaContent` enum: Unified representation of podcasts and videos
   - `PodcastEpisode`: iTunes/podcast-specific metadata
   - `Video`: YouTube video metadata
   - `WordPressPost`: WordPress export data

### Decoding Pipeline

The `SynDecoder` class orchestrates feed decoding:

1. Detects format by examining first byte (JSON vs XML)
2. Attempts decoding with format-specific decoders (RSS, Atom, JSONFeed)
3. Returns unified `Feedable` instance regardless of source format
4. Throws `DecodingError` with detailed failure information if all attempts fail

Key decoding files:
- `Decoding/SynDecoder.swift`: Main decoder entry point
- `Decoding/DecodableFeed.swift`: Protocol for feed types that can be decoded
- `Decoding/DecoderSetup.swift`: Configures XMLDecoder and JSONDecoder with proper date strategies
- `Decoding/TypeDecoder.swift`: Type-specific decoding logic

### Property Organization in RSS Types

RSS types use property wrappers to organize complex metadata:

- `BasicProperties`: Core RSS fields (title, link, description, etc.)
- `ITunesProperties`: iTunes podcast metadata
- `PodcastProperties`: Podcast 2.0 namespace extensions
- `MediaProperties`: Media RSS namespace
- `WordPressProperties`: WordPress export namespace

These are combined in types like `RSSItem` which has both the properties and initializers split across multiple files:
- `RSSItem.swift`: Main definition
- `RSSItem+Init.swift`: Public initializers
- `RSSItem+InternalInit.swift`: Internal setup

### WordPress Support

WordPress export decoding involves multi-step processing:

1. Decode WordPress-extended RSS feed
2. Extract `WordPressPost` from items
3. Validate required fields via `WordPressPost+Validator.swift`
4. Process metadata via `WordPressPost+Processor.swift`
5. Access via `Entryable.media` property as `.podcast(.wordpress(post))`

WordPress-specific files are in `Formats/Media/WordPress/`.

### Swift Version Compatibility

The codebase maintains compatibility across Swift versions using conditional imports:

```swift
#if swift(<6.0)
  import Foundation
#else
  public import Foundation
#endif
```

This pattern appears throughout the codebase. When adding new files, follow this convention.

## Code Style Requirements

### SwiftLint Configuration

The project enforces strict linting rules (`.swiftlint.yml`):

- **Cyclomatic complexity**: Max 6 (warning), 9 (error)
- **File length**: Max 225 lines (warning), 550 lines (error)
- **Function body length**: Max 30 lines (warning), 50 lines (error)
- **Line length**: 90 characters (strict)
- **Function parameters**: Max 8

Split large files into extensions when approaching limits. See `RSSItem+*.swift` for examples.

### Naming Conventions

- `iTunesDuration`, `iTunesEpisode`, `iTunesOwner`, `iTunesImage`: Keep iTunes capitalization (excluded in SwiftLint)
- Type names use UpperCamelCase
- Use `MARK:` comments for organizing protocol conformances
- Explicit ACL required: All types need `public`, `internal`, or `private` access modifiers

### Code Organization

Within source files, follow this order (enforced by `file_types_order` rule):
1. Import statements
2. Type definitions
3. Extensions
4. Supporting types

Use indentation width of 2 spaces (configured in `.swiftlint.yml`).

## Testing

### Test Data Location

Feed samples are in `Data/`:
- `Data/XML/`: RSS and Atom feed samples
- `Data/JSON/`: JSONFeed samples
- `Data/WordPress/`: WordPress export samples
- `Data/OPML/`: OPML files (planned feature)

### Test Organization

Tests are organized by feature in `Tests/SyndiKitTests/`:
- `RSSCodedTests.swift`: RSS feed decoding
- `WordpressTests.swift`: WordPress export parsing
- `BlogTests.swift`: Blog/site collection processing
- `DecodingErrorTests.swift`: Error handling validation

Test utilities and extensions are in `Tests/SyndiKitTests/Extensions/`.

## Common Patterns

### Adding a New Feed Format

1. Create format-specific types in `Sources/SyndiKit/Formats/Feeds/<FormatName>/`
2. Conform types to `Feedable` and `Entryable` protocols
3. Implement `DecodableFeed` protocol
4. Add format to `SynDecoder.defaultTypes` array
5. Add test data to `Data/XML/` or `Data/JSON/`
6. Create tests in `Tests/SyndiKitTests/`

### Extending Media Support

1. Add media type to `MediaContent` enum in `Formats/Media/MediaContent.swift`
2. Create media-specific types in `Formats/Media/<MediaType>/`
3. Update format-specific implementations to populate `media` property
4. Add corresponding tests with sample data

### Date Handling

The decoder uses `DateFormatterDecoder` with multiple strategies:
- ISO8601 format for Atom feeds
- RFC822 format for RSS feeds
- Custom WordPress date format

Date decoding is configured in `Decoding/DecoderSetup.swift`.

## CI/CD

The main CI workflow (`.github/workflows/SyndiKit.yml`) runs on GitHub-hosted
runners, driven by the `brightdigit/swift-build@v1` action. A `configure` job
derives the matrix scope in three tiers: a small always-on set (Ubuntu / macOS /
lint), a `full-matrix` tier that expands the Ubuntu and macOS fan-out and adds
Android, and a `run-windows` tier that adds Windows.
Full/Windows run on `main`, semver branches, `workflow_dispatch`, and PRs into
`main` or semver (Windows excludes PRs into semver branches). In the
reduced/simple tier, Ubuntu runs noble × Swift 6.3/6.4 and macOS runs SPM only
(Swift 6.3 on Xcode 26.4 + Swift 6.4 on the Xcode 27 runner); the full tier adds
the older Ubuntu Swifts + jammy and the macOS platform/simulator legs.

- **Ubuntu**: one job folding stable Swift 5.10/6.0/6.1/6.2/6.3 (swift.org images)
  and nightly 6.4 (swiftlang nightly image) across noble + jammy; wasm and
  wasm-embedded run on 6.3 + 6.4 only (build-only), gated on the `ENABLE_WASM`
  repo variable
- **macOS**: SPM runs only Swift 6.3 (Xcode 26.4, macos-26) and Swift 6.4
  (Xcode 27, the arm64 `xcode-27` runner); the macOS/iOS/watchOS/tvOS/visionOS
  device legs run across Xcode 15.4/16.4/26.4 in the full tier
- **Windows**: Windows 2022 and 2025 with Swift 6.3-RELEASE and a 6.4 nightly snapshot
- **Android**: Swift 6.3 (API 28/36) and Swift 6.4 nightly snapshot (API 36)
- Codecov integration for coverage tracking
- mise-based STRICT linting (via the `setup-tools` composite action) runs after
  all platform builds complete

Supporting workflows:
- `swift-source-compat.yml`: release `swift build` across swift:5.10/6.0/6.1/6.2/6.3 + nightly-6.4 (source-compatibility suite)
- `check-unsafe-flags.yml`: fails the build if `unsafeFlags` appear in the package manifest
- `cleanup-caches.yml`: purges a branch's Actions caches when the branch is deleted
- `codeql.yml`: CodeQL security analysis
- `claude.yml` / `claude-code-review.yml`: Claude Code integration on issues and PRs

Commits with "ci skip" in the message skip CI runs (push events only).

## Documentation

Documentation is built with DocC from the `Sources/SyndiKit/SyndiKit.docc/` catalog and hosted on [Swift Package Index](https://swiftpackageindex.com/brightdigit/SyndiKit/documentation) (configured via `.spi.yml`). SPI builds and serves the DocC archive automatically — there is no local hosting step.

When adding public APIs, include DocC-style documentation comments with Topics sections.

## Memory & Corrections Convention

`.claude/agent-notes.md` is the canonical, versioned corrections log for this repository — an
append-only record of the maintainer's corrections and standing **always/never** directives.

- **Read `.claude/agent-notes.md` at the start of every work session, before doing any work.** It
  is the source of truth for *how* to work in this repo.
- **Whenever the maintainer makes a correction or gives an always/never instruction, append one
  line to `.claude/agent-notes.md` proactively (without being asked).** One line per directive,
  newest at the bottom. If a directive supersedes an earlier one, update or remove the stale line
  rather than leaving both.
