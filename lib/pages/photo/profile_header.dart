import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pure_touch/controller/profile_controller.dart';
import 'package:pure_touch/components/common/fullscreen_image_viewer.dart';
import 'package:pure_touch/pages/photo/image_selection_page.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Obx(() => _buildContent(controller));
  }

  void _showFullscreenImage(ProfileController controller) {
    if (controller.hasProfileImage.value) {
      FullscreenImageViewerHelper.show(
        Get.context!,
        FileImage(controller.profileImage.value!),
        heroTag: 'profile_image',
        onEdit: () => Get.to(() => const ImageSelectionPage()),
      );
    } else {
      FullscreenImageViewerHelper.show(
        Get.context!,
        const AssetImage('assets/images/photo_profile_header_default.jpg'),
        heroTag: 'profile_image',
        onEdit: () => Get.to(() => const ImageSelectionPage()),
      );
    }
  }

  Widget _buildContent(ProfileController controller) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => _showFullscreenImage(controller),
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
              child: Stack(
                children: [
                  if (controller.isLoading.value)
                    const Center(child: CircularProgressIndicator())
                  else if (controller.hasProfileImage.value)
                    Hero(
                      tag: 'profile_image',
                      child: Image.file(
                        controller.profileImage.value!,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: double.infinity,
                            height: 200,
                            color: Colors.grey[400],
                            child: const Icon(
                              Icons.person,
                              size: 80,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    )
                  else
                    Hero(
                      tag: 'profile_image',
                      child: Image.asset(
                        'assets/images/photo_profile_header_default.jpg',
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: double.infinity,
                            height: 200,
                            color: Colors.grey[400],
                            child: const Icon(
                              Icons.person,
                              size: 80,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        // User name positioned closer to avatar
        Positioned(
          bottom: 4,
          right: 90,
          child: Text(
            'User Name',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black54,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }
}
