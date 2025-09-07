import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pure_touch/components/common/floating_action_ball.dart';
import 'package:pure_touch/pages/me/me_profile.dart';
import 'package:pure_touch/l10n/app_localizations.dart';
import 'package:pure_touch/pages/me/me_user_profile_header.dart';
import 'package:pure_touch/pages/me/me_services_section.dart';
import 'package:pure_touch/pages/me/me_features_section.dart';
import 'package:pure_touch/pages/me/me_settings_section.dart';
import 'package:pure_touch/controller/controller.dart';
import 'package:pure_touch/controller/me_controller.dart';

class MeHomePage extends StatelessWidget {
  MeHomePage({super.key}) {
    // Initialize controller if not already initialized
    if (!Get.isRegistered<MeController>()) {
      Get.put(MeController());
    }
  }

  // Static action options for floating action ball
  static List<FloatingActionOption> get actionOptions => [];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        shadowColor: colorScheme.onSurface.withValues(alpha: 0.1),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: colorScheme.onSurface,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: colorScheme.onSurface.withValues(alpha: 0.2),
            height: 0.5,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            
            // Profile Photo Item
            const SizedBox(height: 10),
            
            // User Profile Header (Name, ID, etc.)
            const UserProfileHeader(),
            const SizedBox(height: 10),
            
            // Services Section
            const ServicesSection(),
            const SizedBox(height: 10),
            
            // Features Section
            const FeaturesSection(),
            const SizedBox(height: 10),
            
            // Settings Section
            const SettingsSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }


}
