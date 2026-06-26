# Privacy And Safety

## Summary

V1 is local-first. This keeps the app simple, private, and reliable.

## Data Collected

Local only:
- saved activity IDs
- skipped activity IDs
- preferences
- optional completed activity IDs

Do not collect:
- account identity
- precise location
- contacts
- calendar
- photos
- health data
- payment data

## Permissions

V1 should require no permissions on first launch.

Do not request:
- location
- notifications
- contacts
- photos
- calendar

Future optional permissions must be added only with clear user benefit and roadmap approval.

## Local Storage

Persist:
- IDs and preferences, not sensitive personal profiles.

Keep:
- storage minimal
- reset controls available
- no hidden cloud sync

## Content Safety

Activities must avoid:
- illegal actions
- unsafe dares
- harassment
- trespassing
- gambling
- medical claims
- financial risk
- discriminatory or adult content

Activities with physical movement should be moderate and include safety notes if needed.

## User Control

Users should be able to:
- remove saved activities
- reset skipped history
- reset filters
- clear local activity history if implemented

## Analytics

No analytics are required in v1.

If analytics are added later:
- document events first
- avoid raw activity history unless necessary
- do not collect precise location without explicit opt-in
- provide privacy language

## App Store Notes

V1 privacy posture should be simple:
- no account
- no tracking
- no third-party data sharing
- no location collection

Update this doc if any SDK changes that posture.
