# Master Execution Roadmap

## Purpose

This roadmap is the execution authority for Endless Activity. Future agents should consult it first, follow the phase order, and use the acceptance gates to decide whether a phase is complete.

The goal is not to build everything at once. The goal is to move through controlled phases until the project becomes a polished native iOS MVP with strong documentation and a credible portfolio story.

## Operating Model

- Start each task by naming the current roadmap phase.
- Name the Codex skill used for design, brand, mobile concepting, or presentation work.
- Do not skip phases unless the user explicitly changes the roadmap.
- If a request belongs to a later phase, record it as queued or update the roadmap.
- Each phase must produce visible artifacts: docs, code, tests, screenshots, or demo notes.
- Keep the product boundary fixed unless the user explicitly changes it.
- Every implementation task should name target files, acceptance criteria, and verification command.

## Skill Routing

Use repo-local skills from `.agents/skills`.

| Work Type | Primary Skill | Support Skill |
| --- | --- | --- |
| Brand identity, icon direction, visual world | `brandkit` | `imagegen-frontend-mobile` |
| Native iOS screen concepts | `imagegen-frontend-mobile` | `design-taste-frontend` |
| SwiftUI screen polish review | `design-taste-frontend` | `imagegen-frontend-mobile` |
| Motion-heavy marketing/case-study presentation | `gpt-taste` | `brandkit` |
| Website or portfolio landing page references | `imagegen-frontend-web` | `gpt-taste` |
| Data model, ranking, persistence, tests | No visual skill required | Use docs first |

## Timeline Overview

| Phase | Outcome |
| --- | --- |
| 0. Documentation Control Plane | Complete repo docs, agent rules, skill routing, source of truth. |
| 1. Product, Brand, and Catalog Lock | Product spec, visual direction, catalog taxonomy, demo content rules. |
| 2. SwiftUI App Scaffold | Native project, app shell, tabs, design tokens, placeholder screens. |
| 3. Activity Data, Persistence, and Ranking | Catalog loading, local storage, filtering, ranking, tests. |
| 4. Discover Swipe Experience | Swipe cards, gestures, details, haptics, deck state. |
| 5. Saved, Preferences, and Empty States | Saved list, filters, reset flows, accessibility, no-results states. |
| 6. Testing, Polish, Demo, and Case Study | Test pass, simulator checks, screenshots, docs updated, portfolio story. |

## Phase 0: Documentation Control Plane

Status: complete.

Primary docs:
- `README.md`
- `AGENTS.md`
- `EndlessActivityWorkspacePlan.md`
- `EndlessActivityMarkdownDocsPlan.md`
- `docs/MASTER_EXECUTION_ROADMAP.md`
- `docs/CODEX_SKILLS.md`

Deliverables:
- Source-of-truth doc order.
- Phase map.
- Codex skill routing.
- Product guardrails.
- Documentation map.
- No app code required yet.

Acceptance gate:
- All planned Markdown docs exist.
- `README.md` links the docs.
- `AGENTS.md` instructs future Codex agents to use roadmap phases and skills.
- `docs/CODEX_SKILLS.md` documents every local skill in `.agents/skills`.

## Phase 1: Product, Brand, and Catalog Lock

Status: complete.

Primary skills:
- `brandkit`
- `imagegen-frontend-mobile`

Deliverables:
- Final or working product name.
- Brand direction and tone.
- App icon concept direction.
- Activity catalog taxonomy.
- Minimum catalog size for MVP.
- Catalog quality rules.
- Demo activity set.

Acceptance gate:
- Product can be explained in one sentence.
- The v1 non-goals are explicit.
- Catalog fields are final enough to implement.
- Visual direction is specific enough to guide SwiftUI screens.

Phase 1 lock:
- Final working name: Endless Activity.
- One sentence: Endless Activity is a native iOS swipe deck for finding something realistic to do when you are bored.
- Visual direction: tactile stacked-card identity, off-white native iOS surfaces, ink text, coral save/action accent, green/blue/yellow category accents, subtle grain, no mascot, no purple AI gradient.
- App icon direction: stacked activity cards with a forward swipe/path cut.
- Catalog implementation target: at least 50 bundled JSON activities in Phase 3, using the schema in `docs/DATA_MODEL.md` and the starter set in `docs/ACTIVITY_CATALOG_GUIDE.md`.

## Phase 2: SwiftUI App Scaffold

Status: complete.

Primary skills:
- `design-taste-frontend` for review only.
- `imagegen-frontend-mobile` if screen concepts are needed.

Deliverables:
- Xcode project.
- SwiftUI app entry point.
- Discover, Saved, and Preferences tabs.
- Shared design tokens.
- Placeholder views that clearly mark unfinished behavior.
- Initial test target.

Acceptance gate:
- App builds in the simulator.
- Tabs render on small and large iPhones.
- Placeholder surfaces are tracked in `docs/UNFINISHED_SURFACES_AUDIT.md`.
- No fake final behavior is presented as complete.

Completion verification, 2026-06-27:
- Full Xcode 26.6 is selected at `/Applications/Xcode.app/Contents/Developer`.
- Simulator builds pass on iPhone 17e and iPhone 17 Pro Max with iOS 26.5.
- Unit and UI tests pass on the iPhone 17e simulator.
- Discover, Saved, and Preferences placeholders remain explicitly tracked in `docs/UNFINISHED_SURFACES_AUDIT.md` for later phases.

