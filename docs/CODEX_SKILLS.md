# Codex Skills Routing

## Purpose

This repo includes local Codex skills under `.agents/skills`. Use them as part of the workflow instead of treating design, brand, and presentation work as generic prompts.

The skills are support tools. They do not override the product boundary, roadmap, or native SwiftUI implementation target.

## Installed Local Skills

| Skill | Path | Use For | Do Not Use For |
| --- | --- | --- | --- |
| `brandkit` | `.agents/skills/brandkit/SKILL.md` | Brand identity, logo direction, visual world, case-study boards. | SwiftUI code or product architecture. |
| `design-taste-frontend` | `.agents/skills/design-taste-frontend/SKILL.md` | UI quality review, anti-generic layout judgment, polish standards. | Replacing native iOS conventions with web patterns. |
| `gpt-taste` | `.agents/skills/gpt-taste/SKILL.md` | High-end marketing/case-study pages, motion-rich presentation direction. | Core app interaction or simple native screens. |
| `imagegen-frontend-mobile` | `.agents/skills/imagegen-frontend-mobile/SKILL.md` | Native mobile screen concepts, flow references, app screenshot direction. | Code generation. |
| `imagegen-frontend-web` | `.agents/skills/imagegen-frontend-web/SKILL.md` | Website and landing-page design references if a web presence is added. | Native iOS app screens. |

## Required Skill Use By Phase

Phase 0:
- Document skill routing in `AGENTS.md`, this file, and the roadmap.

Phase 1:
- Use `brandkit` for identity direction.
- Use `imagegen-frontend-mobile` for iOS screen concept references.

Phase 2:
- Use `design-taste-frontend` as a scaffold polish checklist.

Phase 3:
- No visual skill required. Prioritize data and tests.

Phase 4:
- Use `imagegen-frontend-mobile` for the swipe deck and detail-screen visual direction.
- Use `design-taste-frontend` to review hierarchy, density, readability, and non-generic card design.

Phase 5:
- Use `design-taste-frontend` for Saved, Preferences, and empty-state polish.

Phase 6:
- Use `brandkit` for final presentation assets.
- Use `gpt-taste` only if creating a portfolio landing page or motion-heavy case-study page.
- Use `imagegen-frontend-mobile` for App Store-style screenshot framing.

## Native iOS Adaptation Rules

Some skills are frontend or image-direction oriented. Adapt them carefully:

- Keep SwiftUI as the implementation target.
- Use native iOS controls when they solve the interaction cleanly.
- Do not import web animation requirements into the app.
- Do not force GSAP, Tailwind, or web component conventions into SwiftUI.
- Translate design principles into native equivalents: hierarchy, spacing, safe areas, contrast, motion restraint, and accessibility.

## Task Template

Future agents should begin substantial work with:

```text
Roadmap phase: Phase X
Docs read: ...
Codex skill: ...
Target files: ...
Verification: ...
```

If no skill applies, say:

```text
Codex skill: none required; this is data/model/test work.
```

## Skill Lock

`skills-lock.json` records the installed local skills and their sources. Do not remove or rename `.agents/skills` without updating:

- `skills-lock.json`
- `AGENTS.md`
- `docs/CODEX_SKILLS.md`
- `docs/MASTER_EXECUTION_ROADMAP.md`

## Acceptance Criteria

Skill usage is correctly integrated when:

- Every design/brand/presentation phase names the relevant skill.
- Implementation docs do not ask agents to "make it look good" without routing.
- `README.md` and `AGENTS.md` both point to this document.
- Future agents can tell when not to use a visual skill.
