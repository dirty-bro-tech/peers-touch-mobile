import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdenticon_dart/jdenticon_dart.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pure_touch/controller/controller.dart';
import 'package:pure_touch/pages/me/me_profile.dart';
import 'package:pure_touch/l10n/app_localizations.dart';

class UserProfileHeader extends StatelessWidget {
  const UserProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final meController = ControllerManager.meController;
    
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Main profile row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center, // Align avatar and text properly
            children: [
              // Avatar
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Obx(() {
                    final deviceIdController = ControllerManager.deviceIdController;
                    final identiconInput = deviceIdController.getIdenticonInput();
                    
                    return SvgPicture.string(
                      Jdenticon.toSvg(identiconInput),
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    );
                  }),
                ),
              ),
              const SizedBox(width: 16),
              
              // User Info - aligned with avatar center
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center, // Center align with avatar
                  children: [
                    Obx(() => Text(
                      meController.userName.value,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                    const SizedBox(height: 4),
                    Obx(() => Text(
                      '${l10n.peersId}: ${meController.peersId.value}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 14,
                      ),
                    )),
                  ],
                ),
              ),
              
              // QR Code with navigation arrow
              Container(
                width: 80, // Fixed width for right side elements
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end, // Ensure right alignment
                  mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                  children: [
                    IconButton(
                      onPressed: () {
                        // TODO: Show QR code
                      },
                      icon: Icon(
                        Icons.qr_code,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                        size: 24,
                      ),
                    ),
                    // Navigation arrow under QR code
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MeProfilePage(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Status and friends row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ensure proper spacing
            children: [
              Text(
                '+ Status',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end, // Right align friends info
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      width: 150, // Fixed width for friends text
                      child: Text(
                        'and other friends (4)',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.right, // Right align text
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}