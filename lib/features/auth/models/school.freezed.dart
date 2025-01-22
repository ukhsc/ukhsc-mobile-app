// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'school.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PartnerSchool _$PartnerSchoolFromJson(Map<String, dynamic> json) {
  return _School.fromJson(json);
}

/// @nodoc
mixin _$PartnerSchool {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'short_name')
  String get shortName => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name')
  String get fullName => throw _privateConstructorUsedError;
  @JsonKey(name: 'google_account_config')
  GoogleAccountConfig get googleAccountConfig =>
      throw _privateConstructorUsedError;

  /// Serializes this PartnerSchool to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PartnerSchool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PartnerSchoolCopyWith<PartnerSchool> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartnerSchoolCopyWith<$Res> {
  factory $PartnerSchoolCopyWith(
          PartnerSchool value, $Res Function(PartnerSchool) then) =
      _$PartnerSchoolCopyWithImpl<$Res, PartnerSchool>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'short_name') String shortName,
      @JsonKey(name: 'full_name') String fullName,
      @JsonKey(name: 'google_account_config')
      GoogleAccountConfig googleAccountConfig});

  $GoogleAccountConfigCopyWith<$Res> get googleAccountConfig;
}

/// @nodoc
class _$PartnerSchoolCopyWithImpl<$Res, $Val extends PartnerSchool>
    implements $PartnerSchoolCopyWith<$Res> {
  _$PartnerSchoolCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PartnerSchool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? shortName = null,
    Object? fullName = null,
    Object? googleAccountConfig = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      shortName: null == shortName
          ? _value.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      googleAccountConfig: null == googleAccountConfig
          ? _value.googleAccountConfig
          : googleAccountConfig // ignore: cast_nullable_to_non_nullable
              as GoogleAccountConfig,
    ) as $Val);
  }

  /// Create a copy of PartnerSchool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GoogleAccountConfigCopyWith<$Res> get googleAccountConfig {
    return $GoogleAccountConfigCopyWith<$Res>(_value.googleAccountConfig,
        (value) {
      return _then(_value.copyWith(googleAccountConfig: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SchoolImplCopyWith<$Res>
    implements $PartnerSchoolCopyWith<$Res> {
  factory _$$SchoolImplCopyWith(
          _$SchoolImpl value, $Res Function(_$SchoolImpl) then) =
      __$$SchoolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'short_name') String shortName,
      @JsonKey(name: 'full_name') String fullName,
      @JsonKey(name: 'google_account_config')
      GoogleAccountConfig googleAccountConfig});

  @override
  $GoogleAccountConfigCopyWith<$Res> get googleAccountConfig;
}

/// @nodoc
class __$$SchoolImplCopyWithImpl<$Res>
    extends _$PartnerSchoolCopyWithImpl<$Res, _$SchoolImpl>
    implements _$$SchoolImplCopyWith<$Res> {
  __$$SchoolImplCopyWithImpl(
      _$SchoolImpl _value, $Res Function(_$SchoolImpl) _then)
      : super(_value, _then);

  /// Create a copy of PartnerSchool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? shortName = null,
    Object? fullName = null,
    Object? googleAccountConfig = null,
  }) {
    return _then(_$SchoolImpl(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      null == shortName
          ? _value.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String,
      null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      null == googleAccountConfig
          ? _value.googleAccountConfig
          : googleAccountConfig // ignore: cast_nullable_to_non_nullable
              as GoogleAccountConfig,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$SchoolImpl implements _School {
  _$SchoolImpl(
      this.id,
      @JsonKey(name: 'short_name') this.shortName,
      @JsonKey(name: 'full_name') this.fullName,
      @JsonKey(name: 'google_account_config') this.googleAccountConfig);

  factory _$SchoolImpl.fromJson(Map<String, dynamic> json) =>
      _$$SchoolImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'short_name')
  final String shortName;
  @override
  @JsonKey(name: 'full_name')
  final String fullName;
  @override
  @JsonKey(name: 'google_account_config')
  final GoogleAccountConfig googleAccountConfig;

  @override
  String toString() {
    return 'PartnerSchool(id: $id, shortName: $shortName, fullName: $fullName, googleAccountConfig: $googleAccountConfig)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SchoolImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.googleAccountConfig, googleAccountConfig) ||
                other.googleAccountConfig == googleAccountConfig));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, shortName, fullName, googleAccountConfig);

  /// Create a copy of PartnerSchool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SchoolImplCopyWith<_$SchoolImpl> get copyWith =>
      __$$SchoolImplCopyWithImpl<_$SchoolImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SchoolImplToJson(
      this,
    );
  }
}

