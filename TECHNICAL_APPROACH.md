# Technical Approach

## Problem-solving approach

The PRD asks for templates that already show a user's name and profile information while browsing, then merge into a single image for sharing.

This prototype solves that in two layers:

1. A reusable `GreetingPreviewCard` widget renders the full visual composition:
   - background gradient/template
   - free/premium badge
   - avatar block
   - personalized "Made for ..." strip
   - message copy
2. The detail screen wraps that same widget in a `RepaintBoundary`, captures it as a PNG, writes it to temporary storage, and passes it to the native share sheet.

That means the preview and export paths stay visually consistent because they rely on the same widget tree rather than two separate rendering implementations.

## Tech stack

- Flutter
- Dart
- `share_plus` for platform share integration
- `path_provider` for temporary file storage


## Future improvements

- Add real image picking and cropping for profile photos.
- Persist user profile data locally.
- Fetch categorized templates from a backend CMS.
- Add subscription state and payment integration.
- Expand the export pipeline to support higher-resolution renders, watermarking rules, and analytics.
