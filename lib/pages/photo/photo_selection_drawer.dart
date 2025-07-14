import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pure_touch/controller/photo_controller.dart';

class PhotoSelectionDrawer extends StatelessWidget {
  const PhotoSelectionDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PhotoController>();

    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Select Photos to Sync'),
            actions: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Get.back(),
              ),
            ],
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: 10,
                itemBuilder:
                    (context, index) => CheckboxListTile(
                      title: Text('Photo ${index + 1}'),
                      value: controller.selectedPhotos.contains(index),
                      onChanged: (_) => controller.toggleSelection(index),
                    ),
              ),
            ),
          ),
          Obx(
            () => Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed:
                    controller.selectedPhotos.isEmpty
                        ? null
                        : controller.showSyncPhotoDrawer,
                child: const Text('Sync Selected Photos'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
