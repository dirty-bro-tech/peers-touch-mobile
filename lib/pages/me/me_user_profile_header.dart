import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdenticon_dart/jdenticon_dart.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pure_touch/controller/controller.dart';
import 'package:pure_touch/pages/me/me_profile.dart';

class UserProfileHeader extends StatelessWidget {
  const UserProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
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
                    Text(
                      'Little First',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Weixin ID: wfkbtfq',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              
              // QR Code with navigation arrow
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      // TODO: Show QR code
                    },
                    icon: Icon(
                      Icons.qr_code,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                      size: 24,
                    ),
                  ),
                  // Navigation arrow under QR code
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const MeProfilePage(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Status and friends row
          Row(
            children: [
              Text(
                '+ Status',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        'and other friends (4)',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                          fontSize: 14,
                        ),
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