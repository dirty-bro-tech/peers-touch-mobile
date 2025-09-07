# Theme Selection Guide

## Overview
This guide outlines when to use light theme versus dark theme in the application. The application primarily follows the system theme setting with a few exceptions.

## Default Theme
By default, the application follows the system theme setting (light or dark). All pages should respect this setting unless specifically noted below.

## Pages with Fixed Theme Requirements

### Dark Theme Pages
Currently, there are no pages that require fixed dark theme styling. All pages should follow the global theme settings.

### Light Theme Pages
The following pages should always use light theme styling regardless of system settings:

1. **Main Feed** - Uses standard light theme colors
2. **Photo Gallery** - Uses standard light theme colors

## Implementation Guidelines

### For Dark Theme Pages
- Set `Scaffold.backgroundColor` to `Colors.black`
- Use white text (`Colors.white`) for all content
- Use `Colors.white.withOpacity(0.1)` for dividers
- Ensure sufficient contrast for all UI elements

### For System Theme Pages
- Use theme-aware colors: `Theme.of(context).colorScheme.*`
- Test appearance in both light and dark modes
- Ensure all UI elements have sufficient contrast in both themes