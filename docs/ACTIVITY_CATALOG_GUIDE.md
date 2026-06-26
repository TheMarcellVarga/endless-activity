# Activity Catalog Guide

## Purpose

The catalog is the core content of the MVP. It must feel useful, varied, safe, and realistic. A polished swipe UI cannot compensate for vague or low-quality activities.

## Catalog Size

MVP minimum:
- 50 activities.

Better demo target:
- 80 to 120 activities.

Avoid launching with fewer than 50 because the deck will feel repetitive after saves, skips, and filters.

## Quality Bar

Each activity should be:
- specific
- doable today
- understandable in one card
- low-friction
- safe for a general audience
- tagged consistently
- honest about cost, duration, and energy

Avoid:
- vague self-help prompts
- expensive activities as default suggestions
- unsafe dares
- activities requiring private data
- activities requiring a specific city
- activities that need another person unless marked clearly

## Category Balance

Locked MVP categories:
- creative
- movement
- food
- home
- learning
- social
- outdoors
- reset
- entertainment

Target distribution for 80 activities:
- creative: 10
- movement: 10
- food: 10
- home: 10
- learning: 10
- social: 8
- outdoors: 8
- reset: 8
- entertainment: 6

The first catalog should bias toward activities that work in many locations.

For the first 50 activities, use this balanced target:
- creative: 7
- movement: 6
- food: 6
- home: 6
- learning: 6
- social: 5
- outdoors: 5
- reset: 5
- entertainment: 4

## Tagging Rules

Tags should help ranking and filtering.

Good tags:
- short
- lowercase
- concrete
- reused across activities

Bad tags:
- full sentences
- duplicate category labels only
- jokes
- overly specific one-offs

Useful tag families:
- mood: calm, playful, focused, cozy
- medium: music, cooking, photo, writing, cleaning
- context: home, outside, phone, no-equipment
- outcome: reset, learn, make, move

## Duration Rules

Use realistic estimates:
- 5 minutes: tiny reset.
- 15 minutes: quick activity.
- 30 minutes: standard boredom break.
- 60 minutes: more involved.
- 120+ minutes: avoid in default MVP unless activity is compelling.

## Safety Rules

Activities must not encourage:
- trespassing
- harassment
- unsafe physical challenges
- gambling
- illegal activity
- financial risk
- medical claims
- dangerous cooking or physical instructions without a safety note

## Content Voice

The tone should be direct and light:
- "Make a three-song playlist for a rainy walk."
- "Pick one drawer and reset it in ten minutes."
- "Try a no-recipe snack using one crunchy thing and one sweet thing."

Avoid forced hype:
- "Unleash your ultimate potential."
- "Become a new person today."
- "Transform your life instantly."

## Demo Catalog

The demo catalog should include:
- activities for tired users
- activities for high-energy users
- indoor and outdoor options
- zero-cost options
- friend/date/group options, but not as the majority
- visually interesting cards for screenshots

## Locked First 50 Activities

Phase 3 should convert this starter set into bundled JSON using `docs/DATA_MODEL.md`. Keep titles stable unless a validation issue appears.

