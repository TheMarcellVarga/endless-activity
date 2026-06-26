# Design System

## Direction

Endless Activity should feel native, quick, tactile, and modern. The design should be polished without becoming a heavy lifestyle brand page inside an app.

Use `imagegen-frontend-mobile` for screen concepts and `design-taste-frontend` for polish review. Translate their guidance into native SwiftUI patterns.

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

- Radius should feel native and consistent.
- Use one primary card surface.
- Avoid nested cards inside the swipe card.
- Maintain strong title contrast.
- Use clear save/skip affordances during drag.
- Use color sparingly for category or action feedback.

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
