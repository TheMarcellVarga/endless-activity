# Design System

## Direction

Endless Activity should feel native, quick, tactile, and modern. The design should be polished without becoming a heavy lifestyle brand page inside an app.

Use `imagegen-frontend-mobile` for screen concepts and `design-taste-frontend` for polish review. Translate their guidance into native SwiftUI patterns.

The app uses an Apple-coherent native visual language: system navigation hierarchy,
grouped surfaces, semantic light/dark backgrounds, SF Symbols, and restrained motion.
Brand color adds emphasis without replacing familiar iOS structure.

## Platform

Primary platform:
- iOS native.

Use:
- safe areas
- native tab bars
- native sheets
- Dynamic Type
- VoiceOver
- system haptics
- thumb-friendly controls

Avoid:
- web-like navbar layouts
- tiny tags
- overnested cards
- generic purple gradients
- decorative blobs
- unreadable mockup text

## Navigation

Main tabs:
- Discover
- Saved
- Preferences

Discover is the default launch tab.

All three root tabs use large navigation titles. Detail sheets use inline titles.
The tab bar and sheet chrome remain system-owned so they automatically adopt the
current iOS material and accessibility behavior.

## Shared Visual Tokens

- Page background: semantic system grouped background.
- Raised surface: semantic secondary grouped background.
- Primary text: semantic system label color.
- Main card radius: 20 points, continuous corners.
- Inset/callout radius: 12 points, continuous corners.
- Main horizontal page inset: 20 points.
- Primary action: coral; category colors remain supporting accents.
- Metadata: one shared icon-and-label row across Discover, Saved, and details.

## Discover Card

Card content:
- title
- summary
- category
- duration
- cost
- energy
- setting
- one or two tags max on the card

Do not overload cards with all metadata. Detail view can hold steps and materials.

## Card Visual Rules

- Use the 20-point main card radius and 12-point inset radius consistently.
- Use one primary card surface.
- Avoid nested cards inside the swipe card.
- Maintain strong title contrast.
- Use clear save/skip affordances during drag.
- Use color sparingly for category or action feedback.
- Use a single soft shadow for the active deck card; do not combine it with a border.

## Gestures

Swipe left:
- skip visual hint.
- haptic on commit.

Swipe right:
- save visual hint.
- haptic on commit.

Cancel:
- card springs back.

Accessible alternatives:
- visible buttons or actions for save and skip.

## Detail View

Use a native sheet or navigation push.

Show:
- title
- summary
- duration/cost/energy row
- materials
- steps
- save/remove action

## Preferences

Controls should be familiar:
- segmented controls for simple enums
- toggles or chips for categories
- picker/slider for duration if useful
- reset buttons placed clearly but not dangerously

Preferences should not feel like onboarding.

## Empty States

Empty deck:
- concise message
- Relax Filters
- Reset Skipped

Empty saved:
- explain saved activities appear after right swipes
- offer Back to Discover

No long tutorials.

## Accessibility

- Support Dynamic Type.
- Test at large text sizes.
- Provide VoiceOver labels for cards.
- Provide button alternatives to gestures.
- Maintain contrast.
- Do not communicate save/skip state through color alone.

## Visual Review Checklist

Use `design-taste-frontend` as a review checklist:
- not generic
- clear hierarchy
- no cramped text
- no overused AI-purple palette
- consistent shape language
- readable on small iPhones
- controls match user expectations
