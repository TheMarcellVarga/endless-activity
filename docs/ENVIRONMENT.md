# Environment

## Current State

The repository currently contains planning docs and local Codex skills. The SwiftUI project has not been scaffolded yet.

## Required Tools

Expected implementation environment:
- macOS with Xcode installed.
- Xcode current stable release.
- iOS Simulator.
- Swift current stable toolchain bundled with Xcode.

Record exact versions here after scaffold:

```text
Xcode:
Swift:
iOS deployment target:
Primary simulator:
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

Add exact commands after scaffold.

Expected:

```bash
xcodebuild -scheme EndlessActivity -destination 'platform=iOS Simulator,name=iPhone 16' build
xcodebuild -scheme EndlessActivity -destination 'platform=iOS Simulator,name=iPhone 16' test
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
