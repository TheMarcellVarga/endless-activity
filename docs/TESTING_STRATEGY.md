# Testing Strategy

## Goals

Tests should protect the core loop: catalog loads, deck ranks, swipes save/skip, preferences filter, and local state persists.

## Unit Tests

Catalog:
- bundled JSON decodes
- required fields present
- IDs unique
- enum values valid
- titles and summaries not empty

Filtering:
- duration filter
- cost filter
- energy filter
- setting filter
- social mode filter
- category filter

Ranking:
- saved activities excluded
- skipped activities excluded
- saved category boost works
- tag overlap boost works
- filters override boosts
- empty eligible set returns empty

Persistence:
- saved IDs persist
- skipped IDs persist
- preferences persist
- reset skipped works
- reset filters works

## UI Tests

Golden path:
- launch app
- see Discover card
- swipe right
- open Saved
- verify saved activity appears
- return to Discover
- swipe left
- open Preferences
- change a filter
- verify deck updates
- relaunch
- verify saved state remains

Detail path:
- tap card
- verify detail content
- save from detail
- remove from saved if implemented

Empty state:
- apply restrictive filters
- verify empty deck
- tap Relax Filters
- verify cards return

## Accessibility Tests

Manual checks:
- VoiceOver can read card summary.
- VoiceOver can save and skip without gestures.
- Dynamic Type large sizes remain usable.
- Buttons have clear labels.
- Color is not the only action indicator.

## Gesture Tests

Manual simulator checks:
- partial drag cancels cleanly
- committed drag advances deck
- fast flick works
- card does not get stuck offscreen
- haptic fires on commit only

## Visual Checks

Test on:
- small iPhone simulator
- large iPhone simulator
- light mode
- dark mode if supported
- large Dynamic Type

## Verification Command

Add exact command after the Xcode project exists:

```bash
xcodebuild -scheme EndlessActivity -destination 'platform=iOS Simulator,name=iPhone 16' test
```

## Completion Gate

Do not mark MVP complete until:
- unit tests pass
- UI golden path passes
- manual gesture checks pass
- accessibility basics pass
- unfinished surfaces audit is updated
