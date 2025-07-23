import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pure_touch/controller/controller.dart';
import 'dart:io'; // Add this import for File class

class PhotoSelectionSheet extends StatelessWidget {
  const PhotoSelectionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ControllerManager.photoController;
    return Container(
      height: Get.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Select Photos to Sync',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            child: Obx(() {
              // Force Obx to track selectedPhotos by accessing it here
              final _ = controller.selectedPhotos; // Dummy access
              return GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                itemCount: controller.photos.length,
                itemBuilder: (context, index) {
                  final photo = controller.photos[index];
                  return GestureDetector(
                    onTap: () {
                      print('Tapped photo ID: ${photo.id}');
                      controller.toggleSelection(photo.id);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Stack(
                      key: ValueKey(photo.id),
                      fit: StackFit.expand,
                      children: [
                        const SizedBox.expand(),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(photo.path),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image),
                          ),
                        ),
                        if (controller.syncedPhotos.contains(photo.id))
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Obx(() {
                            // Create a reactive variable for the color
                            final isSelected = controller.selectedPhotos.contains(photo.id).obs;
                            return Container(
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: isSelected.value ? Colors.blue : Colors.grey,
                                shape: BoxShape.circle,
                              ),
                              child: Opacity(
                                opacity: isSelected.value ? 1 : 0,
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: controller.showSyncPhotoDrawer,
              child: const Text('Start Sync'),
            ),
          ),
        ],
      ),
    );
  }
}
