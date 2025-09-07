# Pages Rules Directory

This directory contains rules that are specific to individual pages in the application.

## Purpose

The Pages directory is part of the customized rule structure and focuses on rules that apply only to specific pages. This allows for targeted rule enforcement without affecting other parts of the application.

## When to Use

Place rules in this directory when:
- The rule applies only to a specific page or set of pages
- You need to enforce page-specific design, structure, or behavior requirements
- You want to isolate page-specific rules from global rules

## Contents

Each file in this directory should target specific pages using the `target` section in the rule configuration:

```yaml
target:
  files:
    - "lib/pages/specific_page.dart"
```

## Examples

Example rule files might include:
- `home_page_rules.yml` - Rules specific to the home page
- `profile_page_rules.yml` - Rules specific to the profile page
- `settings_page_rules.yml` - Rules specific to the settings page