## Phase 3: Activity Data, Persistence, and Ranking

Status: complete.

Primary skill:
- No visual skill required.

Deliverables:
- Codable models.
- Bundled catalog JSON.
- Catalog loader.
- Local persistence service.
- Rule-based ranking service.
- Unit tests.

Acceptance gate:
- Catalog decodes deterministically.
- Saved/skipped/preference state persists after relaunch.
- Ranking and filtering tests pass.
- Bad catalog records fail validation in tests.

Completion verification, 2026-06-27:
- The bundled `activities.json` contains the locked 50 unique activities and passes catalog validation.
- Codable activity, preferences, and signal models compile under Swift 6.
- UserDefaults-backed saved, skipped, completed, and preference state survives store recreation.
- Filtering, exclusion, saved-category/tag boosts, seeded bucket ordering, reset behavior, and invalid catalog records are covered by passing tests.
- Verification: `xcodebuild -project EndlessActivity.xcodeproj -scheme EndlessActivity -destination 'platform=iOS Simulator,name=iPhone 17e,OS=26.5' test`.

## Phase 4: Discover Swipe Experience

Status: complete.

Primary skills:
- `imagegen-frontend-mobile`
- `design-taste-frontend`

Deliverables:
- Swipeable activity cards.
- Right save and left skip gestures.
- Tap-to-detail flow.
- Accessible save/skip alternatives.
- Haptic feedback.
- Deck refill/reset behavior.

Acceptance gate:
- Golden path works without onboarding.
- Gestures feel responsive.
- VoiceOver users can save and skip.
- Deck state does not corrupt catalog data.

Completion verification, 2026-06-27:
- Discover launches directly into a ranked, stacked activity deck with no onboarding.
- Right swipe saves, left swipe skips, partial drags spring back, and visible buttons provide equivalent actions.
- Save and skip persist locally, advance the deck, and leave the source catalog unchanged.
- Tapping a card opens a native detail sheet with metadata, materials, steps, safety guidance, and save action.
- Cards expose concise VoiceOver summaries and named Save, Skip, and Show details actions; Reduce Motion bypasses swipe-off animation.
- Empty deck recovery resets skipped ideas without clearing saved activities.
- Unit and UI tests pass on iPhone 17e, and visual checks pass on iPhone 17e, iPhone 17 Pro Max, and accessibility extra-extra-large Dynamic Type.
- Verification: `xcodebuild -project EndlessActivity.xcodeproj -scheme EndlessActivity -destination 'platform=iOS Simulator,name=iPhone 17e,OS=26.5' test`.

## Phase 5: Saved, Preferences, and Empty States

Status: complete.

Primary skill:
- `design-taste-frontend`

Deliverables:
- Saved activity list.
- Remove from saved.
- Preferences screen.
- Filter controls.
- Empty deck state.
- Empty saved state.
- Reset history and reset filters.

Acceptance gate:
- Saved list reflects swipe actions.
- Filters update the deck.
- Empty states give useful recovery actions.
- Dynamic Type layouts remain usable.

Completion verification, 2026-06-27:
- Saved activities refresh from local persistence when the tab opens, support native detail presentation, and can be removed from the row or detail action.
- Duration, cost, energy, setting, company, and category filters persist immediately and refresh Discover when it becomes active.
- Empty Saved explains how to populate the list; empty Discover offers Relax Filters and Reset Skipped recovery actions.
- Reset Filters preserves activity history; destructive Reset Activity History preserves filters and requires confirmation.
- Unit coverage protects Saved and Preferences presentation state, and UI coverage exercises save/remove plus filter/reset flows.
- The full iPhone 17e test suite and iPhone 17 Pro Max build pass on iOS 26.5.
- Verification: `xcodebuild -project EndlessActivity.xcodeproj -scheme EndlessActivity -destination 'platform=iOS Simulator,name=iPhone 17e,OS=26.5' test`.

## Phase 6: Testing, Polish, Demo, and Case Study

Status: complete.

Primary skills:
- `brandkit`
- `gpt-taste`
- `imagegen-frontend-mobile`

Deliverables:
- Unit tests.
- UI tests.
- Accessibility checks.
- Simulator screenshots.
- Demo walkthrough.
- Portfolio case study.
- Updated README.
- Final unfinished-surface audit.

Acceptance gate:
- Test suite passes.
- Manual demo path passes.
- Placeholder audit is resolved or explicitly deferred.
- Case study explains product, architecture, skill usage, and tradeoffs.

Completion verification, 2026-06-28:
- The full iPhone 17e suite passes with 12 unit tests and 7 UI tests, including swipe-left, swipe-right, Saved, Preferences, details, and relaunch persistence coverage.
- The app builds on iPhone 17 Pro Max with iOS 26.5.
- Four standard-size iPhone 17e simulator screenshots document Discover, activity detail, Saved, and Preferences using the implemented UI.
- The demo walkthrough, testing strategy, README, portfolio case study, brand/media references, and unfinished-surface audit reflect the shipped MVP.
- The 50-item catalog was reviewed for unique IDs, unique titles, concrete actions, and category coverage; no generic filler remains.
- Verification: `xcodebuild -project EndlessActivity.xcodeproj -scheme EndlessActivity -destination 'platform=iOS Simulator,name=iPhone 17e,OS=26.5' test`.
