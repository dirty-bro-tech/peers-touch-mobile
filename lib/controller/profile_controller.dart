import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pure_touch/utils/logger.dart';

class ProfileController extends GetxController {
  final RxBool isLoading = false.obs;
  final Rx<File?> profileImage = Rx<File?>(null);
  final RxBool hasProfileImage = false.obs;
  final RxInt imageVersion = 0.obs; // Add version counter for cache busting

  
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
        
        // Delete existing file first to ensure clean copy
        final existingFile = File(imagePath);
        if (await existingFile.exists()) {
          await existingFile.delete();
        }
        
        // Copy the picked image to our app directory
        final File newImage = await pickedFile.copy(imagePath);
        
        // Update state and increment version for cache busting
        profileImage.value = newImage;
        hasProfileImage.value = true;
        imageVersion.value++; // Increment to force UI refresh
        
        // Force evict the image from cache to ensure immediate refresh
        FileImage(newImage).evict();
        
        // Force UI update by triggering reactive variables
        profileImage.refresh();
        hasProfileImage.refresh();
        
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
  

}