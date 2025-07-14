import '../pages/photo/photo_controller.dart';

class ControllerManager {
  static final ControllerManager _instance = ControllerManager._internal();

  factory ControllerManager() {
    return _instance;
  }

  ControllerManager._internal() {
    // Initialize all controllers
    _photoController = PhotoController();
  }

  // Add your controllers here
  // Example:
  static PhotoController get photoController => _instance._photoController;
  late final PhotoController _photoController;
}
