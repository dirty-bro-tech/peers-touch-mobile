import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

class AlbumController extends GetxController {
  final RxList<AssetPathEntity> albums = <AssetPathEntity>[].obs;
  final RxSet<AssetPathEntity> selectedAlbums = <AssetPathEntity>{}.obs;

  Future<void> loadAlbums() async {
    final PermissionState permission =
        await PhotoManager.requestPermissionExtend();
    if (permission != PermissionState.authorized) {
      return;
    }

    final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
      type: RequestType.common,
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

  // Upload functionality moved to PhotoController.uploadSelectedPhotos()

  void clearAllStates() {
    selectedAlbums.clear();
    albums.clear();
  }
}
