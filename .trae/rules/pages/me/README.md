# Me Profile Page Design Rules

## Overview
This directory contains design rules specific to the Me Profile page in the application. These rules define how the profile page should be styled, structured, and behave.

## Files

### `me_profile_dark_theme.yml`
Defines the dark theme styling for the Me Profile page, including:
- Background colors (black)
- Text colors (white)
- Divider styling (semi-transparent white)
- Profile field layout (horizontal with right-aligned values)
- Avatar styling
- Special field treatments (QR code, Short Bio section)

## Implementation Notes

### Dark Theme Implementation
The Me Profile page uses a dark theme with the following key characteristics:
- Black background (`#000000`)
- White text (`#FFFFFF`)
- Semi-transparent white dividers (`rgba(255, 255, 255, 0.1)`)
- Horizontal layout for profile fields with labels on the left and values on the right
- Right-aligned values with chevron icons for navigable items
- No container decorations (flat design)

### When Creating From Scratch
When implementing the Me Profile page from scratch:
1. Start with a black `Scaffold` background
2. Use a black `AppBar` with white text and a thin semi-transparent white bottom border
3. Implement profile fields in a horizontal layout with full-width dividers
4. Use white text for all content
5. Add chevron icons for navigable items
6. Ensure the avatar is properly sized and positioned
7. Follow the spacing guidelines from the layout spacing rules