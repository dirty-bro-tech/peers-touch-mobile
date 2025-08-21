import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:photo_manager/photo_manager.dart';
import 'package:pure_touch/model/photo_model.dart';
import 'package:pure_touch/utils/logger.dart';

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
        appLogger.info('Starting storage space check...');
      }
      
      // Initialize the method channel early if needed
      if (!_isMethodChannelInitialized) {
        if (kDebugMode) {
          appLogger.info('Method channel not initialized, initializing now...');
        }
        await _initializeMethodChannel();
      }
      
      if (kDebugMode) {
        appLogger.info('Getting temporary directory...');
      }
      final directory = await getTemporaryDirectory();
      
      if (kDebugMode) {
        appLogger.info('Temporary directory path: ${directory.path}');
      }
      
      final freeSpace = await _getFreeDiskSpace(directory);
      // Assume we need at least 100MB for loading photos
      const requiredSpace = 100 * 1024 * 1024; // 100MB
      
      if (kDebugMode) {
        appLogger.info('Available storage space: ${(freeSpace / (1024 * 1024)).toStringAsFixed(2)} MB');
        appLogger.info('Required storage space: ${(requiredSpace / (1024 * 1024)).toStringAsFixed(2)} MB');
        appLogger.info('Storage check result: ${freeSpace > requiredSpace ? 'SUFFICIENT' : 'INSUFFICIENT'} space');
      }
      
      return freeSpace > requiredSpace;
    } catch (e) {
      if (kDebugMode) {
        appLogger.error('Error checking storage space: $e');
        appLogger.error('Stack trace: ${StackTrace.current}');
        appLogger.info('Assuming sufficient space due to error');
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
          appLogger.debug('Method channel initialization error (expected): $error');
        }
      });
    } catch (e) {
      // Ignore errors during initialization
      if (kDebugMode) {
        appLogger.debug('Method channel initialization exception (expected): $e');
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
            appLogger.info('Attempting to get free disk space via method channel...');
          }
          
          final Map<String, dynamic>? result = await _storageChannel.invokeMapMethod<String, dynamic>('getFreeDiskSpace');
          if (result != null && result.containsKey('freeSpace')) {
            final freeSpace = result['freeSpace'];
            // Convert to int if it's not already
            if (freeSpace is int) {
              if (kDebugMode) {
                appLogger.info('Successfully got free space from method channel: ${(freeSpace / (1024 * 1024)).toStringAsFixed(2)} MB');
              }
              return freeSpace;
            } else if (freeSpace is double) {
              if (kDebugMode) {
                appLogger.info('Successfully got free space from method channel (double): ${(freeSpace / (1024 * 1024)).toStringAsFixed(2)} MB');
              }
              return freeSpace.toInt();
            } else {
              if (kDebugMode) {
                appLogger.warning('Unexpected type for freeSpace: ${freeSpace.runtimeType}');
              }
            }
          } else {
            if (kDebugMode) {
              appLogger.warning('Method channel returned invalid result: $result');
            }
          }
        } catch (methodError) {
          if (kDebugMode) {
            appLogger.error('Method channel error: $methodError');
          }
          // Continue to fallback methods
        }
      }
      
      // Try to get disk space information using dart:io
      try {
        if (kDebugMode) {
          appLogger.info('Attempting to get free disk space via directory.statSync()...');
        }
        
        // On some platforms, we can get disk space from the directory stats
        final statFs = directory.statSync();
        final freeSpace = statFs.size;
        
        if (kDebugMode) {
          appLogger.info('Got free space from statSync: ${(freeSpace / (1024 * 1024)).toStringAsFixed(2)} MB');
        }
        
        // If we get a reasonable value (more than 10MB), use it
        if (freeSpace > 10 * 1024 * 1024) {
          return freeSpace;
        } else {
          if (kDebugMode) {
            appLogger.warning('statSync returned unreasonably small value: $freeSpace bytes');
          }
        }
      } catch (statError) {
        if (kDebugMode) {
          appLogger.error('Stat error: $statError');
        }
      }
      
      // If all else fails, assume there's enough space (500MB)
      // This prevents false negatives when we can't accurately determine free space
      if (kDebugMode) {
        appLogger.info('Using default free space value: 500 MB');
      }
      return 500 * 1024 * 1024; // 500MB default
    } catch (e) {
      if (kDebugMode) {
        appLogger.error('Error getting free disk space: $e');
      }
      // Return a reasonable default in case of error
      return 500 * 1024 * 1024; // Assume 500MB free as fallback
    }
  }

  // Track pagination state for each album
  final Map<String, int> _albumPageMap = {};
  final int _pageSize = 20; // Number of photos to load per page
  final RxBool isLoadingMore = false.obs;
  final RxBool isUploading = false.obs;
  final RxDouble uploadProgress = 0.0.obs;
  final RxString uploadStatus = ''.obs;
  final RxInt totalFilesToUpload = 0.obs;
  final RxInt uploadedFilesCount = 0.obs;
  bool _uploadCancelled = false;
  
  Future<void> loadPhotosForAlbum(AssetPathEntity album) async {
    bool shouldContinue = true;
    
    if (kDebugMode) {
      appLogger.info('loadPhotosForAlbum called for album: ${album.name}');
    }
    
    // Defer reactive updates until after current build cycle
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Set the current selected album
      currentSelectedAlbum.value = album;
      if (kDebugMode) {
        appLogger.info('Set currentSelectedAlbum.value to: ${album.name}');
        appLogger.info('currentSelectedAlbum.value is now: ${currentSelectedAlbum.value?.name}');
      }
      
      // Reset pagination when loading a new album
      _albumPageMap[album.id] = 0;
      photos.clear();
      update(); // Force update to ensure UI reflects the change
      
      try {
        if (kDebugMode) {
          appLogger.info('Checking storage space before loading photos...');
        }
        
        final hasEnoughSpace = await checkStorageSpace();
        if (!hasEnoughSpace) {
          if (kDebugMode) {
            appLogger.warning('Not enough storage space detected, showing error to user');
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
          appLogger.error('Error in storage check: $e');
          appLogger.error('Stack trace: ${StackTrace.current}');
          appLogger.info('Continuing with photo loading despite storage check error');
        }
        // Continue loading photos even if storage check fails
        // This prevents blocking the user unnecessarily
      }
      
      if (!shouldContinue) {
        if (kDebugMode) {
          appLogger.warning('Aborting photo loading due to insufficient storage');
        }
        return;
      }

      try {
        if (kDebugMode) {
          appLogger.info('Loading first page of photos for album: ${album.name}');
        }
        
        await loadMorePhotos(album);
      } catch (e) {
        if (kDebugMode) {
          appLogger.error('Error getting asset list for album: $e');
          appLogger.error('Stack trace: ${StackTrace.current}');
        }
        Get.snackbar('Error', 'Failed to load photos from album: $e');
       }
     });
   }
  
  // Load more photos for pagination
  Future<bool> loadMorePhotos(AssetPathEntity album) async {
    if (isLoadingMore.value) return false;
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isLoadingMore.value = true;
    });
    
    try {
      final int currentPage = _albumPageMap[album.id] ?? 0;
      
      if (kDebugMode) {
        appLogger.info('Loading page $currentPage for album: ${album.name}');
      }
      
      List<AssetEntity> assets = [];
      try {
        assets = await album.getAssetListPaged(
          page: currentPage,
          size: _pageSize,
        );
        
        if (kDebugMode) {
          appLogger.info('Found ${assets.length} assets in album for page $currentPage');
        }
        
        // If no more assets, return false
        if (assets.isEmpty) {
          return false;
        }
      } catch (e) {
        if (kDebugMode) {
          appLogger.error('Error getting asset list for album: $e');
          appLogger.error('Stack trace: ${StackTrace.current}');
        }
        Get.snackbar('Error', 'Failed to load more photos: $e');
        return false;
      }
      
      final List<PhotoModel> albumPhotos = [];

      for (final asset in assets) {
        try {
          // Try to get the file path directly first
          String? filePath;
          
          // Try to get the file
          final file = await asset.file;
          if (file != null) {
            filePath = file.path;
          } else {
            // If file is null, try to get the original file path
            filePath = await asset.originFile.then((f) => f?.path);
            if (filePath == null) {
              // As a last resort, try to get the thumbnail path
              final thumbData = await asset.thumbnailData;
              if (thumbData != null) {
                // Save thumbnail to a temporary file
                final tempDir = await getTemporaryDirectory();
                final tempFile = File('${tempDir.path}/${asset.id}.jpg');
                await tempFile.writeAsBytes(thumbData);
                filePath = tempFile.path;
              }
            }
          }
          
          if (filePath != null) {
            albumPhotos.add(
              PhotoModel(
                id: int.tryParse(asset.id) ?? asset.id.hashCode,
                path: filePath,
              ),
            );
          }
        } catch (e) {
          if (kDebugMode) {
            appLogger.error('Error getting file for asset ${asset.id}: $e');
          }
        }
      }
      
      // Filter out photos with invalid paths
      final validPhotos = <PhotoModel>[];
      for (final photo in albumPhotos) {
        try {
          if (photo.fileExistsSync()) {
            validPhotos.add(photo);
          }
        } catch (e) {
          if (kDebugMode) {
            appLogger.error('Error checking photo path: $e');
          }
        }
      }
      
      if (kDebugMode) {
        appLogger.info('Found ${validPhotos.length} valid photos for page $currentPage');
      }
      
      // Defer reactive updates to avoid build-time setState errors
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Add photos to the existing list
        photos.addAll(validPhotos);
        
        // Increment the page number for next load
        _albumPageMap[album.id] = currentPage + 1;
        
        update(); // Ensure UI updates
        isLoadingMore.value = false;
      });
      return true;
    } catch (e) {
      if (kDebugMode) {
        appLogger.error('Error loading more photos: $e');
      }
      Get.snackbar('Error', 'Failed to load more photos: $e');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isLoadingMore.value = false;
      });
      return false;
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

  // Cancel upload process
  void cancelUpload() {
    _uploadCancelled = true;
    uploadStatus.value = 'Cancelling upload...';
  }
  
  // Upload method to sync selected photos with progress tracking
  Future<bool> uploadSelectedPhotos() async {
    if (isUploading.value) return false;
    
    // Reset upload state
    isUploading.value = true;
    _uploadCancelled = false;
    uploadProgress.value = 0.0;
    uploadedFilesCount.value = 0;
    
    try {
      // Calculate total files to upload
      int totalFiles = selectedPhotos.length;
      
      // Add photos from selected albums
      for (final album in selectedAlbums) {
        final List<AssetEntity> assets = await album.getAssetListRange(
          start: 0,
          end: 9999,
        );
        totalFiles += assets.length;
      }
      
      totalFilesToUpload.value = totalFiles;
      uploadStatus.value = 'Starting upload...';
      
      // Show progress dialog
      _showUploadProgressDialog();
      
      // Upload individual selected photos
      for (final photoId in selectedPhotos) {
        if (_uploadCancelled) {
          Get.back(); // Close dialog
          _resetUploadState();
          return false;
        }
        
        final photo = photos.firstWhereOrNull((p) => p.id == photoId);
        if (photo != null) {
          final file = File(photo.path);
          if (await file.exists()) {
            uploadStatus.value = 'Uploading ${file.path.split('/').last}...';
            final success = await _uploadSinglePhoto(file, currentSelectedAlbum.value?.name);
            if (!success) {
              appLogger.error('Failed to upload photo: ${photo.path}');
              Get.back(); // Close dialog
              _resetUploadState();
              Get.snackbar('Upload Error', 'Failed to upload ${file.path.split('/').last}');
              return false;
            }
            _updateProgress();
          }
        }
      }
      
      // Upload photos from selected albums
      for (final album in selectedAlbums) {
        if (_uploadCancelled) {
          Get.back(); // Close dialog
          _resetUploadState();
          return false;
        }
        
        final List<AssetEntity> assets = await album.getAssetListRange(
          start: 0,
          end: 9999,
        );
        
        for (final asset in assets) {
          if (_uploadCancelled) {
            Get.back(); // Close dialog
            _resetUploadState();
            return false;
          }
          
          final file = await asset.file;
          if (file != null) {
            uploadStatus.value = 'Uploading ${file.path.split('/').last} from ${album.name}...';
            final success = await _uploadSinglePhoto(file, album.name);
            if (!success) {
              appLogger.error('Failed to upload photo from album ${album.name}: ${file.path}');
              Get.back(); // Close dialog
              _resetUploadState();
              Get.snackbar('Upload Error', 'Failed to upload ${file.path.split('/').last}');
              return false;
            }
            _updateProgress();
          }
        }
      }

      // Mark selected photos and albums as synced
      syncedPhotos.addAll(selectedPhotos);
      syncedAlbums.addAll(selectedAlbums);
      
      // Clear selected items after successful upload
      selectedPhotos.clear();
      selectedAlbums.clear();
      
      uploadStatus.value = 'Upload completed successfully!';
      await Future.delayed(const Duration(seconds: 1));
      Get.back(); // Close dialog
      _resetUploadState();
      
      return true;
    } catch (e) {
      appLogger.error('Error uploading photos: $e');
      Get.back(); // Close dialog
      _resetUploadState();
      Get.snackbar('Upload Error', 'An unexpected error occurred: $e');
      return false;
    }
  }
  
  void _updateProgress() {
    uploadedFilesCount.value++;
    uploadProgress.value = uploadedFilesCount.value / totalFilesToUpload.value;
  }
  
  void _resetUploadState() {
    isUploading.value = false;
    uploadProgress.value = 0.0;
    uploadStatus.value = '';
    totalFilesToUpload.value = 0;
    uploadedFilesCount.value = 0;
    _uploadCancelled = false;
  }
  
  void _showUploadProgressDialog() {
    Get.dialog(
      WillPopScope(
        onWillPop: () async {
          cancelUpload();
          return false;
        },
        child: AlertDialog(
          title: const Text('Uploading Photos'),
          content: Obx(() => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LinearProgressIndicator(
                value: uploadProgress.value,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
              const SizedBox(height: 16),
              Text(
                '${uploadedFilesCount.value} / ${totalFilesToUpload.value} files uploaded',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 8),
              Text(
                uploadStatus.value,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          )),
          actions: [
            TextButton(
              onPressed: () {
                cancelUpload();
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
  
  Future<bool> _uploadSinglePhoto(File file, String? albumName) async {
    final url = Uri.parse('http://192.168.31.19:8082/family/photo/sync');
    final request = http.MultipartRequest('POST', url);
    
    try {
      // Add album parameter if provided
      if (albumName != null) {
        request.fields['album'] = albumName;
      }
      
      // Add photo file
      final stream = http.ByteStream(file.openRead());
      final length = await file.length();
      final multipartFile = http.MultipartFile(
        'photo',
        stream,
        length,
        filename: file.path.split('/').last,
      );
      request.files.add(multipartFile);
      
      final response = await request.send();
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      
      if (response.statusCode == 200) {
        return true;
      } else {
        appLogger.error(
          'Upload failed with status: ${response.statusCode}, Response: $responseString',
        );
        return false;
      }
    } catch (e) {
      appLogger.error('Error uploading single photo: $e');
      return false;
    }
  }

  Future<void> showSyncPhotoDrawer() async {
    if (_isShowSyncPhotoDrawerRunning.value) return;
    _isShowSyncPhotoDrawerRunning.value = true;

    if (kDebugMode) {
      appLogger.info('Showing sync photo drawer');
    }

    try {
      // Load albums first and await completion
      if (albums.isEmpty) {
        if (kDebugMode) {
          appLogger.info('Albums empty, loading albums');
        }
        await loadAlbums();
        // Add a small delay to ensure UI updates
        await Future.delayed(const Duration(milliseconds: 100));
      }
      
      // Clear any existing photo data to start fresh
      photos.clear();
      currentSelectedAlbum.value = null;
      update();
      
      if (kDebugMode) {
        appLogger.info('Showing bottom sheet');
        appLogger.info('Current selected album: ${currentSelectedAlbum.value?.name ?? "None"}');
      }

      // Show the bottom sheet after albums are loaded
      await Get.bottomSheet(
        const PhotoSelectionSheet(),
        isScrollControlled: true,
      ).whenComplete(() {
        // Clear data when the drawer is closed
        if (kDebugMode) {
          appLogger.info('Bottom sheet closed, clearing data');
        }
        clearAlbumAndPhotoData();
      });
    } catch (e) {
      appLogger.error('Error showing sync photo drawer: $e');
    } finally {
      _isShowSyncPhotoDrawerRunning.value = false;
    }
  }

  void clearAlbumAndPhotoData() {
    if (kDebugMode) {
      appLogger.info('Clearing album and photo data');
      appLogger.info('Current selected album before clearing: ${currentSelectedAlbum.value?.name ?? "None"}');
    }
    
    photos.clear();
    selectedPhotos.clear();
    syncedPhotos.clear();
    selectedAlbums.clear();
    syncedAlbums.clear();
    currentSelectedAlbum.value = null;
    
    if (kDebugMode) {
      appLogger.info('Current selected album after clearing: ${currentSelectedAlbum.value?.name ?? "None"}');
    }
    
    update();
  }

  // Backend photo fetching methods
  final RxList<Map<String, dynamic>> backendAlbums = <Map<String, dynamic>>[].obs;
  final RxBool isLoadingBackendPhotos = false.obs;
  
  /// Fetch photo list from backend
  Future<bool> fetchBackendPhotoList({String? albumFilter}) async {
    if (isLoadingBackendPhotos.value) return false;
    
    isLoadingBackendPhotos.value = true;
    
    try {
      String url = 'http://192.168.31.19:8082/family/photo/list';
      if (albumFilter != null && albumFilter.isNotEmpty) {
        url += '?album=${Uri.encodeComponent(albumFilter)}';
      }
      
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> albumsData = data['albums'] ?? [];
        
        backendAlbums.assignAll(albumsData.cast<Map<String, dynamic>>());
        
        if (kDebugMode) {
          appLogger.info('Fetched ${backendAlbums.length} albums from backend');
        }
        
        return true;
      } else {
        appLogger.error('Failed to fetch backend photos: ${response.statusCode}');
        Get.snackbar('Error', 'Failed to load photos from server');
        return false;
      }
    } catch (e) {
      appLogger.error('Error fetching backend photos: $e');
      Get.snackbar('Error', 'Network error while loading photos');
      return false;
    } finally {
      isLoadingBackendPhotos.value = false;
    }
  }
  
  /// Get photo URL for displaying from backend
  String getBackendPhotoUrl(String album, String filename) {
    return 'http://192.168.31.19:8082/family/photo/get?album=${Uri.encodeComponent(album)}&filename=${Uri.encodeComponent(filename)}';
  }
  
  /// Download photo from backend to local storage
  Future<File?> downloadBackendPhoto(String album, String filename) async {
    try {
      final url = getBackendPhotoUrl(album, filename);
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final Directory tempDir = await getTemporaryDirectory();
        final String filePath = '${tempDir.path}/${album}_$filename';
        final File file = File(filePath);
        
        await file.writeAsBytes(response.bodyBytes);
        
        if (kDebugMode) {
          appLogger.info('Downloaded photo: $filename from album: $album');
        }
        
        return file;
      } else {
        appLogger.error('Failed to download photo: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      appLogger.error('Error downloading photo: $e');
      return null;
    }
  }
  
  /// Get all photos from a specific backend album
  List<Map<String, dynamic>> getPhotosFromBackendAlbum(String albumName) {
    final album = backendAlbums.firstWhereOrNull(
      (album) => album['name'] == albumName,
    );
    
    if (album != null) {
      return List<Map<String, dynamic>>.from(album['photos'] ?? []);
    }
    
    return [];
  }
  
  /// Refresh backend photos
  Future<void> refreshBackendPhotos() async {
    await fetchBackendPhotoList();
  }
}
