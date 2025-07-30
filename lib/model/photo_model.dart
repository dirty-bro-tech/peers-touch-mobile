import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:pure_touch/utils/logger.dart';

class PhotoModel {
  final int id;
  final String path;
  String? _cachedPath;

  PhotoModel({required this.id, required this.path});
  
  /// Gets a valid file path, checking if the original path exists
  /// and returning a fallback if it doesn't
  Future<String?> getValidPath() async {
    if (_cachedPath != null) {
      return _cachedPath;
    }
    
    try {
      final file = File(path);
      if (await file.exists()) {
        _cachedPath = path;
        return path;
      } else {
        if (kDebugMode) {
          appLogger.warning('File does not exist: $path');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        appLogger.error('Error checking file path: $e');
      }
      return null;
    }
  }
  
  /// Checks if the file exists synchronously
  bool fileExistsSync() {
    try {
      return File(path).existsSync();
    } catch (e) {
      if (kDebugMode) {
        appLogger.error('Error checking if file exists: $e');
      }
      return false;
    }
  }
}
