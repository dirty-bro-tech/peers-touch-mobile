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
    
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          l10n.profilePhoto,
          style: const TextStyle(
            color: Colors.white,
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Obx(() {
                    final deviceIdController = ControllerManager.deviceIdController;
                    final identiconInput = deviceIdController.getIdenticonInput();
                    
                    return SvgPicture.string(
                      Jdenticon.toSvg(identiconInput),
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    );
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
                  () => Navigator.of(context).pop(),
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
          color: isCancel 
              ? Colors.grey.withOpacity(0.2)
              : Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 1,
          ),
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
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _takePhoto(BuildContext context) {
    // TODO: Implement take photo functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Take Photo - Not implemented yet')),
    );
  }

  void _chooseFromAlbum(BuildContext context) {
    // TODO: Implement choose from album functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Choose from Album - Not implemented yet')),
    );
  }

  void _viewPreviousPhoto(BuildContext context) {
    // TODO: Implement view previous photo functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('View Previous Photo - Not implemented yet')),
    );
  }

  void _savePhoto(BuildContext context) {
    // TODO: Implement save photo functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Save Photo - Not implemented yet')),
    );
  }
}