import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:photo_manager/photo_manager.dart';
import 'package:pure_touch/model/photo_model.dart';

import 'package:pure_touch/pages/photo/photo_selection_sheet.dart';

class PhotoController extends GetxController {
  // Static method channel for storage operations
  static const MethodChannel _storageChannel = MethodChannel('samples.flutter.dev/storage');
  
  final selectedPhotos = <int>{}.obs;
  final syncedPhotos = <int>{}.obs;
  final photos = <PhotoModel>[].obs;
  final albums = <AssetPathEntity>[].obs;
  final selectedAlbums = <AssetPathEntity>{}.obs;
  final syncedAlbums = <AssetPathEntity>{}.obs;
  final _isShowSyncPhotoDrawerRunning = false.obs;
  final Rx<AssetPathEntity?> currentSelectedAlbum = Rx<AssetPathEntity?>(null);
  
  @override
  void onInit() {
    super.onInit();
    // Initialize the method channel when the controller is created
    _initializeMethodChannel();
  }

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
      if (kDebugMode) {
        print('Starting storage space check...');
      }
      
      // Initialize the method channel early if needed
      if (!_isMethodChannelInitialized) {
        if (kDebugMode) {
          print('Method channel not initialized, initializing now...');
        }
        await _initializeMethodChannel();
      }
      
      if (kDebugMode) {
        print('Getting temporary directory...');
      }
      final directory = await getTemporaryDirectory();
      
      if (kDebugMode) {
        print('Temporary directory path: ${directory.path}');
      }
      
      final freeSpace = await _getFreeDiskSpace(directory);
      // Assume we need at least 100MB for loading photos
      const requiredSpace = 100 * 1024 * 1024; // 100MB
      
      if (kDebugMode) {
        print('Available storage space: ${(freeSpace / (1024 * 1024)).toStringAsFixed(2)} MB');
        print('Required storage space: ${(requiredSpace / (1024 * 1024)).toStringAsFixed(2)} MB');
        print('Storage check result: ${freeSpace > requiredSpace ? 'SUFFICIENT' : 'INSUFFICIENT'} space');
      }
      
      return freeSpace > requiredSpace;
    } catch (e) {
      if (kDebugMode) {
        print('Error checking storage space: $e');
        print('Stack trace: ${StackTrace.current}');
        print('Assuming sufficient space due to error');
      }
      // In case of error, we'll assume there's enough space to avoid false negatives
      // This is safer than blocking the user unnecessarily
      return true;
    }
  }
  
  // Flag to track if method channel is initialized
  static bool _isMethodChannelInitialized = false;
  
  // Initialize the method channel
  Future<void> _initializeMethodChannel() async {
    if (_isMethodChannelInitialized) return;
    
    try {
      // Try to make a simple call to initialize the channel
      // Add a longer delay to ensure the platform side has time to register
      await Future.delayed(const Duration(milliseconds: 500));
      
      await _storageChannel.invokeMethod('getFreeDiskSpace').catchError((error) {
        // Ignore errors during initialization
        if (kDebugMode) {
          print('Method channel initialization error (expected): $error');
        }
      });
    } catch (e) {
      // Ignore errors during initialization
      if (kDebugMode) {
        print('Method channel initialization exception (expected): $e');
      }
    }
    
    _isMethodChannelInitialized = true;
  }

  Future<int> _getFreeDiskSpace(Directory directory) async {
    try {
      // First try to use the platform-specific implementation
      if (Platform.isAndroid || Platform.isIOS) {
        try {
          // Add a longer delay to ensure the method channel is registered
          await Future.delayed(const Duration(milliseconds: 500));
          
          if (kDebugMode) {
            print('Attempting to get free disk space via method channel...');
          }
          
          final Map<String, dynamic>? result = await _storageChannel.invokeMapMethod<String, dynamic>('getFreeDiskSpace');
          if (result != null && result.containsKey('freeSpace')) {
            final freeSpace = result['freeSpace'];
            // Convert to int if it's not already
            if (freeSpace is int) {
              if (kDebugMode) {
                print('Successfully got free space from method channel: ${(freeSpace / (1024 * 1024)).toStringAsFixed(2)} MB');
              }
              return freeSpace;
            } else if (freeSpace is double) {
              if (kDebugMode) {
                print('Successfully got free space from method channel (double): ${(freeSpace / (1024 * 1024)).toStringAsFixed(2)} MB');
              }
              return freeSpace.toInt();
            } else {
              if (kDebugMode) {
                print('Unexpected type for freeSpace: ${freeSpace.runtimeType}');
              }
            }
          } else {
            if (kDebugMode) {
              print('Method channel returned invalid result: $result');
            }
          }
        } catch (methodError) {
          if (kDebugMode) {
            print('Method channel error: $methodError');
          }
          // Continue to fallback methods
        }
      }
      
      // Try to get disk space information using dart:io
      try {
        if (kDebugMode) {
          print('Attempting to get free disk space via directory.statSync()...');
        }
        
        // On some platforms, we can get disk space from the directory stats
        final statFs = directory.statSync();
        final freeSpace = statFs.size;
        
        if (kDebugMode) {
          print('Got free space from statSync: ${(freeSpace / (1024 * 1024)).toStringAsFixed(2)} MB');
        }
        
        // If we get a reasonable value (more than 10MB), use it
        if (freeSpace > 10 * 1024 * 1024) {
          return freeSpace;
        } else {
          if (kDebugMode) {
            print('statSync returned unreasonably small value: $freeSpace bytes');
          }
        }
      } catch (statError) {
        if (kDebugMode) {
          print('Stat error: $statError');
        }
      }
      
      // If all else fails, assume there's enough space (500MB)
      // This prevents false negatives when we can't accurately determine free space
      if (kDebugMode) {
        print('Using default free space value: 500 MB');
      }
      return 500 * 1024 * 1024; // 500MB default
    } catch (e) {
      if (kDebugMode) {
        print('Error getting free disk space: $e');
      }
      // Return a reasonable default in case of error
      return 500 * 1024 * 1024; // Assume 500MB free as fallback
    }
  }

  Future<void> loadPhotosForAlbum(AssetPathEntity album) async {
    bool shouldContinue = true;
    
    try {
      if (kDebugMode) {
        print('Checking storage space before loading photos...');
      }
      
      final hasEnoughSpace = await checkStorageSpace();
      if (!hasEnoughSpace) {
        if (kDebugMode) {
          print('Not enough storage space detected, showing error to user');
        }
        
        Get.snackbar(
          'Storage Error',
          'Not enough storage space on the device to load photos. Please free up at least 100MB of space and try again.',
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[100],
          colorText: Colors.red[900],
          borderRadius: 8,
          margin: const EdgeInsets.all(8),
        );
        shouldContinue = false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error in storage check: $e');
        print('Stack trace: ${StackTrace.current}');
        print('Continuing with photo loading despite storage check error');
      }
      // Continue loading photos even if storage check fails
      // This prevents blocking the user unnecessarily
    }
    
    if (!shouldContinue) {
      if (kDebugMode) {
        print('Aborting photo loading due to insufficient storage');
      }
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
      // Load albums first and await completion
      if (albums.isEmpty) {
        await loadAlbums();
        // Add a small delay to ensure UI updates
        await Future.delayed(const Duration(milliseconds: 100));
      }
      if (photos.isEmpty) await loadPhotos();

      // Show the bottom sheet after albums are loaded
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
