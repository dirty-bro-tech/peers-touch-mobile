import 'package:get/get.dart';
import 'package:pure_touch/model/photo_model.dart';
import 'package:pure_touch/pages/photo/photo_selection_sheet.dart';

class PhotoController extends GetxController {
  final selectedPhotos = <int>{}.obs;
  final syncedPhotos = <int>{}.obs; // Added for sync status tracking
  final photos = <PhotoModel>[].obs; // Added photo list

  // Simulated photo loading (replace with actual system API)
  Future<void> loadPhotos() async {
    await Future.delayed(const Duration(milliseconds: 300));
    photos.assignAll(
      List.generate(10, (i) => PhotoModel(id: i, path: "path_$i")),
    );
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
