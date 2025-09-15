// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Peers Touch';

  @override
  String get homePageTitle => '主页';

  @override
  String get navHome => '主页';

  @override
  String get navChat => '聊天';

  @override
  String get navPhoto => '照片';

  @override
  String get navProfile => '个人资料';

  @override
  String get deviceInformation => '设备信息';

  @override
  String get installationStatus => '安装状态';

  @override
  String get firstLaunch => '首次启动';

  @override
  String get returningUser => '回访用户';

  @override
  String get deviceId => '设备 ID (DID)';

  @override
  String get installationId => '安装 ID';

  @override
  String get generatedAvatar => '生成的头像';

  @override
  String get avatarDescription => '此头像基于您的设备 ID 生成，将在所有应用会话中保持一致：';

  @override
  String get resetDeviceId => '重置设备 ID (测试)';

  @override
  String get resetDeviceIdTitle => '重置设备 ID？';

  @override
  String get resetDeviceIdMessage => '这将生成新的设备 ID 和安装 ID。此操作通常仅用于测试目的。';

  @override
  String get cancel => '取消';

  @override
  String get reset => '重置';

  @override
  String get resetComplete => '重置完成';

  @override
  String get resetCompleteMessage => '设备 ID 已重置并重新生成';

  @override
  String get copied => '已复制';

  @override
  String get copiedMessage => '内容已复制到剪贴板';

  @override
  String get copyToClipboard => '复制到剪贴板';

  @override
  String get syncPhotos => '同步照片';

  @override
  String get takePhoto => '拍照';

  @override
  String get uploadPhoto => '上传照片';

  @override
  String get selectProfilePicture => '选择个人资料照片';

  @override
  String get chooseFromGallery => '从图库选择';

  @override
  String get selectFromPhotos => '从您的照片中选择';

  @override
  String get chooseFromPosts => '从帖子中选择';

  @override
  String get comingSoon => '即将推出...';

  @override
  String get comingSoonTitle => '即将推出';

  @override
  String get comingSoonMessage => '此功能将在未来更新中提供';

  @override
  String get ok => '确定';

  @override
  String get selectPhoto => '选择照片';

  @override
  String get noPhotosFound => '未找到照片';

  @override
  String get success => '成功';

  @override
  String get profilePictureUpdated => '个人资料照片更新成功';

  @override
  String get error => '错误';

  @override
  String get permissionDenied => '权限被拒绝';

  @override
  String get needPhotoAccess => '需要照片访问权限才能选择个人资料照片';

  @override
  String get needMediaAccess => '需要媒体访问权限才能加载相册';

  @override
  String get photosSyncedSuccessfully => '照片同步成功';

  @override
  String get failedToSyncPhotos => '照片同步失败';

  @override
  String unexpectedError(String error) {
    return '发生意外错误：$error';
  }

  @override
  String syncSelectedPhotos(int count) {
    return '同步选中的照片 ($count)';
  }

  @override
  String get userName => '用户名';

  @override
  String get userBio => '这是一个示例用户简介。';

  @override
  String get photoAlbums => '相册';

  @override
  String get albumSync => '相册同步';

  @override
  String get albumSyncMessage => '选择要与您的账户同步的相册。同步的相册将在您的所有设备上可用。';

  @override
  String get syncSelectedAlbums => '同步选中的相册';

  @override
  String get selectAll => '全选';

  @override
  String get deselectAll => '取消全选';

  @override
  String get noAlbumsSelected => '未选择相册';

  @override
  String get selectAtLeastOneAlbum => '请至少选择一个相册进行同步';

  @override
  String get albumsSyncedSuccessfully => '相册同步成功';

  @override
  String get syncFailed => '同步失败';

  @override
  String get syncFailedMessage => '上传失败。请检查：\n• 网络连接\n• 服务器可用性\n• 照片权限\n• 存储空间';

  @override
  String get networkConnectionFailed => '网络连接失败';

  @override
  String get requestTimedOut => '请求超时';

  @override
  String get invalidServerResponse => '服务器响应无效';

  @override
  String get photoAccessDenied => '照片访问权限被拒绝';

  @override
  String syncSelectedAlbumsCount(int count) {
    return '同步选中的相册 ($count)';
  }

  @override
  String get loading => '加载中...';

  @override
  String get errorLoadingCount => '加载计数出错';

  @override
  String itemsCount(int count) {
    return '$count 项';
  }

  @override
  String get newGroup => '新群组';

  @override
  String get addContact => '添加联系人';

  @override
  String get uploadingPhotos => '正在上传照片';

  @override
  String get uploadError => '上传错误';

  @override
  String get storageError => '存储错误';

  @override
  String get notEnoughStorageSpace => '设备存储空间不足，无法上传照片。请至少释放 100MB 空间后重试。';

  @override
  String get startingUpload => '开始上传...';

  @override
  String get cancellingUpload => '正在取消上传...';

  @override
  String get uploadCompletedSuccessfully => '上传成功完成！';

  @override
  String loadingPhotosFrom(String albumName) {
    return '正在从 $albumName 加载照片...';
  }

  @override
  String get friendName => '朋友姓名';

  @override
  String get samplePostContent => '这是一个示例帖子内容...';

  @override
  String get increment => '增加';

  @override
  String get youHavePushedButton => '您已按下按钮这么多次：';

  @override
  String get navMe => '我';

  @override
  String get meProfile => '个人资料';

  @override
  String get profilePhoto => '个人资料照片';

  @override
  String get name => '姓名';

  @override
  String get gender => '性别';

  @override
  String get region => '地区';

  @override
  String get email => '电子邮箱';

  @override
  String get peersId => 'Peers ID';

  @override
  String get myQrCode => '我的二维码';

  @override
  String get shortBio => '个人简介';

  @override
  String get whatsUp => '最近怎么样？';

  @override
  String get male => '男性';

  @override
  String get female => '女性';

  @override
  String get preferNotToSay => '不愿透露';

  @override
  String get littleFirst => '小名优先';

  @override
  String get update => '更新';

  @override
  String get newLabel => '新';

  @override
  String get current => '当前';

  @override
  String characterCount(int count, int max) {
    return '$count/$max';
  }

  @override
  String get nameVisibilityHelper => '当您与他人连接时，您的姓名将对其他用户可见。';

  @override
  String nameCannotBeEmpty(String field) {
    return '$field 不能为空';
  }

  @override
  String nameMinLength(String field, int min) {
    return '$field 至少需要 $min 个字符';
  }

  @override
  String nameMaxLength(String field, int max) {
    return '$field 不能超过 $max 个字符';
  }

  @override
  String nameUpdatedSuccessfully(String field) {
    return '$field 更新成功';
  }
}
