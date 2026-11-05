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
- `materials`: list of items needed. Use an empty list when nothing special is needed.
- `steps`: short action plan.

Optional fields:
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
- entertainment

Keep category names stable because ranking and filters depend on them.

Do not add a `local` category in v1. Location-specific ideas can use `outdoors`, `social`, or tags such as `nearby`, but the app must not require location permission.

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

## Local Activity State

The MVP stores local state as sets of activity IDs rather than timestamped signal
records:

- saved IDs
- skipped IDs
- completed IDs, retained for persisted-state compatibility
- explicit filter preferences

The UI exposes save and skip. It does not expose completion tracking in v1.

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
- IDs use kebab case in the shape `category-short-title-001`.
- Required fields must be present.
- Titles should be under 60 characters.
- Summaries should be under 160 characters.
- Steps should be concrete.
- Tags should be lowercase.
- Tags should use kebab case when more than one word is needed.
- Duration should be realistic.
- Cost and energy should match the activity.
- Every activity has 2 to 6 tags.
- Every activity has 2 to 5 steps.
- `materials` can be empty but must be present.
- `safetyNote` is required for activities involving cooking heat, outdoor night movement, tools, or strenuous movement.

## Codable Enum Values

Use these exact raw string values:

```text
ActivityCategory: creative, movement, food, home, learning, social, outdoors, reset, entertainment
CostLevel: free, low, medium, high
EnergyLevel: low, medium, high
ActivitySetting: indoor, outdoor, either
SocialMode: solo, friend, date, group, any
```

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
