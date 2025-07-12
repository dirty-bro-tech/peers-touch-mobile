import 'package:get/get.dart';

class PhotoController extends GetxController {
  final selectedPhotos = <int>{}.obs;
  
  void toggleSelection(int index) {
    if (selectedPhotos.contains(index)) {
      selectedPhotos.remove(index);
    } else {
      selectedPhotos.add(index);
    }
  }

  void syncPhotos() {
    print('Syncing selected photos: $selectedPhotos');
    Get.back();
  }
}
