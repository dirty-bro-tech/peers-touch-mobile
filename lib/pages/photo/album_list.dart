import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../controller/album_controller.dart';
import '../../controller/photo_controller.dart';

class AlbumListWidget extends StatelessWidget {
  const AlbumListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final AlbumController controller = Get.find<AlbumController>();
    controller.loadAlbums();

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
                      .then((assets) => assets.isNotEmpty ? assets.first : null),
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
                  final PhotoController photoController = Get.find<PhotoController>();
                  photoController.loadPhotosForAlbum(album);
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: controller.selectedAlbums.isNotEmpty
                ? () async {
                    try {
                      final success = await controller.uploadSelectedAlbums();
                      if (success) {
                        Get.snackbar('Success', 'Albums synced successfully');
                      } else {
                        Get.snackbar('Error', 'Failed to sync albums');
                      }
                    } catch (e) {
                      Get.snackbar('Error', 'An unexpected error occurred: $e');
                    }
                  }
                : null,
            child: const Text('Sync Selected Albums'),
          ),
        ),
      ],
    );
  }
}
