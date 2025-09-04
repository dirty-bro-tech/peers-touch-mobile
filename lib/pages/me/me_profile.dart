import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdenticon_dart/jdenticon_dart.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pure_touch/controller/controller.dart';
import 'package:pure_touch/l10n/app_localizations.dart';
import 'avatar_change_page.dart';

class MeProfilePage extends StatelessWidget {
  const MeProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          l10n.meProfile,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
            height: 1.0,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              
              // Profile Fields with Profile Photo as first item
              _buildProfileFields(context, l10n),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToAvatarChange(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AvatarChangePage(),
      ),
    );
  }

  Widget _buildProfileFields(BuildContext context, AppLocalizations l10n) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Profile Photo as first item - using consistent styling
          _buildProfileField(
            context,
            l10n.profilePhoto,
            '',
            Icons.account_circle_outlined,
            showAvatar: true,
          ),
          _buildDivider(context),
          _buildProfileField(
            context,
            l10n.name,
            l10n.littleFirst,
            Icons.person_outline,
          ),
          _buildDivider(context),
          _buildProfileField(
            context,
            l10n.gender,
            l10n.male,
            Icons.wc_outlined,
          ),
          _buildDivider(context),
          _buildProfileField(
            context,
            l10n.region,
            'Shenzhen, Guangdong',
            Icons.location_on_outlined,
          ),
          _buildDivider(context),
          _buildProfileField(
            context,
            l10n.email,
            'user@example.com',
            Icons.email_outlined,
          ),
          _buildDivider(context),
          _buildProfileField(
            context,
            l10n.peersId,
            'wfkbtfq',
            Icons.fingerprint_outlined,
          ),
          _buildDivider(context),
          _buildProfileField(
            context,
            l10n.myQrCode,
            '',
            Icons.qr_code_outlined,
            showTrailing: true,
          ),
          _buildDivider(context),
          _buildProfileField(
            context,
            l10n.whatsUp,
            '让大财务自由队伍，带领社会共同富裕。1000',
            Icons.edit_outlined,
            isMultiline: true,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileField(
    BuildContext context,
    String label,
    String value,
    IconData icon, {
    bool showTrailing = false,
    bool isMultiline = false,
    bool showAvatar = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (value.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                      value,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                        fontSize: 14,
                        height: isMultiline ? 1.4 : 1.0,
                      ),
                    maxLines: isMultiline ? null : 1,
                    overflow: isMultiline ? null : TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          if (showAvatar)
            GestureDetector(
              onTap: () => _navigateToAvatarChange(context),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                     color: Colors.black.withValues(alpha: 0.1),
                     blurRadius: 4,
                     offset: const Offset(0, 1),
                   ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Obx(() {
                    final deviceIdController = ControllerManager.deviceIdController;
                    final identiconInput = deviceIdController.getIdenticonInput();
                    
                    return SvgPicture.string(
                      Jdenticon.toSvg(identiconInput),
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    );
                  }),
                ),
              ),
            ),
          if (showTrailing)
            Icon(
              Icons.chevron_right,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.54),
              size: 20,
            ),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 48),
      height: 0.5,
      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.12),
    );
  }
}