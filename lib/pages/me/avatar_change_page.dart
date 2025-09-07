import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdenticon_dart/jdenticon_dart.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pure_touch/controller/controller.dart';
import 'package:pure_touch/l10n/app_localizations.dart';

class AvatarChangePage extends StatelessWidget {
  const AvatarChangePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: colorScheme.onBackground,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          l10n.profilePhoto,
          style: TextStyle(
            color: colorScheme.onBackground,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Central Avatar Image
          Expanded(
            child: Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.onSurface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [                    BoxShadow(                      color: Colors.black.withOpacity(0.3),                      blurRadius: 20,                      offset: const Offset(0, 10),                    ),                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Obx(() {
                    final profileController = ControllerManager.profileController;
                    
                    if (profileController.hasProfileImage.value && profileController.profileImage.value != null) {
                      return Image.file(
                        profileController.profileImage.value!,
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      );
                    } else {
                      final deviceIdController = ControllerManager.deviceIdController;
                      final identiconInput = deviceIdController.getIdenticonInput();
                      
                      return SvgPicture.string(
                        Jdenticon.toSvg(identiconInput),
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      );
                    }
                  }),
                ),
              ),
            ),
          ),
          
          // Action Options
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildActionButton(
                  context,
                  'Take Photo',
                  Icons.camera_alt,
                  () => _takePhoto(context),
                ),
                const SizedBox(height: 12),
                _buildActionButton(
                  context,
                  'Choose from Album',
                  Icons.photo_library,
                  () => _chooseFromAlbum(context),
                ),
                const SizedBox(height: 12),
                _buildActionButton(
                  context,
                  'View Previous Profile Photo',
                  Icons.history,
                  () => _viewPreviousPhoto(context),
                ),
                const SizedBox(height: 12),
                _buildActionButton(
                  context,
                  'Save Photo',
                  Icons.save,
                  () => _savePhoto(context),
                ),
                const SizedBox(height: 20),
                _buildActionButton(
                  context,
                  'Cancel',
                  Icons.cancel,
                  () => Get.back(),
                  isCancel: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String text,
    IconData icon,
    VoidCallback onTap, {
    bool isCancel = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isCancel               ? Get.theme.colorScheme.surface.withOpacity(0.2)              : Get.theme.colorScheme.primary.withOpacity(0.1),          borderRadius: BorderRadius.circular(12),          border: Border.all(            color: Get.theme.colorScheme.onSurface.withOpacity(0.3),            width: 1,          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(                color: Get.theme.colorScheme.onSurface,                fontSize: 16,                fontWeight: FontWeight.w500,              ),
            ),
          ],
        ),
      ),
    );
  }

  void _takePhoto(BuildContext context) async {
    final profileController = ControllerManager.profileController;
    try {
      await profileController.takePhoto();
      Get.snackbar(
        'Success',
        'Photo taken successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to take photo: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _chooseFromAlbum(BuildContext context) async {
    final profileController = ControllerManager.profileController;
    try {
      await profileController.chooseFromAlbum();
      Get.snackbar(
        'Success',
        'Photo selected from album',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to select photo: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _viewPreviousPhoto(BuildContext context) {
    final profileController = ControllerManager.profileController;
    // TODO: Implement view previous photo functionality
    Get.snackbar(
      'Not Implemented',
      'View Previous Photo - Not implemented yet',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _savePhoto(BuildContext context) async {
    final profileController = ControllerManager.profileController;
    try {
      await profileController.saveCurrentImage();
      Get.snackbar(
        'Success',
        'Photo saved successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save photo: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}