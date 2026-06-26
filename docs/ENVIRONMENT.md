# Environment

## Current State

The repository contains planning docs, local Codex skills, and the initial SwiftUI app scaffold.

## Required Tools

Expected implementation environment:
- macOS with Xcode installed.
- Xcode current stable release.
- iOS Simulator.
- Swift current stable toolchain bundled with Xcode.

Record exact versions here after scaffold:

```text
Xcode: unavailable via xcodebuild; active developer directory is /Library/Developer/CommandLineTools
Swift: Apple Swift version 6.3.2
iOS deployment target: 17.0
Primary simulator: pending full Xcode / simctl availability
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

Suggested layout after scaffold:

```text
EndlessActivity.xcodeproj
EndlessActivity/
  App/
  Models/
  Services/
  ViewModels/
  Views/
  Resources/
    activities.json
EndlessActivityTests/
EndlessActivityUITests/
```

Adjust to the actual Xcode structure after creation and update this doc.

## Build Commands

After full Xcode is installed and selected:

```bash
xcodebuild -project EndlessActivity.xcodeproj -scheme EndlessActivity -destination 'platform=iOS Simulator,name=iPhone 16' build
xcodebuild -project EndlessActivity.xcodeproj -scheme EndlessActivity -destination 'platform=iOS Simulator,name=iPhone 16' test
```

If `xcodebuild` reports that the active developer directory is Command Line Tools, select full Xcode first:

```bash
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
```

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
