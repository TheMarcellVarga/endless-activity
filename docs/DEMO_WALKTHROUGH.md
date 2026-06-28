# Demo Walkthrough

## Purpose

This walkthrough defines the exact MVP demo path. Keep it updated as implementation progresses.

## Pre-Demo Setup

Before recording or presenting:
- install fresh build
- reset local history
- use the demo catalog
- verify simulator size
- verify no debug placeholders are visible

## Demo Script

1. Launch Endless Activity.
2. Land directly on Discover.
3. Show the first activity card.
4. Swipe right on a strong example.
5. Open Saved.
6. Show that the activity appears.
7. Open the saved activity detail.
8. Return to Discover.
9. Swipe left on a less relevant activity.
10. Open Preferences.
11. Set a filter, such as low energy or under 30 minutes.
12. Return to Discover.
13. Show that the deck updates.
14. Tap a card to open detail.
15. Show materials and steps.
16. Relaunch app.
17. Confirm saved state persists.

## What To Say

Short explanation:

"Endless Activity is a native iOS app for the moment when you are bored but do not know what to do. The core loop is intentionally simple: swipe right to save an idea, swipe left to skip it, and tune the feed by time, cost, energy, and setting. The MVP is local-first with a curated catalog, so it works instantly without accounts, location, or network setup."

## Screens To Capture

- Discover card.
- Swipe right feedback.
- Activity detail.
- Saved list.
- Preferences.
- Empty deck recovery.

## Verification Before Demo

Run:

```bash
xcodebuild -project EndlessActivity.xcodeproj -scheme EndlessActivity -destination 'platform=iOS Simulator,name=iPhone 17e,OS=26.5' test
```

Manual checks:
- right swipe saves
- left swipe skips
- saved persists
- filters change deck
- no placeholder copy remains
- Dynamic Type does not break core screens

## Verified Run

Verified on 2026-06-28 with Xcode 26.6 and the iPhone 17e simulator on iOS 26.5.

- launch opens Discover without onboarding
- swipe right saves and swipe left skips
- Saved reflects the saved activity and survives relaunch
- Preferences persist and reset independently from activity history
- activity details expose materials and steps
- standard-size captures show no placeholder copy or clipped controls

The automated suite exercises the interaction path. Haptic feel and spoken VoiceOver output remain device/manual checks before an App Store submission because the simulator cannot prove physical haptic output or listening quality.
