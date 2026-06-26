# Product Spec

## Product

Endless Activity is a native iOS swipe deck that helps bored users find something realistic to do.

Final working name:
- Endless Activity.

One sentence:
- Endless Activity is a native iOS swipe deck for finding something realistic to do when you are bored.

## Positioning

Search asks users to know what they want. Endless Activity starts from the opposite state: "I am bored." The app should make browsing activities feel fast, lightweight, and mildly playful.

The product should feel closer to a useful deck of prompts than a social feed. It gives the user a concrete next action, then gets out of the way.

## Target Users

Primary:
- People at home who want a quick idea.
- People between plans who want a low-effort option.
- People who want to save activities for later.

Secondary:
- Portfolio reviewers evaluating native iOS craft.

## Core Loop

1. User opens app.
2. Activity card appears immediately.
3. User swipes right to save or left to skip.
4. App advances to another idea.
5. User optionally filters the feed.
6. User opens Saved when ready to choose something.

## MVP Features

Discover:
- Swipeable cards.
- Activity details.
- Save and skip actions.
- Deck reset when empty.

Saved:
- Saved list.
- Remove saved activity.
- Open saved details.

Preferences:
- Duration.
- Cost.
- Energy.
- Indoor/outdoor/either.
- Solo/friend/date/group.
- Category selection.
- Reset filters.
- Reset history.

Catalog:
- Bundled curated JSON.
- At least 50 MVP activities.
- Activities tagged consistently.

## Locked V1 Product Decisions

- The first screen is Discover, not onboarding.
- Swipe right means save.
- Swipe left means skip.
- Cards must show enough information to act without opening details: title, summary or image-backed title, duration, cost, energy, setting, and primary category.
- Details add materials, steps, safety note when needed, and a save/remove action.
- Preferences are practical constraints, not personalization quizzes.
- The app works fully offline after install.
- All persistence is local in v1.

## App Tone

Use short, plain language:
- "Try this."
- "Save it for later."
- "Too much? Lower the energy."
- "Reset skipped ideas."

Avoid:
- motivational speeches
- streak pressure
- faux-social engagement copy
- AI assistant language
- vague lifestyle promises

## Activity Examples

Good examples:
- Make a 15-minute playlist for a future walk.
- Try a no-recipe dinner using three ingredients.
- Take a camera roll photo walk around one block.
- Rearrange one shelf or drawer.
- Learn the opening move of a board game.

Weak examples:
- "Go have fun."
- "Travel somewhere."
- "Start a business."
- "Meet new people" without a concrete action.
- Anything unsafe, expensive by default, or too vague.

## Success Criteria

Product success in v1:
- User understands the app without onboarding.
- First card appears immediately.
- Swipe behavior is obvious.
- Saved list feels useful.
- Filters meaningfully change the deck.
- App works offline after install.

Portfolio success:
- Docs explain decisions clearly.
- Native iOS craft is visible.
- Interaction polish is stronger than a basic CRUD app.
- Tests cover the core loop.

## Non-Goals

- Social planning.
- Group voting.
- Friends or messaging.
- Accounts.
- Cloud sync.
- Location-required discovery.
- Live event APIs.
- Vendor marketplace.
- Booking.
- Payments.
- AI-generated ideas.
- Recommendation ML.

These are non-goals for v1 even if they appear useful in later phases. Do not add implementation hooks for accounts, network feeds, booking, payments, or AI generation during the MVP.

## Future Ideas

Only consider after MVP:
- Optional city/local mode.
- Optional AI idea generation.
- Shared activity lists.
- Group swipe planning.
- Calendar integration.
- Home screen widget.
- App Clips.
- Monetized partner activities.
