import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';

import 'package:pure_touch/model/photo_model.dart';
import 'package:pure_touch/pages/photo/photo_selection_sheet.dart';
import 'package:photo_manager/photo_manager.dart';

class PhotoController extends GetxController {
  final selectedPhotos = <int>{}.obs;
  final syncedPhotos = <int>{}.obs; // Added for sync status tracking
  final photos = <PhotoModel>[].obs; // Added photo list
  final albums = <AssetPathEntity>[].obs;
  final selectedAlbums = <AssetPathEntity>{}.obs;
  final syncedAlbums = <AssetPathEntity>{}.obs;
  final Rx<AssetPathEntity?> currentSelectedAlbum = Rx<AssetPathEntity?>(null);

  // Updated to load all media types and albums
  Future<void> loadAlbums() async {
    final PermissionState permission =
        await PhotoManager.requestPermissionExtend();
    if (permission != PermissionState.authorized) {
      Get.snackbar("Permission Denied", "Need media access to load albums");
      return;
    }

    // Get all media asset paths (albums)
    final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
      type: RequestType.common, // Get all media types
    );
    albums.assignAll(paths);
  }

  void toggleAlbumSelection(AssetPathEntity album) {
    if (selectedAlbums.contains(album)) {
      selectedAlbums.remove(album);
    } else {
      selectedAlbums.add(album);
    }
  }

  Future<void> loadPhotosForAlbum(AssetPathEntity album) async {
    try {
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

  // Upload method to sync selected albums
  Future<bool> uploadSelectedAlbums() async {
    final url = Uri.parse('http://192.168.31.19:8082/family/photo/sync');
    final request = http.MultipartRequest('POST', url);

    try {
      for (final album in selectedAlbums) {
        final List<AssetEntity> assets = await album.getAssetListRange(
          start: 0,
          end: 9999, // Get all assets in the album
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

  // Updated to load from system photos using photo_manager
  // Request permission to access photos
  // Updated permission request using standard method
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
      final file = await asset.file; // Get file path from asset
      if (file != null) {
        systemPhotos.add(
          PhotoModel(
            id: int.tryParse(asset.id) ?? asset.id.hashCode,
            // Fallback to hash if ID isn't numeric
            path: file.path,
          ),
        );
      }
    }

    photos.assignAll(systemPhotos);
  }

  void togglePhotoSelection(int photoId) {
    if (selectedPhotos.contains(photoId)) {
      selectedPhotos.remove(photoId);
    } else {
      selectedPhotos.add(photoId);
    }
  }

  Future<void> showSyncPhotoDrawer() async {
    if (albums.isEmpty) await loadAlbums();
    if (photos.isEmpty) await loadPhotos(); // Load photos first

    // Show bottom sheet using the new UI component
    await Get.bottomSheet(
      const PhotoSelectionSheet(),
      isScrollControlled: true,
    );
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
}