abstract class _School implements PartnerSchool {
  factory _School(
      final int id,
      @JsonKey(name: 'short_name') final String shortName,
      @JsonKey(name: 'full_name') final String fullName,
      @JsonKey(name: 'google_account_config')
      final GoogleAccountConfig googleAccountConfig) = _$SchoolImpl;

  factory _School.fromJson(Map<String, dynamic> json) = _$SchoolImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'short_name')
  String get shortName;
  @override
  @JsonKey(name: 'full_name')
  String get fullName;
  @override
  @JsonKey(name: 'google_account_config')
  GoogleAccountConfig get googleAccountConfig;

  /// Create a copy of PartnerSchool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SchoolImplCopyWith<_$SchoolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GoogleAccountConfig _$GoogleAccountConfigFromJson(Map<String, dynamic> json) {
  return _GoogleAccountConfig.fromJson(json);
}

/// @nodoc
mixin _$GoogleAccountConfig {
  @JsonKey(name: 'username_format')
  String get usernameFormat => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_username_format')
  String get studentUsernameFormat => throw _privateConstructorUsedError;
  @JsonKey(name: 'password_format')
  String get passwordFormat => throw _privateConstructorUsedError;
  @JsonKey(name: 'domain_name')
  String get domainName => throw _privateConstructorUsedError;

  /// Serializes this GoogleAccountConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GoogleAccountConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GoogleAccountConfigCopyWith<GoogleAccountConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoogleAccountConfigCopyWith<$Res> {
  factory $GoogleAccountConfigCopyWith(
          GoogleAccountConfig value, $Res Function(GoogleAccountConfig) then) =
      _$GoogleAccountConfigCopyWithImpl<$Res, GoogleAccountConfig>;
  @useResult
  $Res call(
      {@JsonKey(name: 'username_format') String usernameFormat,
      @JsonKey(name: 'student_username_format') String studentUsernameFormat,
      @JsonKey(name: 'password_format') String passwordFormat,
      @JsonKey(name: 'domain_name') String domainName});
}

/// @nodoc
class _$GoogleAccountConfigCopyWithImpl<$Res, $Val extends GoogleAccountConfig>
    implements $GoogleAccountConfigCopyWith<$Res> {
  _$GoogleAccountConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GoogleAccountConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? usernameFormat = null,
    Object? studentUsernameFormat = null,
    Object? passwordFormat = null,
    Object? domainName = null,
  }) {
    return _then(_value.copyWith(
      usernameFormat: null == usernameFormat
          ? _value.usernameFormat
          : usernameFormat // ignore: cast_nullable_to_non_nullable
              as String,
      studentUsernameFormat: null == studentUsernameFormat
          ? _value.studentUsernameFormat
          : studentUsernameFormat // ignore: cast_nullable_to_non_nullable
              as String,
      passwordFormat: null == passwordFormat
          ? _value.passwordFormat
          : passwordFormat // ignore: cast_nullable_to_non_nullable
              as String,
      domainName: null == domainName
          ? _value.domainName
          : domainName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GoogleAccountConfigImplCopyWith<$Res>
    implements $GoogleAccountConfigCopyWith<$Res> {
  factory _$$GoogleAccountConfigImplCopyWith(_$GoogleAccountConfigImpl value,
          $Res Function(_$GoogleAccountConfigImpl) then) =
      __$$GoogleAccountConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'username_format') String usernameFormat,
      @JsonKey(name: 'student_username_format') String studentUsernameFormat,
      @JsonKey(name: 'password_format') String passwordFormat,
      @JsonKey(name: 'domain_name') String domainName});
}

