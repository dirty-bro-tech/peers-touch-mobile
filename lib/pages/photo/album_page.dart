import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pure_touch/controller/album_controller.dart';
import 'package:pure_touch/pages/photo/album_list.dart';
import 'package:pure_touch/components/common/floating_action_ball.dart';

class AlbumPage extends StatelessWidget {
  static final List<FloatingActionOption> actionOptions = [
    FloatingActionOption(
      icon: Icons.cloud_sync,
      tooltip: 'Sync Selected Albums',
      onPressed: () {
        final controller = Get.find<AlbumController>();
        if (controller.selectedAlbums.isEmpty) {
          Get.snackbar('No Albums Selected', 'Please select at least one album to sync');
          return;
        }
        controller.uploadSelectedAlbums().then((success) {
          if (success) {
            Get.snackbar('Success', 'Albums synced successfully');
          } else {
            Get.snackbar('Error', 'Failed to sync albums');
          }
        }).catchError((e) {
          Get.snackbar('Error', 'An unexpected error occurred: $e');
        });
      },
    ),
    FloatingActionOption(
      icon: Icons.select_all,
      tooltip: 'Select All',
      onPressed: () {
        final controller = Get.find<AlbumController>();
        // Add all albums to selected albums
        controller.selectedAlbums.addAll(controller.albums);
      },
    ),
    FloatingActionOption(
      icon: Icons.deselect,
      tooltip: 'Deselect All',
      onPressed: () {
        final controller = Get.find<AlbumController>();
        controller.selectedAlbums.clear();
      },
    ),
  ];

  const AlbumPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure AlbumController is initialized
    Get.put(AlbumController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Albums'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  title: const Text('Album Sync'),
                  content: const Text(
                    'Select albums to sync with your account. '
                    'Synced albums will be available across all your devices.'
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: const AlbumListWidget(),
      floatingActionButton: FloatingActionBall(options: actionOptions),
    );
  }
}