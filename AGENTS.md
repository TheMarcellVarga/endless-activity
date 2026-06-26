# Agent Instructions

## Project Identity

This repo is for Endless Activity: a native iOS consumer app that helps bored users find realistic things to do through a swipe-based activity deck.

The product is not a social network, event marketplace, booking app, AI chatbot, or local-discovery data platform in v1. Keep the MVP focused: solo discovery, curated bundled catalog, local persistence, and polished native interaction.

## Source Of Truth

Before implementation, read these in order:

1. `docs/MASTER_EXECUTION_ROADMAP.md`
2. `docs/CODEX_SKILLS.md`
3. `EndlessActivityWorkspacePlan.md`
4. `docs/PRODUCT_SPEC.md`
5. `docs/IMPLEMENTATION_PLAN.md`
6. Relevant subsystem docs in `docs/`

`docs/MASTER_EXECUTION_ROADMAP.md` is the execution authority. Follow its phase order, acceptance gates, and skill routing unless the user explicitly updates the roadmap.

## Codex Skill Requirement

This repo has local Codex skills in `.agents/skills`. Future agents should use them deliberately:

| Work Type | Primary Skill | Notes |
| --- | --- | --- |
| Brand identity, app icon direction, case-study board | `brandkit` | Use for visual identity and presentation systems. |
| Native mobile screen concepts | `imagegen-frontend-mobile` | Use before committing to major screen direction. |
| SwiftUI screen polish review | `design-taste-frontend` | Use as a quality bar, adapted for native iOS. |
| High-end portfolio or marketing presentation | `gpt-taste` | Use for case-study/landing-page style, not core app code. |
| Website section references | `imagegen-frontend-web` | Use only if a website or portfolio page is added. |

Start each substantial task by naming:
- roadmap phase
- active docs
- relevant Codex skill
- target files
- verification command

## Product Guardrails

- Keep v1 solo-first.
- Swipe right means save.
- Swipe left means skip.
- Do not add account creation.
- Do not add required location permission.
- Do not add live events, vendors, payments, or booking.
- Do not add AI-generated activities unless the roadmap is explicitly changed.
- Do not make the app depend on network access.
- Keep activity suggestions safe, low-friction, and realistic.

## Native iOS Rules

- Use SwiftUI for UI.
- Prefer native navigation, sheets, tab bars, safe-area behavior, Dynamic Type, VoiceOver labels, haptics, and gestures.
- Do not build a phone-sized website inside SwiftUI.
- Keep cards legible and thumb-friendly.
- Gesture interactions must have visible feedback and accessible alternatives.
- Persist user signals locally.
- Keep catalog data deterministic and testable.

## Architecture Rules

- Separate catalog loading, ranking, persistence, and presentation state.
- Models must be Codable where they touch JSON or persistence.
- Ranking logic must be unit-testable outside SwiftUI views.
- Swipe deck state must not mutate the catalog source.
- Saved and skipped activity IDs must survive relaunch.
- Empty states must explain the recovery action without heavy instruction copy.

## Documentation Rules

- Update docs before or with implementation when behavior changes.
- Keep `README.md` and `docs/MASTER_EXECUTION_ROADMAP.md` current.
- Add decisions to the relevant doc instead of burying them in chat.
- Keep Markdown ASCII-safe unless a file already uses non-ASCII.
- Link docs together so future agents can navigate without guessing.

## Testing Rules

- Add unit tests for catalog decoding, filtering, ranking, saved/skipped behavior, and persistence.
- Add UI tests for the golden path: launch, swipe right, saved list, swipe left, filters, relaunch.
- Run simulator checks for small and large iPhones before declaring UI complete.
- Verify Dynamic Type and VoiceOver labels for core flows.

## Working Style

- Follow the current roadmap phase.
- Avoid unrelated refactors.
- Do not overwrite user changes.
- Use implementation decisions already documented here.
- If a request conflicts with the roadmap, update the roadmap first.
- Keep the app shippable and small before adding new surface area.
