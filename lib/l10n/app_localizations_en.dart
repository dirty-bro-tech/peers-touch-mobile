// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Peers Touch';

  @override
  String get homePageTitle => 'Home Page';

  @override
  String get navHome => 'Home';

  @override
  String get navChat => 'Chat';

  @override
  String get navPhoto => 'Photo';

  @override
  String get navProfile => 'Profile';

  @override
  String get deviceInformation => 'Device Information';

  @override
  String get installationStatus => 'Installation Status';

  @override
  String get firstLaunch => 'First Launch';

  @override
  String get returningUser => 'Returning User';

  @override
  String get deviceId => 'Device ID (DID)';

  @override
  String get installationId => 'Installation ID';

  @override
  String get generatedAvatar => 'Generated Avatar';

  @override
  String get avatarDescription =>
      'This avatar is generated based on your device ID and will remain consistent across app sessions:';

  @override
  String get resetDeviceId => 'Reset Device ID (Testing)';

  @override
  String get resetDeviceIdTitle => 'Reset Device ID?';

  @override
  String get resetDeviceIdMessage =>
      'This will generate a new device ID and installation ID. This action is typically only used for testing purposes.';

  @override
  String get cancel => 'Cancel';

  @override
  String get reset => 'Reset';

  @override
  String get resetComplete => 'Reset Complete';

  @override
  String get resetCompleteMessage => 'Device ID has been reset and regenerated';

  @override
  String get copied => 'Copied';

  @override
  String get copiedMessage => 'Content copied to clipboard';

  @override
  String get copyToClipboard => 'Copy to clipboard';

  @override
  String get syncPhotos => 'Sync Photos';

  @override
  String get takePhoto => 'Take Photo';

  @override
  String get uploadPhoto => 'Upload Photo';

  @override
  String get selectProfilePicture => 'Select Profile Picture';

  @override
  String get chooseFromGallery => 'Choose from Gallery';

  @override
  String get selectFromPhotos => 'Select from your photos';

  @override
  String get chooseFromPosts => 'Choose from Posts';

  @override
  String get comingSoon => 'Coming soon...';

  @override
  String get comingSoonTitle => 'Coming Soon';

  @override
  String get comingSoonMessage =>
      'This feature will be available in future updates';

  @override
  String get ok => 'OK';

  @override
  String get selectPhoto => 'Select Photo';

  @override
  String get noPhotosFound => 'No photos found';

  @override
  String get success => 'Success';

  @override
  String get profilePictureUpdated => 'Profile picture updated successfully';

  @override
  String get error => 'Error';

  @override
  String get permissionDenied => 'Permission Denied';

  @override
  String get needPhotoAccess => 'Need photo access to select profile image';

  @override
  String get needMediaAccess => 'Need media access to load albums';

  @override
  String get photosSyncedSuccessfully => 'Photos synced successfully';

  @override
  String get failedToSyncPhotos => 'Failed to sync photos';

  @override
  String unexpectedError(String error) {
    return 'An unexpected error occurred: $error';
  }

  @override
  String syncSelectedPhotos(int count) {
    return 'Sync Selected Photos ($count)';
  }

  @override
  String get userName => 'User Name';

  @override
  String get userBio =>
      'User Bio Ha Ha hah hasd hello hello hello hello hello, hi hi hi hi hi hi hi hi hi';

  @override
  String get photoAlbums => 'Photo Albums';

  @override
  String get albumSync => 'Album Sync';

  @override
  String get albumSyncMessage =>
      'Select albums to sync with your account. Synced albums will be available across all your devices.';

  @override
  String get syncSelectedAlbums => 'Sync Selected Albums';

  @override
  String get selectAll => 'Select All';

  @override
  String get deselectAll => 'Deselect All';

  @override
  String get noAlbumsSelected => 'No Albums Selected';

  @override
  String get selectAtLeastOneAlbum =>
      'Please select at least one album to sync';

  @override
  String get albumsSyncedSuccessfully => 'Albums synced successfully';

  @override
  String get syncFailed => 'Sync Failed';

  @override
  String get syncFailedMessage =>
      'Upload failed. Check:\n• Network connection\n• Server availability\n• Photo permissions\n• Storage space';

  @override
  String get networkConnectionFailed => 'Network connection failed';

  @override
  String get requestTimedOut => 'Request timed out';

  @override
  String get invalidServerResponse => 'Invalid server response';

  @override
  String get photoAccessDenied => 'Photo access permission denied';

  @override
  String syncSelectedAlbumsCount(int count) {
    return 'Sync Selected Albums ($count)';
  }

  @override
  String get loading => 'Loading...';

  @override
  String get errorLoadingCount => 'Error loading count';

  @override
  String itemsCount(int count) {
    return '$count items';
  }

  @override
  String get newGroup => 'New Group';

  @override
  String get addContact => 'Add Contact';

  @override
  String get uploadingPhotos => 'Uploading Photos';

  @override
  String get uploadError => 'Upload Error';

  @override
  String get storageError => 'Storage Error';

  @override
  String get notEnoughStorageSpace =>
      'Not enough storage space on the device to load photos. Please free up at least 100MB of space and try again.';

  @override
  String get startingUpload => 'Starting upload...';

  @override
  String get cancellingUpload => 'Cancelling upload...';

  @override
  String get uploadCompletedSuccessfully => 'Upload completed successfully!';

  @override
  String loadingPhotosFrom(String albumName) {
    return 'Loading photos from $albumName...';
  }

  @override
  String get friendName => 'Friend Name';

  @override
  String get samplePostContent => 'This is a sample post content...';

  @override
  String get increment => 'Increment';

  @override
  String get youHavePushedButton =>
      'You have pushed the button this many times:';
}
