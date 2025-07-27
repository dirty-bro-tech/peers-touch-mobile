import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:photo_manager/photo_manager.dart';
import 'package:pure_touch/model/photo_model.dart';

import 'package:pure_touch/pages/photo/photo_selection_sheet.dart';

class PhotoController extends GetxController {
  final selectedPhotos = <int>{}.obs;
  final syncedPhotos = <int>{}.obs;
  final photos = <PhotoModel>[].obs;
  final albums = <AssetPathEntity>[].obs;
  final selectedAlbums = <AssetPathEntity>{}.obs;
  final syncedAlbums = <AssetPathEntity>{}.obs;
  final _isShowSyncPhotoDrawerRunning = false.obs;
  final Rx<AssetPathEntity?> currentSelectedAlbum = Rx<AssetPathEntity?>(null);

  // Request permission to access photos
  Future<void> loadAlbums() async {
    final PermissionState permission =
        await PhotoManager.requestPermissionExtend();
    if (permission != PermissionState.authorized) {
      Get.snackbar("Permission Denied", "Need media access to load albums");
      return;
    }

    // Get all media asset paths (albums)
    final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
      type: RequestType.common,
    );
    albums.assignAll(paths);
  }

  // Updated to load photos from system
  Future<void> loadPhotos() async {
    final PermissionState permission =
        await PhotoManager.requestPermissionExtend();
    if (permission != PermissionState.authorized) {
      Get.snackbar("Permission Denied", "Need photo access to load images");
      return;
    }

    // Get image assets from system gallery
    final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
      onlyAll: true,
      type: RequestType.image,
    );
    if (paths.isEmpty) return;

    // Get first 100 images from the "All Photos" album
    final List<AssetEntity> assets = await paths.first.getAssetListPaged(
      page: 0,
      size: 100,
    );
    final List<PhotoModel> systemPhotos = [];

    for (final asset in assets) {
      final file = await asset.file;
      if (file != null) {
        systemPhotos.add(
          PhotoModel(
            id: int.tryParse(asset.id) ?? asset.id.hashCode,
            path: file.path,
          ),
        );
      }
    }

    photos.assignAll(systemPhotos);
  }

  Future<bool> checkStorageSpace() async {
    try {
      final directory = await getTemporaryDirectory();
      final stat = await directory.stat();
      final freeSpace = stat.size;
      // Assume we need at least 100MB for loading photos
      const requiredSpace = 100 * 1024 * 1024;
      return freeSpace > requiredSpace;
    } catch (e) {
      if (kDebugMode) {
        print('Error checking storage space: $e');
      }
      return false;
    }
  }

  Future<void> loadPhotosForAlbum(AssetPathEntity album) async {
    final hasEnoughSpace = await checkStorageSpace();
    if (!hasEnoughSpace) {
      Get.snackbar(
        'Storage Error',
        'Not enough storage space on the device to load photos.',
      );
      return;
    }

    try {
      photos.clear();
      currentSelectedAlbum.value = album;
      final List<AssetEntity> assets = await album.getAssetListRange(
        start: 0,
        end: 9999,
      );
      final List<PhotoModel> albumPhotos = [];

      for (final asset in assets) {
        final file = await asset.file;
        if (file != null) {
          albumPhotos.add(
            PhotoModel(
              id: int.tryParse(asset.id) ?? asset.id.hashCode,
              path: file.path,
            ),
          );
        }
      }

      photos.assignAll(albumPhotos);
    } catch (e) {
      print('Error loading photos for album: $e');
      Get.snackbar('Error', 'Failed to load photos for album: $e');
    }
  }

  void togglePhotoSelection(int photoId) {
    if (selectedPhotos.contains(photoId)) {
      selectedPhotos.remove(photoId);
    } else {
      selectedPhotos.add(photoId);
    }
  }

  void toggleAlbumSelection(AssetPathEntity album) {
    if (selectedAlbums.contains(album)) {
      selectedAlbums.remove(album);
    } else {
      selectedAlbums.add(album);
    }
  }

  // Upload method to sync selected albums
  Future<bool> uploadSelectedAlbums() async {
    final url = Uri.parse('http://192.168.31.19:8082/family/photo/sync');
    final request = http.MultipartRequest('POST', url);

    try {
      for (final album in selectedAlbums) {
        final List<AssetEntity> assets = await album.getAssetListRange(
          start: 0,
          end: 9999,
        );
        for (final asset in assets) {
          final file = await asset.file;
          if (file != null) {
            final stream = http.ByteStream(file.openRead());
            final length = await file.length();
            final multipartFile = http.MultipartFile(
              'media',
              stream,
              length,
              filename: file.path.split('/').last,
            );
            request.files.add(multipartFile);
          }
        }
      }

      final response = await request.send();
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);

      if (response.statusCode == 200) {
        // Mark selected albums as synced
        syncedAlbums.addAll(selectedAlbums);
        // Clear selected albums after successful upload
        selectedAlbums.clear();
        return true;
      } else {
        print(
          'Upload failed with status: ${response.statusCode}, Response: $responseString',
        );
        return false;
      }
    } catch (e) {
      print('Error uploading albums: $e');
      return false;
    }
  }

  // Upload method to sync selected photos
  Future<bool> uploadSelectedPhotos() async {
    final url = Uri.parse('http://192.168.31.19:8082/family/photo/sync');
    final request = http.MultipartRequest('POST', url);

    try {
      for (final photoId in selectedPhotos) {
        final photo = photos.firstWhereOrNull((p) => p.id == photoId);
        if (photo != null) {
          final file = File(photo.path);
          if (await file.exists()) {
            final stream = http.ByteStream(file.openRead());
            final length = await file.length();
            final multipartFile = http.MultipartFile(
              'photo',
              stream,
              length,
              filename: file.path.split('/').last,
            );
            request.files.add(multipartFile);
          }
        }
      }

      final response = await request.send();
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);

      if (response.statusCode == 200) {
        // Mark selected photos as synced
        syncedPhotos.addAll(selectedPhotos);
        // Clear selected photos after successful upload
        selectedPhotos.clear();
        return true;
      } else {
        print(
          'Upload failed with status: ${response.statusCode}, Response: $responseString',
        );
        return false;
      }
    } catch (e) {
      print('Error uploading photos: $e');
      return false;
    }
  }

  Future<void> showSyncPhotoDrawer() async {
    if (_isShowSyncPhotoDrawerRunning.value) return;
    _isShowSyncPhotoDrawerRunning.value = true;

    try {
      if (albums.isEmpty) await loadAlbums();
      if (photos.isEmpty) await loadPhotos();

      // Assume PhotoSelectionSheet is implemented properly
      await Get.bottomSheet(
        const PhotoSelectionSheet(),
        isScrollControlled: true,
      ).whenComplete(() {
        // Clear data when the drawer is closed
        clearAlbumAndPhotoData();
      });
    } catch (e) {
      print('Error showing sync photo drawer: $e');
    } finally {
      _isShowSyncPhotoDrawerRunning.value = false;
    }
  }

  void clearAlbumAndPhotoData() {
    photos.clear();
    selectedPhotos.clear();
    syncedPhotos.clear();
    selectedAlbums.clear();
    syncedAlbums.clear();
    currentSelectedAlbum.value = null;
    update();
  }
}
