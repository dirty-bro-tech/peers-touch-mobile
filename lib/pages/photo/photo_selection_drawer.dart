import 'package:flutter/material.dart';

class PhotoSelectionDrawer extends StatelessWidget {
  final Set<int> selectedPhotos;
  final ValueChanged<int> onPhotoSelected;
  final VoidCallback onSync;

  const PhotoSelectionDrawer({
    super.key,
    required this.selectedPhotos,
    required this.onPhotoSelected,
    required this.onSync,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Select Photos to Sync'),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => CheckboxListTile(
                title: Text('Photo ${index + 1}'),
                value: selectedPhotos.contains(index),
                onChanged: (bool? value) => onPhotoSelected(index),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: selectedPhotos.isEmpty ? null : onSync,
              child: const Text('Sync Selected Photos'),
            ),
          ),
        ],
      ),
    );
  }
}