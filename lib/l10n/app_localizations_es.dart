// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Peers Touch';

  @override
  String get homePageTitle => 'Página de Inicio';

  @override
  String get navHome => 'Inicio';

  @override
  String get navChat => 'Chat';

  @override
  String get navPhoto => 'Foto';

  @override
  String get navProfile => 'Perfil';

  @override
  String get deviceInformation => 'Información del Dispositivo';

  @override
  String get installationStatus => 'Estado de Instalación';

  @override
  String get firstLaunch => 'Primer Lanzamiento';

  @override
  String get returningUser => 'Usuario Recurrente';

  @override
  String get deviceId => 'ID del Dispositivo (DID)';

  @override
  String get installationId => 'ID de Instalación';

  @override
  String get generatedAvatar => 'Avatar Generado';

  @override
  String get avatarDescription =>
      'Este avatar se genera basado en tu ID de dispositivo y permanecerá consistente en todas las sesiones de la aplicación:';

  @override
  String get resetDeviceId => 'Restablecer ID del Dispositivo (Prueba)';

  @override
  String get resetDeviceIdTitle => '¿Restablecer ID del Dispositivo?';

  @override
  String get resetDeviceIdMessage =>
      'Esto generará un nuevo ID de dispositivo e ID de instalación. Esta acción se usa típicamente solo para propósitos de prueba.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get reset => 'Restablecer';

  @override
  String get resetComplete => 'Restablecimiento Completo';

  @override
  String get resetCompleteMessage =>
      'El ID del dispositivo ha sido restablecido y regenerado';

  @override
  String get copied => 'Copiado';

  @override
  String get copiedMessage => 'Contenido copiado al portapapeles';

  @override
  String get copyToClipboard => 'Copiar al portapapeles';

  @override
  String get syncPhotos => 'Sincronizar Fotos';

  @override
  String get takePhoto => 'Tomar Foto';

  @override
  String get uploadPhoto => 'Subir Foto';

  @override
  String get selectProfilePicture => 'Seleccionar Foto de Perfil';

  @override
  String get chooseFromGallery => 'Elegir de la Galería';

  @override
  String get selectFromPhotos => 'Seleccionar de tus fotos';

  @override
  String get chooseFromPosts => 'Elegir de las Publicaciones';

  @override
  String get comingSoon => 'Próximamente...';

  @override
  String get comingSoonTitle => 'Próximamente';

  @override
  String get comingSoonMessage =>
      'Esta función estará disponible en futuras actualizaciones';

  @override
  String get ok => 'OK';

  @override
  String get selectPhoto => 'Seleccionar Foto';

  @override
  String get noPhotosFound => 'No se encontraron fotos';

  @override
  String get success => 'Éxito';

  @override
  String get profilePictureUpdated => 'Foto de perfil actualizada exitosamente';

  @override
  String get error => 'Error';

  @override
  String get permissionDenied => 'Permiso Denegado';

  @override
  String get needPhotoAccess =>
      'Se necesita acceso a fotos para seleccionar imagen de perfil';

  @override
  String get needMediaAccess =>
      'Se necesita acceso a medios para cargar álbumes';

  @override
  String get photosSyncedSuccessfully => 'Fotos sincronizadas exitosamente';

  @override
  String get failedToSyncPhotos => 'Falló la sincronización de fotos';

  @override
  String unexpectedError(String error) {
    return 'Ocurrió un error inesperado: $error';
  }

  @override
  String syncSelectedPhotos(int count) {
    return 'Sincronizar Fotos Seleccionadas ($count)';
  }

  @override
  String get userName => 'Nombre de Usuario';

  @override
  String get userBio =>
      'Biografía del Usuario Ja Ja ja jasd hola hola hola hola hola, hola hola hola hola hola hola hola hola hola';

  @override
  String get photoAlbums => 'Álbumes de Fotos';

  @override
  String get albumSync => 'Sincronización de Álbum';

  @override
  String get albumSyncMessage =>
      'Selecciona álbumes para sincronizar con tu cuenta. Los álbumes sincronizados estarán disponibles en todos tus dispositivos.';

  @override
  String get syncSelectedAlbums => 'Sincronizar Álbumes Seleccionados';

  @override
  String get selectAll => 'Seleccionar Todo';

  @override
  String get deselectAll => 'Deseleccionar Todo';

  @override
  String get noAlbumsSelected => 'No hay Álbumes Seleccionados';

  @override
  String get selectAtLeastOneAlbum =>
      'Por favor selecciona al menos un álbum para sincronizar';

  @override
  String get albumsSyncedSuccessfully => 'Álbumes sincronizados exitosamente';

  @override
  String get syncFailed => 'Sincronización Fallida';

  @override
  String get syncFailedMessage =>
      'La subida falló. Verifica:\n• Conexión de red\n• Disponibilidad del servidor\n• Permisos de fotos\n• Espacio de almacenamiento';

  @override
  String get networkConnectionFailed => 'Falló la conexión de red';

  @override
  String get requestTimedOut => 'La solicitud expiró';

  @override
  String get invalidServerResponse => 'Respuesta del servidor inválida';

  @override
  String get photoAccessDenied => 'Permiso de acceso a fotos denegado';

  @override
  String syncSelectedAlbumsCount(int count) {
    return 'Sincronizar Álbumes Seleccionados ($count)';
  }

  @override
  String get loading => 'Cargando...';

  @override
  String get errorLoadingCount => 'Error cargando el conteo';

  @override
  String itemsCount(int count) {
    return '$count elementos';
  }

  @override
  String get newGroup => 'Nuevo Grupo';

  @override
  String get addContact => 'Agregar Contacto';

  @override
  String get uploadingPhotos => 'Subiendo Fotos';

  @override
  String get uploadError => 'Error de Subida';

  @override
  String get storageError => 'Error de Almacenamiento';

  @override
  String get notEnoughStorageSpace =>
      'No hay suficiente espacio de almacenamiento en el dispositivo para cargar fotos. Por favor libera al menos 100MB de espacio e intenta de nuevo.';

  @override
  String get startingUpload => 'Iniciando subida...';

  @override
  String get cancellingUpload => 'Cancelando subida...';

  @override
  String get uploadCompletedSuccessfully => '¡Subida completada exitosamente!';

  @override
  String loadingPhotosFrom(String albumName) {
    return 'Cargando fotos de $albumName...';
  }

  @override
  String get friendName => 'Nombre del Amigo';

  @override
  String get samplePostContent =>
      'Este es un contenido de publicación de ejemplo...';

  @override
  String get increment => 'Incrementar';

  @override
  String get youHavePushedButton =>
      'Has presionado el botón esta cantidad de veces:';
}
