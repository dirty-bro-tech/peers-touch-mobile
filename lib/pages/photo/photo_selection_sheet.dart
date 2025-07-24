import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:photo_manager/photo_manager.dart';

import 'package:pure_touch/controller/controller.dart';

class PhotoSelectionSheet extends StatelessWidget {
  const PhotoSelectionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ControllerManager.photoController;
    return Container(
      height: Get.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Obx(() {
        if (controller.currentSelectedAlbum.value == null) {
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Sync Albums', style: TextStyle(fontSize: 18)),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.albums.length,
                  itemBuilder: (context, index) {
                    final album = controller.albums[index];
                    return ListTile(
                      leading: FutureBuilder<AssetEntity?>(
                        future: album
                            .getAssetListRange(start: 0, end: 1)
                            .then(
                              (assets) =>
                                  assets.isNotEmpty ? assets.first : null,
                            ),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data != null) {
                            return FutureBuilder<File?>(
                              future: snapshot.data!.file,
                              builder: (context, fileSnapshot) {
                                if (fileSnapshot.hasData) {
                                  return Image.file(
                                    fileSnapshot.data!,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  );
                                }
                                return const Icon(Icons.image);
                              },
                            );
                          }
                          return const Icon(Icons.image);
                        },
                      ),
                      title: Text(album.name),
                      subtitle: FutureBuilder<int>(
                        future: album.assetCountAsync,
                        builder: (context, countSnapshot) {
                          if (countSnapshot.hasData) {
                            return Text('${countSnapshot.data} items');
                          } else if (countSnapshot.hasError) {
                            return Text('Error loading count');
                          }
                          return const Text('Loading...');
                        },
                      ),
                      trailing: Checkbox(
                        value: controller.selectedAlbums.contains(album),
                        onChanged: (value) {
                          if (value != null) {
                            controller.toggleAlbumSelection(album);
                          }
                        },
                      ),
                      onTap: () {
                        controller.loadPhotosForAlbum(album);
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed:
                      controller.selectedAlbums.isNotEmpty
                          ? () async {
                            try {
                              final success =
                                  await controller.uploadSelectedAlbums();
                              if (success) {
                                Get.snackbar(
                                  'Success',
                                  'Albums synced successfully',
                                );
                              } else {
                                Get.snackbar('Error', 'Failed to sync albums');
                              }
                            } catch (e) {
                              Get.snackbar(
                                'Error',
                                'An unexpected error occurred: $e',
                              );
                            }
                          }
                          : null,
                  child: const Text('Sync Selected Albums'),
                ),
              ),
            ],
          );
        } else {
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
                        controller.currentSelectedAlbum.value = null;
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
                child: GridView.builder(
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
                        controller.togglePhotoSelection(photo.id);
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
                              future:
                                  isVideoFile(photo.path)
                                      ? getVideoThumbnail(photo.path)
                                      : Future.value(File(photo.path)),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Image.file(
                                    snapshot.data!,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.broken_image),
                                  );
                                } else if (snapshot.hasError) {
                                  return const Icon(Icons.broken_image);
                                }
                                return const CircularProgressIndicator();
                              },
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
                              final isSelected = controller.selectedPhotos
                                  .contains(photo.id);
                              return Container(
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: isSelected ? Colors.blue : Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                                child: Opacity(
                                  opacity: isSelected ? 1 : 0,
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed:
                      controller.selectedPhotos.isNotEmpty
                          ? () async {
                            try {
                              final success =
                                  await controller.uploadSelectedPhotos();
                              if (success) {
                                Get.snackbar(
                                  'Success',
                                  'Photos synced successfully',
                                );
                              } else {
                                Get.snackbar('Error', 'Failed to sync photos');
                              }
                            } catch (e) {
                              Get.snackbar(
                                'Error',
                                'An unexpected error occurred: $e',
                              );
                            }
                          }
                          : null,
                  child: const Text('Sync Selected Photos'),
                ),
              ),
            ],
          );
        }
      }),
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
