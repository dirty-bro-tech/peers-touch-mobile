import 'package:flutter/material.dart';
import 'package:pure_touch/l10n/app_localizations.dart';
import 'package:pure_touch/components/common/field_edit_drawer.dart';

// Helper function to show the name update drawer using the reusable field edit drawer
void showNameUpdateDrawer({
  required BuildContext context,
  required String initialValue,
  required Future<void> Function(String value) onUpdate,
  String? title,
}) {
  final l10n = AppLocalizations.of(context)!;

  showFieldEditDrawer(
    context: context,
    title: title ?? 'Update ${l10n.name}',
    initialValue: initialValue,
    fieldLabel: l10n.name,
    fieldIcon: Icons.person,
    validator: (value) {
      if (value == null || value.trim().isEmpty) {
        return '${l10n.name} cannot be empty';
      }
      if (value.trim().length < 2) {
        return '${l10n.name} must be at least 2 characters';
      }
      if (value.trim().length > 50) {
        return '${l10n.name} cannot exceed 50 characters';
      }
      return null;
    },
    onUpdate: onUpdate,
    maxLength: 50,
  );
}
