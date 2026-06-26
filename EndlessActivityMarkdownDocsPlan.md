# Endless Activity Markdown Docs Plan

## Summary

Create a documentation layer comparable in breadth to the `ai-finance` project, adapted for a native iOS consumer app. The docs should make product decisions, architecture, design direction, Codex skill routing, test strategy, and execution phases explicit.

## Files To Maintain

- `README.md`: public project overview, current status, stack, source of truth, local setup, and demo path.
- `AGENTS.md`: instructions for Codex agents working in this repo.
- `EndlessActivityWorkspacePlan.md`: master product and technical plan.
- `EndlessActivityMarkdownDocsPlan.md`: inventory and intent of the documentation set.
- `docs/MASTER_EXECUTION_ROADMAP.md`: phase order, acceptance gates, and execution authority.
- `docs/CODEX_SKILLS.md`: repo-local Codex skill routing and usage rules.
- `docs/PRODUCT_SPEC.md`: users, product positioning, feature set, non-goals, and success criteria.
- `docs/IMPLEMENTATION_PLAN.md`: phased build plan from scaffold to polished demo.
- `docs/ARCHITECTURE.md`: SwiftUI architecture, state flow, services, and boundaries.
- `docs/DATA_MODEL.md`: models, catalog schema, local signals, and persistence expectations.
- `docs/ACTIVITY_CATALOG_GUIDE.md`: seed content rules, taxonomy, quality bar, and examples.
- `docs/RANKING_AND_PERSONALIZATION.md`: rule-based feed scoring and reset behavior.
- `docs/DESIGN_SYSTEM.md`: native iOS visual rules, gesture feedback, components, and accessibility.
- `docs/BRAND_AND_MEDIA.md`: naming, tone, icon direction, screenshots, and presentation assets.
- `docs/PRIVACY_AND_SAFETY.md`: local-first privacy, permissions, content safety, and data boundaries.
- `docs/TESTING_STRATEGY.md`: unit, UI, accessibility, gesture, and manual verification coverage.
- `docs/ENVIRONMENT.md`: Xcode, iOS target, setup, scripts, and simulator notes.
- `docs/DEMO_WALKTHROUGH.md`: exact demo path and verification script.
- `docs/PORTFOLIO_CASE_STUDY.md`: recruiter-facing case-study narrative.
- `docs/UNFINISHED_SURFACES_AUDIT.md`: placeholder and rough-edge cleanup checklist.

## Content Rules

- Every doc must reinforce native SwiftUI as the target.
- Every doc must preserve the v1 boundary: local-first, solo, curated catalog.
- Skill references must point to `.agents/skills` and avoid vague "use AI" language.
- Do not invent backend, account, location, social, or monetization requirements.
- Keep docs practical and implementation-oriented.
- Cross-link docs from `README.md`.
- Keep Markdown ASCII-safe.

## Execution Order

1. Create top-level orientation docs.
2. Create roadmap and Codex skill routing docs.
3. Create product, implementation, and architecture docs.
4. Create data, catalog, ranking, design, privacy, testing, environment, demo, and case-study docs.
5. Keep `README.md` and `AGENTS.md` aligned with roadmap changes.

## Assumption

"As extensive as ai-finance" means documentation breadth and implementation usefulness, not copying fintech-specific backend/AI/security complexity into a native iOS app where it does not belong.
