# Environment

## Current State

The repository contains the complete Phase 0 through Phase 6 native SwiftUI
MVP: bundled catalog, deterministic ranking, local persistence, swipe deck,
Saved and Preferences flows, accessibility support, tests, screenshots, and
presentation documentation.

## Required Tools

Expected implementation environment:
- macOS with Xcode installed.
- Xcode current stable release.
- iOS Simulator.
- Swift current stable toolchain bundled with Xcode.

Last full simulator verification: 2026-06-28:

```text
Xcode: 26.6 (build 17F113)
Swift: Apple Swift version 6.3.2
iOS deployment target: 17.0
Small simulator: iPhone 17e, iOS 26.5
Large simulator: iPhone 17 Pro Max, iOS 26.5
Latest test result: 12 unit tests and 7 UI tests passed
```

## Repository Assets

Local skills:
- `.agents/skills/brandkit`
- `.agents/skills/design-taste-frontend`
- `.agents/skills/gpt-taste`
- `.agents/skills/imagegen-frontend-mobile`
- `.agents/skills/imagegen-frontend-web`

Skill lock:
- `skills-lock.json`

Docs:
- `README.md`
- `AGENTS.md`
- `docs/*`

## Planned Project Layout

Current project layout:

```text
EndlessActivity.xcodeproj
EndlessActivity/
  App/
  Models/
  Services/
  Views/
  Resources/
    activities.json
EndlessActivityTests/
EndlessActivityUITests/
```

Presentation models live beside their SwiftUI screens in `Views/`.

## Build Commands

```bash
xcodebuild -project EndlessActivity.xcodeproj -scheme EndlessActivity -destination 'platform=iOS Simulator,name=iPhone 17e,OS=26.5' build
xcodebuild -project EndlessActivity.xcodeproj -scheme EndlessActivity -destination 'platform=iOS Simulator,name=iPhone 17 Pro Max,OS=26.5' build
xcodebuild -project EndlessActivity.xcodeproj -scheme EndlessActivity -destination 'platform=iOS Simulator,name=iPhone 17e,OS=26.5' test
```

If `xcodebuild` reports that the active developer directory is Command Line Tools, select full Xcode first:

```bash
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
```

These commands passed on 2026-06-28 with Xcode 26.6. The current audit
environment has Swift 6.3.3 but no full Xcode installation, so `xcodebuild`
and `simctl` require Xcode to be installed before they can be rerun.

## Environment Variables

None required for v1.

Do not introduce API keys or secrets for the MVP.

## Network

The v1 app should work without network access after install because the catalog is bundled and persistence is local.

## Troubleshooting

If the app does not show cards:
- confirm catalog file is in the app bundle
- run catalog decode tests
- check filters are not excluding all activities
- reset skipped history

If saved activities do not persist:
- check persistence service tests
- confirm writes happen on save
- confirm app reload path reads stored state
