import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';


import 'package:pure_touch/controller/album_controller.dart';
import 'package:pure_touch/controller/photo_controller.dart';
import 'package:pure_touch/controller/controller.dart';

class AlbumListWidget extends GetView<AlbumController> {
  const AlbumListWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    final scrollController = ControllerManager.scrollController.getScrollController('album_list');
    
    // Load albums only once when widget is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.albums.isEmpty) {
        controller.loadAlbums();
      }
    });

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text('Sync Albums', style: TextStyle(fontSize: 18)),
        ),
        Expanded(
          child: Obx(() => controller.albums.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  controller: scrollController,
                  itemCount: controller.albums.length,
                  itemBuilder: (context, index) {
                    final album = controller.albums[index];
                    return ListTile(
                      leading: _AlbumThumbnail(album: album),
                      title: Text(album.name),
                      subtitle: _AlbumCountSubtitle(album: album),
                      trailing: Obx(() => Checkbox(
                        value: controller.selectedAlbums.contains(album),
                        onChanged: (value) {
                          if (value != null) {
                            controller.toggleAlbumSelection(album);
                          }
                        },
                      )),
                      onTap: () {
                        // Navigate to photo list when tapping on album
                        final PhotoController photoController = Get.find<PhotoController>();
                        if (kDebugMode) {
                          print('Album tapped: ${album.name}');
                        }
                        photoController.loadPhotosForAlbum(album);
                      },
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Obx(() => ElevatedButton(
                onPressed: controller.selectedAlbums.isNotEmpty
                    ? () async {
                        try {
                          final PhotoController photoController = Get.find<PhotoController>();
                          
                          // Check if there are albums to sync
                          if (controller.selectedAlbums.isEmpty) {
                            Get.snackbar('Warning', 'No albums selected for sync');
                            return;
                          }
                          
                          // Check network connectivity (basic check)
                          final success = await photoController.uploadSelectedPhotos();
                          if (success) {
                            Get.snackbar('Success', 'Albums synced successfully');
                          } else {
                            Get.snackbar(
                              'Sync Failed', 
                              'Upload failed. Check:\n• Network connection\n• Server availability\n• Photo permissions\n• Storage space',
                              duration: const Duration(seconds: 5),
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        } catch (e) {
                          String errorMsg = 'Sync error: ';
                          if (e.toString().contains('SocketException')) {
                            errorMsg += 'Network connection failed';
                          } else if (e.toString().contains('TimeoutException')) {
                            errorMsg += 'Request timed out';
                          } else if (e.toString().contains('FormatException')) {
                            errorMsg += 'Invalid server response';
                          } else if (e.toString().contains('Permission')) {
                            errorMsg += 'Photo access permission denied';
                          } else {
                            errorMsg += e.toString();
                          }
                          Get.snackbar(
                            'Error', 
                            errorMsg,
                            duration: const Duration(seconds: 5),
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      }
                    : null,
                child: Text('Sync Selected Albums (${controller.selectedAlbums.length})'),
              )),
            ),
          ],
        );
  }
}

class _AlbumThumbnail extends StatefulWidget {
  final AssetPathEntity album;
  
  const _AlbumThumbnail({required this.album});
  
  @override
  State<_AlbumThumbnail> createState() => _AlbumThumbnailState();
}

class _AlbumThumbnailState extends State<_AlbumThumbnail> {
  AssetEntity? _firstAsset;
  Uint8List? _thumbnailData;
  bool _loading = true;
  bool _hasError = false;
  
  @override
  void initState() {
    super.initState();
    _loadThumbnail();
  }
  
  @override
  void didUpdateWidget(_AlbumThumbnail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.album != widget.album) {
      _loading = true;
      _hasError = false;
      _thumbnailData = null;
      _firstAsset = null;
      _loadThumbnail();
    }
  }
  
  Future<void> _loadThumbnail() async {
    try {
      final assets = await widget.album.getAssetListRange(start: 0, end: 1);
      if (assets.isNotEmpty) {
        _firstAsset = assets.first;
        // Use a smaller thumbnail size for better performance
        _thumbnailData = await _firstAsset!.thumbnailDataWithSize(const ThumbnailSize(120, 120));
      }
    } catch (e) {
      _hasError = true;
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))),
      );
    }
    
    if (_hasError || _firstAsset == null || _thumbnailData == null) {
      return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Icon(Icons.photo_album, color: Colors.grey),
      );
    }
    
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        image: DecorationImage(
          image: MemoryImage(_thumbnailData!),
          fit: BoxFit.cover,
        ),
      ),
      child: _firstAsset!.type == AssetType.video
        ? const Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.all(2.0),
              child: Icon(Icons.videocam, color: Colors.white, size: 16),
            ),
          )
        : null,
    );
  }
}

class _AlbumCountSubtitle extends StatefulWidget {
  final AssetPathEntity album;
  
  const _AlbumCountSubtitle({required this.album});
  
  @override
  State<_AlbumCountSubtitle> createState() => _AlbumCountSubtitleState();
}

class _AlbumCountSubtitleState extends State<_AlbumCountSubtitle> {
  int? _count;
  bool _loading = true;
  bool _hasError = false;
  
  @override
  void initState() {
    super.initState();
    _loadCount();
  }
  
  @override
  void didUpdateWidget(_AlbumCountSubtitle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.album != widget.album) {
      _loading = true;
      _hasError = false;
      _count = null;
      _loadCount();
    }
  }
  
  Future<void> _loadCount() async {
    try {
      _count = await widget.album.assetCountAsync;
    } catch (e) {
      _hasError = true;
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Text('Loading...', style: TextStyle(color: Colors.grey));
    }
    
    if (_hasError || _count == null) {
      return const Text('Error loading count', style: TextStyle(color: Colors.red));
    }
    
    return Text('$_count items');
  }
}
