# Portfolio Case Study

## Title

Endless Activity: A Native iOS Swipe Deck For Finding Something To Do

## Summary

Endless Activity is a native iOS MVP that turns boredom into a simple discovery loop. Users swipe through curated activity ideas, save what sounds good, skip what does not, and tune the feed by practical constraints like time, cost, energy, and setting.

## Problem

When people are bored, they often do not have a clear search query. Existing options are either too broad, too social, too location-dependent, or too heavy for a quick moment of indecision.

## Product Decision

The MVP avoids accounts, location, AI generation, and live events. That keeps the first version fast, private, offline-capable, and focused on validating the interaction loop.

## Core Experience

- Discover card appears on launch.
- Swipe right saves.
- Swipe left skips.
- Preferences shape the deck.
- Saved list turns browsing into action.

## Technical Decisions

- SwiftUI for native interaction.
- Bundled JSON catalog for deterministic content.
- Local persistence for saved/skipped/preferences.
- Rule-based ranking for transparent behavior.
- XCTest and XCUITest for core loop coverage.

## Codex Skill Usage

The repo uses local Codex skills:

- `brandkit` for brand and case-study presentation.
- `imagegen-frontend-mobile` for native mobile screen direction.
- `design-taste-frontend` for UI polish review.
- `gpt-taste` only for high-end portfolio page direction if needed.
- `imagegen-frontend-web` only if a web case-study page is built.

## Tradeoffs

Chosen:
- local-first
- curated catalog
- solo MVP
- simple ranking

Deferred:
- social planning
- live events
- AI generation
- backend
- location-aware recommendations
- monetization

## What The Project Demonstrates

- Product scoping.
- Native iOS interaction design.
- Gesture-driven UX.
- Local data modeling.
- Testable ranking logic.
- Documentation discipline.
- AI-agent workflow design with repo-local skills.

## Final Case Study Checklist

Before using this publicly:
- add real screenshots
- add architecture diagram from implemented code
- add test results
- add final app icon
- add demo video or GIF
- update tradeoffs with actual implementation notes
