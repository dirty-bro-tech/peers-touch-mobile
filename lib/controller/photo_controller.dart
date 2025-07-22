import 'package:get/get.dart';
import 'package:pure_touch/model/photo_model.dart';
import 'package:pure_touch/pages/photo/photo_selection_sheet.dart';
import 'package:photo_manager/photo_manager.dart';

class PhotoController extends GetxController {
  final selectedPhotos = <int>{}.obs;
  final syncedPhotos = <int>{}.obs; // Added for sync status tracking
  final photos = <PhotoModel>[].obs; // Added photo list

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

  void toggleSelection(int index) {
    if (selectedPhotos.contains(index)) {
      selectedPhotos.remove(index);
    } else {
      selectedPhotos.add(index);
    }
  }

  Future<void> showSyncPhotoDrawer() async {
    if (photos.isEmpty) await loadPhotos(); // Load photos first

    // Show bottom sheet using the new UI component
    await Get.bottomSheet(
      const PhotoSelectionSheet(),
      isScrollControlled: true,
    );
  }
}
