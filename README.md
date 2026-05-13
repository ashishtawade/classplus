# Custom Greetings App

A Flutter implementation of the PRD for a greeting-card product that personalizes previews with the user's name and avatar, distinguishes free and premium templates, and exports cards through the native share sheet.

## What is included

- Login entry points for Google, Email, and Guest
- Profile setup with a generated avatar identity
- Categorized template browsing
- Live personalized preview cards on the home screen
- Premium upsell popup when premium templates are tapped
- Template detail screen with merged-card sharing flow

## Design direction

The UI intentionally avoids the default "hackathon demo" look. It uses a warm editorial palette, rounded paper-like surfaces, bold typography, and layered gradient compositions so the product feels designed rather than generated.

## Project structure

```text
lib/
  main.dart
  src/
    app.dart
    greetings_flow.dart
    data/
    models/
    screens/
    theme/
    utils/
    widgets/
```

## Setup

1. Install a recent Flutter SDK.
2. From the project root, run:

```bash
flutter pub get
flutter run
```

## Notes

- This workspace did not have Flutter installed, so the app structure was created manually.
- The demo uses generated avatar initials instead of device image picking to keep the prototype lightweight and submission-friendly.
- Share export is implemented with `RepaintBoundary` capture and `share_plus`.

## Suggested next upgrades

1. Replace the generated avatar with camera/gallery profile photo support.
2. Add real authentication providers.
3. Load remote template artwork and premium entitlements from an API.

