import 'package:get/get.dart';

import 'photo_controller.dart';
import 'album_controller.dart';

class ControllerManager {
  static final ControllerManager _instance = ControllerManager._internal();

  factory ControllerManager() {
    return _instance;
  }

  ControllerManager._internal() {
    // Initialize all controllers
    _photoController = Get.put(PhotoController());
    _albumController = Get.put(AlbumController());
  }

  // Add your controllers here
  // Example:
  static PhotoController get photoController => _instance._photoController;

  static AlbumController get albumController => _instance._albumController;
  late final AlbumController _albumController;

  late final PhotoController _photoController;
}
