import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Peers Touch'**
  String get appTitle;

  /// Title for the home page
  ///
  /// In en, this message translates to:
  /// **'Home Page'**
  String get homePageTitle;

  /// Navigation label for home
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// Navigation label for chat
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get navChat;

  /// Navigation label for photo
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get navPhoto;

  /// Navigation label for profile
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// Title for device information page
  ///
  /// In en, this message translates to:
  /// **'Device Information'**
  String get deviceInformation;

  /// Label for installation status
  ///
  /// In en, this message translates to:
  /// **'Installation Status'**
  String get installationStatus;

  /// Status text for first app launch
  ///
  /// In en, this message translates to:
  /// **'First Launch'**
  String get firstLaunch;

  /// Status text for returning user
  ///
  /// In en, this message translates to:
  /// **'Returning User'**
  String get returningUser;

  /// Label for device ID
  ///
  /// In en, this message translates to:
  /// **'Device ID (DID)'**
  String get deviceId;

  /// Label for installation ID
  ///
  /// In en, this message translates to:
  /// **'Installation ID'**
  String get installationId;

  /// Title for generated avatar section
  ///
  /// In en, this message translates to:
  /// **'Generated Avatar'**
  String get generatedAvatar;

  /// Description of how avatar is generated
  ///
  /// In en, this message translates to:
  /// **'This avatar is generated based on your device ID and will remain consistent across app sessions:'**
  String get avatarDescription;

  /// Button text for resetting device ID
  ///
  /// In en, this message translates to:
  /// **'Reset Device ID (Testing)'**
  String get resetDeviceId;

  /// Title for reset device ID dialog
  ///
  /// In en, this message translates to:
  /// **'Reset Device ID?'**
  String get resetDeviceIdTitle;

  /// Message for reset device ID dialog
  ///
  /// In en, this message translates to:
  /// **'This will generate a new device ID and installation ID. This action is typically only used for testing purposes.'**
  String get resetDeviceIdMessage;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Reset button text
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// Title for reset complete message
  ///
  /// In en, this message translates to:
  /// **'Reset Complete'**
  String get resetComplete;

  /// Message for reset complete
  ///
  /// In en, this message translates to:
  /// **'Device ID has been reset and regenerated'**
  String get resetCompleteMessage;

  /// Message when content is copied
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get copied;

  /// Detailed message when content is copied
  ///
  /// In en, this message translates to:
  /// **'Content copied to clipboard'**
  String get copiedMessage;

  /// Tooltip for copy button
  ///
  /// In en, this message translates to:
  /// **'Copy to clipboard'**
  String get copyToClipboard;

  /// Tooltip for sync photos button
  ///
  /// In en, this message translates to:
  /// **'Sync Photos'**
  String get syncPhotos;

  /// Tooltip for take photo button
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get takePhoto;

  /// Tooltip for upload photo button
  ///
  /// In en, this message translates to:
  /// **'Upload Photo'**
  String get uploadPhoto;

  /// Title for profile picture selection page
  ///
  /// In en, this message translates to:
  /// **'Select Profile Picture'**
  String get selectProfilePicture;

  /// Option to choose from gallery
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get chooseFromGallery;

  /// Subtitle for gallery option
  ///
  /// In en, this message translates to:
  /// **'Select from your photos'**
  String get selectFromPhotos;

  /// Option to choose from posts
  ///
  /// In en, this message translates to:
  /// **'Choose from Posts'**
  String get chooseFromPosts;

  /// Text for features coming soon
  ///
  /// In en, this message translates to:
  /// **'Coming soon...'**
  String get comingSoon;

  /// Title for coming soon dialog
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get comingSoonTitle;

  /// Message for coming soon features
  ///
  /// In en, this message translates to:
  /// **'This feature will be available in future updates'**
  String get comingSoonMessage;

  /// OK button text
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Title for photo selection dialog
  ///
  /// In en, this message translates to:
  /// **'Select Photo'**
  String get selectPhoto;

  /// Message when no photos are found
  ///
  /// In en, this message translates to:
  /// **'No photos found'**
  String get noPhotosFound;

  /// Success message title
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// Message when profile picture is updated
  ///
  /// In en, this message translates to:
  /// **'Profile picture updated successfully'**
  String get profilePictureUpdated;

  /// Error message title
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Permission denied message title
  ///
  /// In en, this message translates to:
  /// **'Permission Denied'**
  String get permissionDenied;

  /// Message when photo access is needed
  ///
  /// In en, this message translates to:
  /// **'Photo access is needed to select a profile image'**
  String get needPhotoAccess;

  /// Message when media access is needed
  ///
  /// In en, this message translates to:
  /// **'Media access is needed to load albums'**
  String get needMediaAccess;

  /// Message when photos are synced successfully
  ///
  /// In en, this message translates to:
  /// **'Photos synced successfully'**
  String get photosSyncedSuccessfully;

  /// Message when photo sync fails
  ///
  /// In en, this message translates to:
  /// **'Failed to sync photos'**
  String get failedToSyncPhotos;

  /// Message for unexpected errors
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred: {error}'**
  String unexpectedError(String error);

  /// Button text for syncing selected photos
  ///
  /// In en, this message translates to:
  /// **'Sync Selected Photos ({count})'**
  String syncSelectedPhotos(int count);

  /// Default user name
  ///
  /// In en, this message translates to:
  /// **'User Name'**
  String get userName;

  /// Default user bio text
  ///
  /// In en, this message translates to:
  /// **'This is a sample user biography.'**
  String get userBio;

  /// Title for photo albums page
  ///
  /// In en, this message translates to:
  /// **'Photo Albums'**
  String get photoAlbums;

  /// Title for album sync dialog
  ///
  /// In en, this message translates to:
  /// **'Album Sync'**
  String get albumSync;

  /// Message for album sync dialog
  ///
  /// In en, this message translates to:
  /// **'Select albums to sync with your account. Synced albums will be available across all your devices.'**
  String get albumSyncMessage;

  /// Button text for syncing selected albums
  ///
  /// In en, this message translates to:
  /// **'Sync Selected Albums'**
  String get syncSelectedAlbums;

  /// Tooltip for select all button
  ///
  /// In en, this message translates to:
  /// **'Select All'**
  String get selectAll;

  /// Tooltip for deselect all button
  ///
  /// In en, this message translates to:
  /// **'Deselect All'**
  String get deselectAll;

  /// Title when no albums are selected
  ///
  /// In en, this message translates to:
  /// **'No Albums Selected'**
  String get noAlbumsSelected;

  /// Message when no albums are selected for sync
  ///
  /// In en, this message translates to:
  /// **'Please select at least one album to sync'**
  String get selectAtLeastOneAlbum;

  /// Message when albums are synced successfully
  ///
  /// In en, this message translates to:
  /// **'Albums synced successfully'**
  String get albumsSyncedSuccessfully;

  /// Title for sync failed message
  ///
  /// In en, this message translates to:
  /// **'Sync Failed'**
  String get syncFailed;

  /// Detailed message for sync failure
  ///
  /// In en, this message translates to:
  /// **'Upload failed. Check:\n• Network connection\n• Server availability\n• Photo permissions\n• Storage space'**
  String get syncFailedMessage;

  /// Error message for network connection failure
  ///
  /// In en, this message translates to:
  /// **'Network connection failed'**
  String get networkConnectionFailed;

  /// Error message for request timeout
  ///
  /// In en, this message translates to:
  /// **'Request timed out'**
  String get requestTimedOut;

  /// Error message for invalid server response
  ///
  /// In en, this message translates to:
  /// **'Invalid server response'**
  String get invalidServerResponse;

  /// Error message for photo access denial
  ///
  /// In en, this message translates to:
  /// **'Photo access permission denied'**
  String get photoAccessDenied;

  /// Button text for syncing selected albums with count
  ///
  /// In en, this message translates to:
  /// **'Sync Selected Albums ({count})'**
  String syncSelectedAlbumsCount(int count);

  /// Loading text
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Error message when loading count fails
  ///
  /// In en, this message translates to:
  /// **'Error loading count'**
  String get errorLoadingCount;

  /// Text showing number of items
  ///
  /// In en, this message translates to:
  /// **'{count} items'**
  String itemsCount(int count);

  /// Tooltip for new group button
  ///
  /// In en, this message translates to:
  /// **'New Group'**
  String get newGroup;

  /// Tooltip for add contact button
  ///
  /// In en, this message translates to:
  /// **'Add Contact'**
  String get addContact;

  /// Title for uploading photos dialog
  ///
  /// In en, this message translates to:
  /// **'Uploading Photos'**
  String get uploadingPhotos;

  /// Title for upload error messages
  ///
  /// In en, this message translates to:
  /// **'Upload Error'**
  String get uploadError;

  /// Title for storage error messages
  ///
  /// In en, this message translates to:
  /// **'Storage Error'**
  String get storageError;

  /// Message when there's not enough storage space
  ///
  /// In en, this message translates to:
  /// **'Not enough storage space on the device to load photos. Please free up at least 100MB of space and try again.'**
  String get notEnoughStorageSpace;

  /// Status message when upload starts
  ///
  /// In en, this message translates to:
  /// **'Starting upload...'**
  String get startingUpload;

  /// Status message when upload is being cancelled
  ///
  /// In en, this message translates to:
  /// **'Cancelling upload...'**
  String get cancellingUpload;

  /// Message when upload completes successfully
  ///
  /// In en, this message translates to:
  /// **'Upload completed successfully!'**
  String get uploadCompletedSuccessfully;

  /// Message when loading photos from an album
  ///
  /// In en, this message translates to:
  /// **'Loading photos from {albumName}...'**
  String loadingPhotosFrom(String albumName);

  /// Default friend name in posts
  ///
  /// In en, this message translates to:
  /// **'Friend Name'**
  String get friendName;

  /// Sample post content text
  ///
  /// In en, this message translates to:
  /// **'This is a sample post content...'**
  String get samplePostContent;

  /// Tooltip for increment button
  ///
  /// In en, this message translates to:
  /// **'Increment'**
  String get increment;

  /// Counter description text
  ///
  /// In en, this message translates to:
  /// **'You have pushed the button this many times:'**
  String get youHavePushedButton;

  /// Navigation label for me
  ///
  /// In en, this message translates to:
  /// **'Me'**
  String get navMe;

  /// Title for me profile page
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get meProfile;

  /// Label for profile photo
  ///
  /// In en, this message translates to:
  /// **'Profile Photo'**
  String get profilePhoto;

  /// Label for name field
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// Label for gender field
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// Label for region field
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get region;

  /// Label for email field
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Label for peers ID field
  ///
  /// In en, this message translates to:
  /// **'Peers ID'**
  String get peersId;

  /// Label for QR code section
  ///
  /// In en, this message translates to:
  /// **'My QR Code'**
  String get myQrCode;

  /// Label for Short Bio section
  ///
  /// In en, this message translates to:
  /// **'Short Bio'**
  String get shortBio;

  /// Greeting or status inquiry
  ///
  /// In en, this message translates to:
  /// **'What\'s Up'**
  String get whatsUp;

  /// Gender option: Male
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// Gender option: Female
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// Gender option: Prefer not to say
  ///
  /// In en, this message translates to:
  /// **'Prefer not to say'**
  String get preferNotToSay;

  /// Default name placeholder
  ///
  /// In en, this message translates to:
  /// **'Little First'**
  String get littleFirst;

  /// Button text for update action
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// Label for new item
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newLabel;

  /// Label for current item
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get current;

  /// Character count display
  ///
  /// In en, this message translates to:
  /// **'{count}/{max}'**
  String characterCount(int count, int max);

  /// Helper text explaining name visibility
  ///
  /// In en, this message translates to:
  /// **'Your name will be visible to other users when you connect with them.'**
  String get nameVisibilityHelper;

  /// Validation message for empty name
  ///
  /// In en, this message translates to:
  /// **'{field} cannot be empty'**
  String nameCannotBeEmpty(String field);

  /// Validation message for minimum length
  ///
  /// In en, this message translates to:
  /// **'{field} must be at least {min} characters'**
  String nameMinLength(String field, int min);

  /// Validation message for maximum length
  ///
  /// In en, this message translates to:
  /// **'{field} cannot exceed {max} characters'**
  String nameMaxLength(String field, int max);

  /// Success message for name update
  ///
  /// In en, this message translates to:
  /// **'{field} updated successfully'**
  String nameUpdatedSuccessfully(String field);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
