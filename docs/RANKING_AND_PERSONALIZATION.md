# Ranking And Personalization

## Summary

V1 ranking should be simple, deterministic, local, and testable. Do not add machine learning or network calls.

## Inputs

- Full activity catalog.
- Explicit preferences.
- Saved IDs.
- Skipped IDs.
- Optional completed IDs.
- Saved activity categories and tags.

## Output

An ordered list of eligible activities for the Discover deck.

## Eligibility Rules

Exclude:
- already saved activities
- currently skipped activities
- activities that violate active filters

Include again only after:
- user resets history
- user removes a saved activity and it becomes eligible by policy
- implementation explicitly supports session-only skips

Default: skipped activities stay hidden until reset history.

## Scoring Rules

Start with a base score of 0.

Add points:
- category matches explicit selection
- duration fits selected range
- cost level is allowed
- energy level is allowed
- setting is allowed
- social mode is allowed
- tags overlap with saved activities
- category overlaps with saved activities

Subtract points:
- activity is high cost and no cost preference is set
- activity duration is long and no duration preference is set
- activity is group-only and user has not selected group/social mode

Do not score based on hidden demographic assumptions.

## Shuffle Rule

After scoring:
- sort by score bucket
- shuffle within buckets
- keep a stable session order until preferences or signals change

This prevents the deck from feeling robotic while keeping preferences meaningful.

## Endless Feeling

The feed feels endless through:
- enough catalog depth
- bucket shuffle
- reset history
- relax filters action
- optional "bring back skipped" action later

Do not fake endlessness by repeating the same cards immediately.

## Empty Deck Behavior

When no activities are eligible:
- show friendly empty state
- offer Relax Filters
- offer Reset Skipped
- keep Saved intact unless user explicitly clears it

## Test Cases

- Saved activities are excluded from Discover.
- Skipped activities are excluded from Discover.
- Reset skipped returns skipped cards.
- Duration filter excludes longer activities.
- Cost filter excludes disallowed cost levels.
- Saved-category boost changes order but does not violate filters.
- Empty state appears when filters exclude all cards.

## Future Personalization

Post-MVP options:
- session-only skips
- completed activity boost
- time-of-day sorting
- optional local notification prompts
- optional AI-generated ideas
- optional location-aware catalog

Do not implement these in v1 unless the roadmap changes.