| ID | Title | Category | Duration | Cost | Energy | Setting | Social |
| --- | --- | --- | --- | --- | --- | --- | --- |
| creative-photo-walk-001 | Take a one-block photo walk | creative | 20 | free | medium | outdoor | solo |
| creative-three-song-playlist-002 | Make a three-song walk playlist | creative | 15 | free | low | indoor | solo |
| creative-sketch-one-object-003 | Sketch one object from three angles | creative | 20 | free | low | indoor | solo |
| creative-phone-wallpaper-004 | Make a new phone wallpaper | creative | 15 | free | low | indoor | solo |
| creative-postcard-note-005 | Write a postcard-length note | creative | 10 | free | low | indoor | friend |
| creative-color-hunt-006 | Photograph five things in one color | creative | 25 | free | medium | either | solo |
| creative-room-soundtrack-007 | Pick a soundtrack for one room | creative | 15 | free | low | indoor | solo |
| movement-stair-reset-008 | Do a ten-minute stair reset | movement | 10 | free | high | either | solo |
| movement-stretch-timer-009 | Follow a five-minute stretch timer | movement | 5 | free | low | indoor | solo |
| movement-walk-new-turn-010 | Walk until you take one new turn | movement | 25 | free | medium | outdoor | solo |
| movement-dance-two-songs-011 | Dance through two songs | movement | 10 | free | medium | indoor | any |
| movement-balance-practice-012 | Try a quiet balance challenge | movement | 10 | free | medium | indoor | solo |
| movement-errand-loop-013 | Turn one errand into a loop walk | movement | 30 | low | medium | outdoor | solo |
| food-three-ingredient-snack-014 | Make a three-ingredient snack | food | 15 | low | low | indoor | solo |
| food-pantry-dinner-015 | Cook from what you already have | food | 30 | low | medium | indoor | any |
| food-tea-tasting-016 | Make a tiny tea tasting | food | 15 | low | low | indoor | friend |
| food-new-toast-017 | Invent a new toast topping | food | 10 | low | low | indoor | solo |
| food-market-one-ingredient-018 | Buy one unfamiliar ingredient | food | 30 | low | medium | either | solo |
| food-recipe-opening-move-019 | Learn one cooking technique | food | 20 | free | medium | indoor | solo |
| home-one-drawer-reset-020 | Reset one drawer | home | 15 | free | low | indoor | solo |
| home-shelf-swap-021 | Rearrange one shelf | home | 20 | free | medium | indoor | solo |
| home-cable-tidy-022 | Tidy one cable tangle | home | 10 | free | low | indoor | solo |
| home-entryway-refresh-023 | Refresh the entryway | home | 20 | free | medium | indoor | solo |
| home-laundry-sprint-024 | Start a laundry sprint | home | 15 | free | medium | indoor | solo |
| home-lighting-shift-025 | Change the room lighting | home | 10 | free | low | indoor | solo |
| learning-board-game-opening-026 | Learn a board game opening move | learning | 20 | free | low | indoor | solo |
| learning-five-phrases-027 | Learn five phrases in a language | learning | 15 | free | low | indoor | solo |
| learning-map-neighborhood-028 | Study your neighborhood map | learning | 15 | free | low | indoor | solo |
| learning-short-documentary-029 | Watch one short documentary clip | learning | 20 | free | low | indoor | solo |
| learning-fix-one-shortcut-030 | Learn one phone shortcut | learning | 10 | free | low | indoor | solo |
| learning-museum-object-031 | Read about one museum object | learning | 15 | free | low | indoor | solo |
| social-check-in-text-032 | Send a specific check-in text | social | 5 | free | low | indoor | friend |
| social-coffee-invite-033 | Invite someone for a short coffee | social | 10 | low | medium | either | friend |
| social-two-person-playlist-034 | Trade three songs with someone | social | 15 | free | low | indoor | friend |
| social-date-question-walk-035 | Take a question walk | social | 30 | free | medium | outdoor | date |
| social-group-snack-poll-036 | Run a group snack poll | social | 10 | low | low | indoor | group |
| outdoors-cloud-log-037 | Keep a ten-minute cloud log | outdoors | 10 | free | low | outdoor | solo |
| outdoors-bench-reading-038 | Read on a nearby bench | outdoors | 25 | free | low | outdoor | solo |
| outdoors-tree-route-039 | Find three different trees | outdoors | 30 | free | medium | outdoor | solo |
| outdoors-sunset-spot-040 | Walk to a sunset spot | outdoors | 30 | free | medium | outdoor | any |
| outdoors-nearby-water-041 | Find the nearest water view | outdoors | 40 | free | medium | outdoor | solo |
| reset-breathing-window-042 | Do a window breathing reset | reset | 5 | free | low | indoor | solo |
| reset-phone-declutter-043 | Delete ten old screenshots | reset | 10 | free | low | indoor | solo |
| reset-sensory-reset-044 | Do a five-sense reset | reset | 5 | free | low | either | solo |
| reset-timer-nap-045 | Take a twenty-minute timer nap | reset | 20 | free | low | indoor | solo |
| reset-clear-surface-046 | Clear one visible surface | reset | 10 | free | low | indoor | solo |
| entertainment-micro-movie-night-047 | Build a micro movie night | entertainment | 60 | low | low | indoor | any |
| entertainment-album-first-listen-048 | Listen to an album without scrolling | entertainment | 45 | free | low | indoor | solo |
| entertainment-retro-game-round-049 | Play one round of a retro game | entertainment | 20 | free | low | indoor | any |
| entertainment-library-random-pick-050 | Pick a random library item | entertainment | 30 | free | low | either | solo |

Starter-set notes:
- 41 of 50 are free.
- No activity requires account creation, location permission, booking, or a live event feed.
- Group, friend, and date activities are present but not dominant.
- Phase 3 should add full summaries, materials, steps, tags, and safety notes during JSON creation.

## Validation Checklist

Before shipping a catalog:
- all IDs unique
- no missing required fields
- no empty steps
- no unsupported enum values
- no duplicate titles
- cost levels are reasonable
- duration estimates are plausible
- at least 70 percent of activities are free or low cost
