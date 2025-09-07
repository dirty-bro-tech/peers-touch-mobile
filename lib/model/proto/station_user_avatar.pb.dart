//
//  Generated code. Do not modify.
//  source: station_user_avatar.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// UserAvatar represents a user's profile avatar image
class UserAvatar extends $pb.GeneratedMessage {
  factory UserAvatar({
    $core.String? id,
    $core.String? userId,
    $core.String? filename,
    $core.String? url,
    $fixnum.Int64? size,
    $core.String? mimeType,
    $core.bool? isCurrent,
    $0.Timestamp? createdAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (filename != null) {
      $result.filename = filename;
    }
    if (url != null) {
      $result.url = url;
    }
    if (size != null) {
      $result.size = size;
    }
    if (mimeType != null) {
      $result.mimeType = mimeType;
    }
    if (isCurrent != null) {
      $result.isCurrent = isCurrent;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    return $result;
  }
  UserAvatar._() : super();
  factory UserAvatar.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserAvatar.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UserAvatar', package: const $pb.PackageName(_omitMessageNames ? '' : 'peers_touch.v1.user'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'filename')
    ..aOS(4, _omitFieldNames ? '' : 'url')
    ..aInt64(5, _omitFieldNames ? '' : 'size')
    ..aOS(6, _omitFieldNames ? '' : 'mimeType')
    ..aOB(7, _omitFieldNames ? '' : 'isCurrent')
    ..aOM<$0.Timestamp>(8, _omitFieldNames ? '' : 'createdAt', subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserAvatar clone() => UserAvatar()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserAvatar copyWith(void Function(UserAvatar) updates) => super.copyWith((message) => updates(message as UserAvatar)) as UserAvatar;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserAvatar create() => UserAvatar._();
  UserAvatar createEmptyInstance() => create();
  static $pb.PbList<UserAvatar> createRepeated() => $pb.PbList<UserAvatar>();
  @$core.pragma('dart2js:noInline')
  static UserAvatar getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserAvatar>(create);
  static UserAvatar? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get filename => $_getSZ(2);
  @$pb.TagNumber(3)
  set filename($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFilename() => $_has(2);
  @$pb.TagNumber(3)
  void clearFilename() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get url => $_getSZ(3);
  @$pb.TagNumber(4)
  set url($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearUrl() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get size => $_getI64(4);
  @$pb.TagNumber(5)
  set size($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSize() => $_has(4);
  @$pb.TagNumber(5)
  void clearSize() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get mimeType => $_getSZ(5);
  @$pb.TagNumber(6)
  set mimeType($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMimeType() => $_has(5);
  @$pb.TagNumber(6)
  void clearMimeType() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get isCurrent => $_getBF(6);
  @$pb.TagNumber(7)
  set isCurrent($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIsCurrent() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsCurrent() => $_clearField(7);

  @$pb.TagNumber(8)
  $0.Timestamp get createdAt => $_getN(7);
  @$pb.TagNumber(8)
  set createdAt($0.Timestamp v) { $_setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasCreatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreatedAt() => $_clearField(8);
  @$pb.TagNumber(8)
  $0.Timestamp ensureCreatedAt() => $_ensure(7);
}

/// UploadAvatarRequest is the request for uploading a new avatar
/// In practice, this is implemented as a multipart form upload with 'user_id' and 'avatar' fields
class UploadAvatarRequest extends $pb.GeneratedMessage {
  factory UploadAvatarRequest({
    $core.String? userId,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    return $result;
  }
  UploadAvatarRequest._() : super();
  factory UploadAvatarRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UploadAvatarRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UploadAvatarRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'peers_touch.v1.user'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UploadAvatarRequest clone() => UploadAvatarRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UploadAvatarRequest copyWith(void Function(UploadAvatarRequest) updates) => super.copyWith((message) => updates(message as UploadAvatarRequest)) as UploadAvatarRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadAvatarRequest create() => UploadAvatarRequest._();
  UploadAvatarRequest createEmptyInstance() => create();
  static $pb.PbList<UploadAvatarRequest> createRepeated() => $pb.PbList<UploadAvatarRequest>();
  @$core.pragma('dart2js:noInline')
  static UploadAvatarRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UploadAvatarRequest>(create);
  static UploadAvatarRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

/// UploadAvatarResponse is the response after uploading an avatar
class UploadAvatarResponse extends $pb.GeneratedMessage {
  factory UploadAvatarResponse({
    UserAvatar? avatar,
    $core.bool? success,
    $core.String? message,
  }) {
    final $result = create();
    if (avatar != null) {
      $result.avatar = avatar;
    }
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  UploadAvatarResponse._() : super();
  factory UploadAvatarResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UploadAvatarResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UploadAvatarResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'peers_touch.v1.user'), createEmptyInstance: create)
    ..aOM<UserAvatar>(1, _omitFieldNames ? '' : 'avatar', subBuilder: UserAvatar.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UploadAvatarResponse clone() => UploadAvatarResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UploadAvatarResponse copyWith(void Function(UploadAvatarResponse) updates) => super.copyWith((message) => updates(message as UploadAvatarResponse)) as UploadAvatarResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadAvatarResponse create() => UploadAvatarResponse._();
  UploadAvatarResponse createEmptyInstance() => create();
  static $pb.PbList<UploadAvatarResponse> createRepeated() => $pb.PbList<UploadAvatarResponse>();
  @$core.pragma('dart2js:noInline')
  static UploadAvatarResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UploadAvatarResponse>(create);
  static UploadAvatarResponse? _defaultInstance;

  @$pb.TagNumber(1)
  UserAvatar get avatar => $_getN(0);
  @$pb.TagNumber(1)
  set avatar(UserAvatar v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAvatar() => $_has(0);
  @$pb.TagNumber(1)
  void clearAvatar() => $_clearField(1);
  @$pb.TagNumber(1)
  UserAvatar ensureAvatar() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

/// GetUserAvatarsRequest is the request for retrieving a user's avatars
class GetUserAvatarsRequest extends $pb.GeneratedMessage {
  factory GetUserAvatarsRequest({
    $core.String? userId,
    $core.int? limit,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    return $result;
  }
  GetUserAvatarsRequest._() : super();
  factory GetUserAvatarsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserAvatarsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserAvatarsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'peers_touch.v1.user'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserAvatarsRequest clone() => GetUserAvatarsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserAvatarsRequest copyWith(void Function(GetUserAvatarsRequest) updates) => super.copyWith((message) => updates(message as GetUserAvatarsRequest)) as GetUserAvatarsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserAvatarsRequest create() => GetUserAvatarsRequest._();
  GetUserAvatarsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserAvatarsRequest> createRepeated() => $pb.PbList<GetUserAvatarsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserAvatarsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserAvatarsRequest>(create);
  static GetUserAvatarsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);
}

/// GetUserAvatarsResponse is the response containing user avatars
class GetUserAvatarsResponse extends $pb.GeneratedMessage {
  factory GetUserAvatarsResponse({
    $core.Iterable<UserAvatar>? avatars,
    $core.bool? success,
    $core.String? message,
  }) {
    final $result = create();
    if (avatars != null) {
      $result.avatars.addAll(avatars);
    }
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  GetUserAvatarsResponse._() : super();
  factory GetUserAvatarsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserAvatarsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserAvatarsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'peers_touch.v1.user'), createEmptyInstance: create)
    ..pc<UserAvatar>(1, _omitFieldNames ? '' : 'avatars', $pb.PbFieldType.PM, subBuilder: UserAvatar.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserAvatarsResponse clone() => GetUserAvatarsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserAvatarsResponse copyWith(void Function(GetUserAvatarsResponse) updates) => super.copyWith((message) => updates(message as GetUserAvatarsResponse)) as GetUserAvatarsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserAvatarsResponse create() => GetUserAvatarsResponse._();
  GetUserAvatarsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserAvatarsResponse> createRepeated() => $pb.PbList<GetUserAvatarsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserAvatarsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserAvatarsResponse>(create);
  static GetUserAvatarsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<UserAvatar> get avatars => $_getList(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
