# Implementation Plan

## Summary

Build the app in controlled phases. Do not start with a complex backend or social model. The first implementation should prove the native iOS swipe loop, local catalog, local persistence, and polished saved/preferences flows.

## Phase 0: Documentation Control Plane

Create and maintain the planning docs:
- top-level repo docs
- roadmap
- Codex skill routing
- product and architecture docs
- testing and demo docs

Done when the documentation set exists and is linked from `README.md`.

## Phase 1: Product, Brand, and Catalog Lock

Use `brandkit` and `imagegen-frontend-mobile`.

Decide:
- final working name
- app tone
- icon direction
- core categories
- catalog schema
- activity quality bar
- first 50 activities

Update:
- `docs/PRODUCT_SPEC.md`
- `docs/BRAND_AND_MEDIA.md`
- `docs/ACTIVITY_CATALOG_GUIDE.md`
- `docs/DATA_MODEL.md`

## Phase 2: SwiftUI App Scaffold

Create:
- Xcode project
- SwiftUI app entry point
- tab navigation
- placeholder Discover, Saved, Preferences screens
- test targets
- asset catalog

Use `design-taste-frontend` as a review checklist after the first screens exist. Keep implementation native.

## Phase 3: Activity Data, Persistence, and Ranking

Status: complete on 2026-06-27.

Create:
- `Activity` model
- `ActivityPreferences` model
- `UserActivitySignal` model
- bundled JSON catalog
- catalog loader
- persistence service
- ranking service

Add tests for:
- catalog decode
- catalog validation
- filtering
- ranking
- saved/skipped state
- relaunch persistence

## Phase 4: Discover Swipe Experience

Status: complete on 2026-06-27.

Use `imagegen-frontend-mobile` before finalizing the card visual direction.

Create:
- activity card view
- deck view
- drag gesture handling
- save/skip actions
- detail sheet
- haptics
- accessible buttons

Test:
- swipe right saves
- swipe left skips
- tap opens detail
- deck advances correctly
- gesture cancellation returns card to center

Implemented:
- observable Discover presentation state backed by the catalog, ranking, and persistence services
- tactile three-card stack with threshold and projected-velocity gesture commits
- persistent save/skip actions, haptics, visible alternatives, VoiceOver custom actions, and Reduce Motion support
- native detail sheet and reset-skipped empty-deck recovery
- unit tests for deck mutation and refill policy plus UI tests for launch controls and detail presentation

## Phase 5: Saved, Preferences, and Empty States

Status: complete on 2026-06-27.

Create:
- saved list
- saved detail navigation
- remove saved action
- filter screen
- reset filters
- reset history
- empty deck state
- empty saved state

Use `design-taste-frontend` to review hierarchy, density, and clarity.

Implemented:
- persistence-backed Saved list with details, removal, and a useful empty state
- native preference controls for all locked practical constraints
- immediate filter persistence and Discover refresh on tab activation
- separate reset-filter and confirmed reset-history flows
- filtered and exhausted-deck recovery actions
- unit and UI coverage for Phase 5 presentation state and golden-path interactions

## Phase 6: Testing, Polish, Demo, and Case Study

Status: complete on 2026-06-28.

Use:
- `brandkit` for final visual presentation.
- `imagegen-frontend-mobile` for screenshot framing.
- `gpt-taste` only if a portfolio landing page is created.

Finish:
- unit tests
- UI tests
- accessibility checks
- simulator screenshots
- README update
- demo walkthrough
- portfolio case study
- unfinished surfaces audit

Completed:
- expanded UI coverage to include real swipe gestures and relaunch persistence
- captured four standard-size iPhone 17e simulator screenshots from XCUITest
- verified the large-device build on iPhone 17 Pro Max
- finalized the demo walkthrough, testing evidence, README, case study, and unfinished-surface audit

## Verification Commands

```bash
xcodebuild -project EndlessActivity.xcodeproj -scheme EndlessActivity -destination 'platform=iOS Simulator,name=iPhone 17e,OS=26.5' test
```

## Implementation Defaults

- Native SwiftUI.
- iOS 17+ unless changed.
- Local bundled JSON.
- Local persistence.
- No backend.
- No account.
- No required location.
- No network dependency.
