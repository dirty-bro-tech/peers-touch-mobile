import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pure_touch/controller/controller.dart';

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
            child: Obx(
              () => GridView.builder(
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
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      // Photo display (replace with actual image loading)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/photos/${photo.id}.jpg', // Example path
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Synced status cover
                      if (controller.syncedPhotos.contains(photo.id))
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      // Selection indicator
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: Opacity(
                            opacity:
                                controller.selectedPhotos.contains(photo.id)
                                    ? 1
                                    : 0,
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
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
