import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../controller/photo_controller.dart';

class PhotoGridWidget extends StatelessWidget {
  const PhotoGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final PhotoController controller = Get.find<PhotoController>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  controller.clearAlbumAndPhotoData();
                },
              ),
              Text(
                controller.currentSelectedAlbum.value!.name,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 100,
              ),
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                itemCount: controller.photos.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final photo = controller.photos[index];
                  return GestureDetector(
                    onTap: () {
                      controller.togglePhotoSelection(photo.id.hashCode);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Stack(
                      key: ValueKey(photo.id),
                      fit: StackFit.expand,
                      children: [
                        const SizedBox.expand(),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: FutureBuilder<File?>(
                            future: isVideoFile(photo.path)
                                ? getVideoThumbnail(photo.path)
                                : Future.value(File(photo.path)),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Image.file(
                                  snapshot.data!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.broken_image),
                                );
                              } else if (snapshot.hasError) {
                                return const Icon(Icons.broken_image);
                              }
                              return const CircularProgressIndicator();
                            },
                          ),
                        ),
                        if (controller.syncedPhotos.contains(photo.id.hashCode))
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: controller.selectedPhotos
                                      .contains(photo.id.hashCode)
                                  ? Colors.blue
                                  : Colors.grey,
                              shape: BoxShape.circle,
                            ),
                            child: Opacity(
                              opacity: controller.selectedPhotos
                                      .contains(photo.id.hashCode)
                                  ? 1
                                  : 0,
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: controller.selectedPhotos.isNotEmpty
                ? () async {
                    try {
                      final success = await controller.uploadSelectedPhotos();
                      if (success) {
                        Get.snackbar('Success', 'Photos synced successfully');
                      } else {
                        Get.snackbar('Error', 'Failed to sync photos');
                      }
                    } catch (e) {
                      Get.snackbar('Error', 'An unexpected error occurred: $e');
                    }
                  }
                : null,
            child: const Text('Sync Selected Photos'),
          ),
        ),
      ],
    );
  }

  /// Generates a video thumbnail from the given video path.
  ///
  /// Returns a [Future<File?>] representing the thumbnail file.
  Future<File?> getVideoThumbnail(String videoPath) async {
    try {
      final thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: videoPath,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.JPEG,
        maxHeight: 50,
        maxWidth: 50,
        quality: 75,
      );
      return thumbnailPath != null ? File(thumbnailPath) : null;
    } catch (e) {
      print('Error generating video thumbnail: $e');
      return null;
    }
  }

  bool isVideoFile(String path) {
    final ext = path.split('.').last.toLowerCase();
    return ['mp4', 'mov', 'avi', 'mkv'].contains(ext);
  }
}
