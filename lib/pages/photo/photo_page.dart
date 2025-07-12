import 'package:flutter/material.dart';

import 'package:pure_touch/pages/photo/photo_post_item.dart';
import 'package:pure_touch/pages/photo/profile_header.dart';
import 'package:pure_touch/pages/photo/avatar_overlay.dart';
import 'package:pure_touch/components/common/floating_action_ball.dart';



class PhotoPage extends StatelessWidget {
  static final List<FloatingActionOption> actionOptions = [
    FloatingActionOption(
      icon: Icons.cloud_sync,
      tooltip: 'Sync Photos',
      onPressed: () => print('Take Photo pressed'),
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

  const PhotoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none, // Add this to allow overflow
        children: [
          Column(
            children: [
              const ProfileHeader(),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 80), // Reduce top padding
                    itemCount: 10,
                    itemBuilder: (context, index) => const PhotoPostItem(),
                  ),
                ),
              ),
            ],
          ),
          const Positioned( // Use explicit positioning
            top: 150, // Half of header height (200 - 64/2)
            right: 16,
            child: AvatarOverlay(),
          ),
        ],
      ),
    );
  }
}

