# Endless Activity Workspace Plan

## Purpose

This is the master product and implementation plan for Endless Activity. It exists so a future Codex agent can build the project without re-deriving the product, technical architecture, or documentation standards.

The goal is a polished native iOS MVP: an endless activity deck for people who are bored and want a quick, realistic suggestion.

## Product Thesis

People often know they want to do something, but not what. Search is too intentional, social planning is too heavy, and generic lists become stale. Endless Activity should turn boredom into a low-friction loop: see an idea, react instantly, save what feels right, and keep moving.

## MVP Definition

The MVP proves the core loop:

1. Open the app.
2. See an activity card immediately.
3. Swipe right to save.
4. Swipe left to skip.
5. Tune preferences.
6. Open saved ideas.
7. Relaunch and keep saved state.

The MVP does not prove social coordination, monetization, AI generation, live event sourcing, or location-aware discovery.

## Audience

Primary audience:
- Individual users who are bored at home, in a city, between plans, or looking for something low-effort to do.

Secondary audience:
- Portfolio reviewers and recruiters evaluating native iOS product craft, documentation quality, and disciplined execution.

## Product Principles

- Immediate utility beats onboarding.
- Suggestions should be doable, not aspirational filler.
- The deck should feel playful without becoming a game that blocks action.
- Filters should reduce friction, not become a form.
- Local-first is a feature for v1: fast, private, and reliable.
- Polish matters because the app is interaction-led.

## Planned App Surfaces

Discover:
- Main swipe deck.
- Activity card with title, summary, duration, cost, energy, category, and setting.
- Detail sheet for materials, steps, and save action.

Saved:
- Saved activity list.
- Remove from saved.
- Open details.
- Optional completed marker if it stays local and simple.

Preferences:
- Duration.
- Cost.
- Energy level.
- Indoor/outdoor/either.
- Solo/friend/date/group.
- Categories.
- Reset history and reset filters.

## Technical Shape

Use a small native app architecture:

- Models: `Activity`, `ActivityPreferences`, `UserActivitySignal`.
- Catalog service: loads bundled JSON and validates decode.
- Ranking service: pure Swift rule-based scoring.
- Persistence service: saved/skipped IDs and preferences.
- View models: Discover, Saved, Preferences.
- SwiftUI views: tabs, deck, cards, detail sheet, filter controls, empty states.

## Codex Skills In The Workflow

Use local skills from `.agents/skills`:

- `brandkit`: Phase 1 brand identity and Phase 6 case-study presentation.
- `imagegen-frontend-mobile`: Phase 1 and Phase 4 screen concept references.
- `design-taste-frontend`: Phase 2, Phase 4, and Phase 5 UI quality review.
- `gpt-taste`: Phase 6 portfolio/marketing presentation only.
- `imagegen-frontend-web`: only if a website or landing page is added.

The app should not become web-first because a frontend skill exists. The implementation target remains native SwiftUI.

## Execution Phases

Phase 0: Documentation Control Plane.

Phase 1: Product, Brand, and Catalog Lock.

Phase 2: SwiftUI App Scaffold.

Phase 3: Activity Data, Persistence, and Ranking.

Phase 4: Discover Swipe Experience.

Phase 5: Saved, Preferences, and Empty States.

Phase 6: Testing, Polish, Demo, and Case Study.

## Acceptance Definition

The project is MVP-complete when:

- The app launches into a working deck.
- At least 50 curated activities are bundled.
- Right swipe saves an activity.
- Left swipe skips an activity.
- Saved state persists after relaunch.
- Preferences change the deck.
- Empty states are handled.
- Unit and UI tests cover the golden path.
- Docs and case study describe the build clearly.
