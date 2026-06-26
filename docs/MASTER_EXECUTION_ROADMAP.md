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

Status: in progress.

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

## Phase 2: SwiftUI App Scaffold

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

## Phase 3: Activity Data, Persistence, and Ranking

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

## Phase 4: Discover Swipe Experience

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

## Phase 5: Saved, Preferences, and Empty States

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

## Phase 6: Testing, Polish, Demo, and Case Study

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
