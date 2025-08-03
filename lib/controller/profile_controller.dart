import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/logger.dart';

class ProfileController extends GetxController {
  final RxBool isLoading = false.obs;
  final Rx<File?> profileImage = Rx<File?>(null);
  final RxBool hasProfileImage = false.obs;

  
  // Removed ImagePicker, using photo_manager instead
  
  @override
  void onInit() {
    super.onInit();
    _loadProfileImage();
  }
  
  Future<void> _loadProfileImage() async {
    try {
      isLoading.value = true;
      
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/profile_image.png';
      final imageFile = File(imagePath);
      
      final prefs = await SharedPreferences.getInstance();
      final hasImage = prefs.getBool('has_profile_image') ?? false;
      
      if (hasImage && await imageFile.exists()) {
        profileImage.value = imageFile;
        hasProfileImage.value = true;
        appLogger.info('Profile image loaded from local storage');
      } else {
        hasProfileImage.value = false;
        appLogger.info('No profile image found');
      }
    } catch (e) {
      appLogger.error('Error loading profile image: $e');
      hasProfileImage.value = false;
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> setProfileImageFromAsset(AssetEntity asset) async {
    try {
      isLoading.value = true;
      appLogger.info('Setting profile image from selected asset');
      
      final File? pickedFile = await asset.file;
      if (pickedFile != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = '${directory.path}/profile_image.png';
        
        // Copy the picked image to our app directory
        final File newImage = await pickedFile.copy(imagePath);
        
        // Update state
        profileImage.value = newImage;
        hasProfileImage.value = true;
        
        // Save preference
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('has_profile_image', true);
        
        appLogger.info('Profile image updated successfully');
      } else {
        throw Exception('Could not access selected image');
      }
    } catch (e) {
      appLogger.error('Error setting profile image: $e');
      throw e;
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> _removeProfileImage() async {
    try {
      isLoading.value = true;
      
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/profile_image.png';
      final imageFile = File(imagePath);
      
      if (await imageFile.exists()) {
        await imageFile.delete();
      }
      
      // Update state
      profileImage.value = null;
      hasProfileImage.value = false;
      
      // Save preference
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('has_profile_image', false);
      
      appLogger.info('Profile image removed successfully');
    } catch (e) {
      appLogger.error('Error removing profile image: $e');
      Get.snackbar('Error', 'Failed to remove profile image: $e');
    } finally {
      isLoading.value = false;
    }
  }
  
  void showImageOptions() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: 20 + MediaQuery.of(Get.context!).padding.bottom,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Profile Picture Options',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            if (hasProfileImage.value)
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Remove Picture', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Get.back();
                  _removeProfileImage();
                },
              ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text('Cancel'),
              onTap: () => Get.back(),
            ),
          ],
        ),
      ),
    );
  }
}