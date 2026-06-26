# Data Model

## Activity

`Activity` represents a single suggestion in the catalog.

Required fields:
- `id`: stable string ID.
- `title`: short display title.
- `summary`: one or two sentence explanation.
- `category`: primary category.
- `durationMinutes`: approximate duration.
- `costLevel`: free, low, medium, high.
- `energyLevel`: low, medium, high.
- `setting`: indoor, outdoor, either.
- `socialMode`: solo, friend, date, group, any.
- `tags`: searchable/rankable descriptors.
- `materials`: optional list of items needed.
- `steps`: short action plan.

Optional fields:
- `prepMinutes`
- `season`
- `timeOfDay`
- `spaceNeeded`
- `safetyNote`

## Categories

Initial categories:
- creative
- movement
- food
- home
- learning
- social
- outdoors
- reset
- local
- entertainment

Keep category names stable because ranking and filters depend on them.

## Cost Levels

- `free`: no purchase expected.
- `low`: small incidental cost.
- `medium`: planned spend.
- `high`: avoid for default MVP feed unless user opts in.

Default MVP catalog should bias toward free and low cost.

## Energy Levels

- `low`: can do while tired.
- `medium`: normal effort.
- `high`: physically or socially demanding.

## Setting

- `indoor`
- `outdoor`
- `either`

Do not require location to decide setting.

## Social Mode

- `solo`
- `friend`
- `date`
- `group`
- `any`

The MVP remains solo-first even if activities can support other modes.

## User Activity Signal

Represents a local action:

- `activityId`
- `action`: saved, skipped, completed
- `timestamp`

`completed` is optional for v1. Add only if it does not distract from save/skip.

## Preferences

Fields:
- selected categories
- max duration
- allowed cost levels
- allowed energy levels
- allowed settings
- allowed social modes

Preferences are explicit user choices. Ranking boosts from saved activity history are implicit signals.

## JSON Catalog Rules

- IDs must be unique.
- Required fields must be present.
- Titles should be under 60 characters.
- Summaries should be under 160 characters.
- Steps should be concrete.
- Tags should be lowercase.
- Duration should be realistic.
- Cost and energy should match the activity.

## Example Activity

```json
{
  "id": "creative-photo-walk-001",
  "title": "Take a one-block photo walk",
  "summary": "Walk one block and capture five photos around a single theme.",
  "category": "creative",
  "durationMinutes": 20,
  "costLevel": "free",
  "energyLevel": "medium",
  "setting": "outdoor",
  "socialMode": "solo",
  "tags": ["photo", "walk", "creative", "outside"],
  "materials": ["Phone camera"],
  "steps": [
    "Pick a theme like red, shadows, or reflections.",
    "Walk one block without rushing.",
    "Take five photos that match the theme."
  ]
}
```
