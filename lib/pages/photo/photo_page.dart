import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:pure_touch/controller/photo_controller.dart';
import 'package:pure_touch/pages/photo/photo_post_item.dart';
import 'package:pure_touch/pages/photo/profile_header.dart';
import 'package:pure_touch/pages/photo/avatar_overlay.dart';
import 'package:pure_touch/components/common/floating_action_ball.dart';

import 'package:pure_touch/controller/controller.dart';

class PhotoPage extends GetView<PhotoController> {
  static final List<FloatingActionOption> actionOptions = [
    FloatingActionOption(
      icon: Icons.cloud_sync,
      tooltip: 'Sync Photos',
      onPressed: () => ControllerManager.photoController.showSyncPhotoDrawer(),
    ),
    FloatingActionOption(
      icon: Icons.camera_alt,
      tooltip: 'Take Photo',
      onPressed: () => print('Take Photo pressed'),
    ),
    FloatingActionOption(
      icon: Icons.photo_library,
      tooltip: 'Upload Photo',
      onPressed: () => print('Upload Photo pressed'),
    ),
  ];

  // Add a key to track the header's size
  final GlobalKey _headerKey = GlobalKey();

  double _getHeaderHeight() {
    final headerBox =
        _headerKey.currentContext?.findRenderObject() as RenderBox?;
    return headerBox?.size.height ?? 200; // Fallback if measurement fails
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 0),
        itemCount: 11, // Revert to original count (header + 10 posts)
        itemBuilder: (context, index) {
          if (index == 0) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                SizedBox(key: _headerKey, child: const ProfileHeader()),
                Positioned(
                  top: _getHeaderHeight() - 38,
                  right: 16,
                  child: const AvatarOverlay(),
                ),
              ],
            );
          } else if (index == 1) {
            // New divider between header and posts
            return Divider(
              height: _getHeaderHeight() - 140,
              // Thin line
              thickness: 0.1,
              color: Colors.grey,
              indent: 16,
              // Left margin
              endIndent: 16, // Right margin
            );
          } else {
            // Post items (adjust index by -1 to account for divider)
            return const PhotoPostItem();
          }
          return const PhotoPostItem();
        },
      ),
    );
  }
}