/// @nodoc
class __$$GoogleAccountConfigImplCopyWithImpl<$Res>
    extends _$GoogleAccountConfigCopyWithImpl<$Res, _$GoogleAccountConfigImpl>
    implements _$$GoogleAccountConfigImplCopyWith<$Res> {
  __$$GoogleAccountConfigImplCopyWithImpl(_$GoogleAccountConfigImpl _value,
      $Res Function(_$GoogleAccountConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of GoogleAccountConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? usernameFormat = null,
    Object? studentUsernameFormat = null,
    Object? passwordFormat = null,
    Object? domainName = null,
  }) {
    return _then(_$GoogleAccountConfigImpl(
      null == usernameFormat
          ? _value.usernameFormat
          : usernameFormat // ignore: cast_nullable_to_non_nullable
              as String,
      null == studentUsernameFormat
          ? _value.studentUsernameFormat
          : studentUsernameFormat // ignore: cast_nullable_to_non_nullable
              as String,
      null == passwordFormat
          ? _value.passwordFormat
          : passwordFormat // ignore: cast_nullable_to_non_nullable
              as String,
      null == domainName
          ? _value.domainName
          : domainName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$GoogleAccountConfigImpl implements _GoogleAccountConfig {
  _$GoogleAccountConfigImpl(
      @JsonKey(name: 'username_format') this.usernameFormat,
      @JsonKey(name: 'student_username_format') this.studentUsernameFormat,
      @JsonKey(name: 'password_format') this.passwordFormat,
      @JsonKey(name: 'domain_name') this.domainName);

  factory _$GoogleAccountConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$GoogleAccountConfigImplFromJson(json);

  @override
  @JsonKey(name: 'username_format')
  final String usernameFormat;
  @override
  @JsonKey(name: 'student_username_format')
  final String studentUsernameFormat;
  @override
  @JsonKey(name: 'password_format')
  final String passwordFormat;
  @override
  @JsonKey(name: 'domain_name')
  final String domainName;

  @override
  String toString() {
    return 'GoogleAccountConfig(usernameFormat: $usernameFormat, studentUsernameFormat: $studentUsernameFormat, passwordFormat: $passwordFormat, domainName: $domainName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoogleAccountConfigImpl &&
            (identical(other.usernameFormat, usernameFormat) ||
                other.usernameFormat == usernameFormat) &&
            (identical(other.studentUsernameFormat, studentUsernameFormat) ||
                other.studentUsernameFormat == studentUsernameFormat) &&
            (identical(other.passwordFormat, passwordFormat) ||
                other.passwordFormat == passwordFormat) &&
            (identical(other.domainName, domainName) ||
                other.domainName == domainName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, usernameFormat,
      studentUsernameFormat, passwordFormat, domainName);

  /// Create a copy of GoogleAccountConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GoogleAccountConfigImplCopyWith<_$GoogleAccountConfigImpl> get copyWith =>
      __$$GoogleAccountConfigImplCopyWithImpl<_$GoogleAccountConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GoogleAccountConfigImplToJson(
      this,
    );
  }
}

abstract class _GoogleAccountConfig implements GoogleAccountConfig {
  factory _GoogleAccountConfig(
          @JsonKey(name: 'username_format') final String usernameFormat,
          @JsonKey(name: 'student_username_format')
          final String studentUsernameFormat,
          @JsonKey(name: 'password_format') final String passwordFormat,
          @JsonKey(name: 'domain_name') final String domainName) =
      _$GoogleAccountConfigImpl;

  factory _GoogleAccountConfig.fromJson(Map<String, dynamic> json) =
      _$GoogleAccountConfigImpl.fromJson;

  @override
  @JsonKey(name: 'username_format')
  String get usernameFormat;
  @override
  @JsonKey(name: 'student_username_format')
  String get studentUsernameFormat;
  @override
  @JsonKey(name: 'password_format')
  String get passwordFormat;
  @override
  @JsonKey(name: 'domain_name')
  String get domainName;

  /// Create a copy of GoogleAccountConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoogleAccountConfigImplCopyWith<_$GoogleAccountConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
