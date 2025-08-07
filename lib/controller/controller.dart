import 'package:get/get.dart';

import 'package:pure_touch/controller/photo_controller.dart';
import 'package:pure_touch/controller/album_controller.dart';
import 'package:pure_touch/controller/device_id_controller.dart';
import 'package:pure_touch/controller/scroll_controller.dart';

class ControllerManager {
  static final ControllerManager _instance = ControllerManager._internal();

  factory ControllerManager() {
    return _instance;
  }

  ControllerManager._internal() {
    // Initialize all controllers
    _deviceIdController = Get.put(DeviceIdController());
    _photoController = Get.put(PhotoController());
    _albumController = Get.put(AlbumController());
    _scrollController = Get.put(AppScrollController());
  }

  // Add your controllers here
  // Example:
  static DeviceIdController get deviceIdController => _instance._deviceIdController;
  static PhotoController get photoController => _instance._photoController;
  static AlbumController get albumController => _instance._albumController;
  static AppScrollController get scrollController => _instance._scrollController;
  
  late final DeviceIdController _deviceIdController;
  late final AlbumController _albumController;
  late final PhotoController _photoController;
  late final AppScrollController _scrollController;
}
