# Me Profile Page Implementation Guide

## Overview
This guide provides step-by-step instructions for implementing the Me Profile page from scratch, following the global theme design requirements.

## Basic Structure

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Import other necessary packages

class MeProfilePage extends StatelessWidget {
  MeProfilePage({super.key});

  // Get necessary controllers
  final profileController = Get.find<ProfileController>();
  final meController = ControllerManager.meController;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background, // Use theme-aware background
      appBar: _buildAppBar(context, l10n),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildProfileFields(context, l10n),
            ],
          ),
        ),
      ),
    );
  }

  // Implementation of app bar
  PreferredSizeWidget _buildAppBar(BuildContext context, AppLocalizations l10n) {
    // ...
  }

  // Implementation of profile fields
  Widget _buildProfileFields(BuildContext context, AppLocalizations l10n) {
    // ...
  }
}
```

## AppBar Implementation

```dart
PreferredSizeWidget _buildAppBar(BuildContext context, AppLocalizations l10n) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  
  return AppBar(
    backgroundColor: colorScheme.background,
    elevation: 0,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios, color: colorScheme.onBackground, size: 20),
      onPressed: () => Get.back(),
    ),
    title: Text(
      l10n.meProfile,
      style: TextStyle(
        color: colorScheme.onBackground,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    centerTitle: true,
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(1.0),
      child: Container(color: colorScheme.onBackground.withOpacity(0.15), height: 0.5),
    ),
  );
}
```

## Profile Fields Implementation

```dart
Widget _buildProfileFields(BuildContext context, AppLocalizations l10n) {
  return Column(
    children: [
      // Profile Photo
      _buildProfileField(
        context,
        label: l10n.profilePhoto,
        child: Obx(() => _buildAvatar()),
        onTap: () => Get.to(() => AvatarChangePage()),
      ),
      _buildDivider(),
      
      // Name
      _buildProfileField(
        context,
        label: l10n.name,
        value: meController.userInfo.value.nickname,
        onTap: () => profileController.editNickname(),
      ),
      _buildDivider(),
      
      // Gender
      _buildProfileField(
        context,
        label: l10n.gender,
        value: meController.userInfo.value.gender == 1 ? l10n.male : l10n.female,
        onTap: () => profileController.editGender(),
      ),
      _buildDivider(),
      
      // Add other fields similarly...
    ],
  );
}
```

## Helper Methods

```dart
Widget _buildProfileField(BuildContext context, {
  required String label,
  String? value,
  Widget? child,
  VoidCallback? onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // Label
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          const Spacer(),
          // Value or custom child
          if (child != null) child,
          if (value != null)
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          // Chevron icon if tappable
          if (onTap != null)
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(
                Icons.chevron_right,
                color: Colors.white54,
                size: 20,
              ),
            ),
        ],
      ),
    ),
  );
}

Widget _buildDivider() {
  return Divider(
    height: 1,
    thickness: 0.5,
    color: Colors.white.withOpacity(0.1),
    indent: 0,
    endIndent: 0,
  );
}

Widget _buildAvatar() {
  final user = meController.userInfo.value;
  if (user.avatar.isNotEmpty) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: Image.network(
        user.avatar,
        width: 80,
        height: 80,
        fit: BoxFit.cover,
      ),
    );
  } else {
    // Generate identicon as fallback
    final svg = Jdenticon.toSvg(user.userId);
    return SvgPicture.string(
      svg,
      width: 80,
      height: 80,
    );
  }
}
```

## Key Design Points

1. **Dark Theme**: Black background with white text
2. **Layout**: Horizontal layout with labels on left, values on right
3. **Dividers**: Full-width, semi-transparent white dividers
4. **Navigation**: Chevron icons for navigable items
5. **Avatar**: 80x80px circular avatar
6. **Spacing**: Consistent 56px height for each profile field

Follow this guide along with the design rules in `me_profile_dark_theme.yml` to implement the Me Profile page from scratch.