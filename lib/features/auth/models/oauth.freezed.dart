// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'oauth.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OAuthCallbackState _$OAuthCallbackStateFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'registerMember':
      return RegisterMember.fromJson(json);
    case 'linkFederatedAccount':
      return LinkFederatedAccount.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'OAuthCallbackState',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$OAuthCallbackState {
  String get redirectUri => throw _privateConstructorUsedError;
  bool get isNativeApp => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String redirectUri, bool isNativeApp, int schoolId)
        registerMember,
    required TResult Function(String redirectUri, bool isNativeApp,
            int memberId, FederatedProvider provider)
        linkFederatedAccount,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String redirectUri, bool isNativeApp, int schoolId)?
        registerMember,
    TResult? Function(String redirectUri, bool isNativeApp, int memberId,
            FederatedProvider provider)?
        linkFederatedAccount,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String redirectUri, bool isNativeApp, int schoolId)?
        registerMember,
    TResult Function(String redirectUri, bool isNativeApp, int memberId,
            FederatedProvider provider)?
        linkFederatedAccount,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterMember value) registerMember,
    required TResult Function(LinkFederatedAccount value) linkFederatedAccount,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterMember value)? registerMember,
    TResult? Function(LinkFederatedAccount value)? linkFederatedAccount,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterMember value)? registerMember,
    TResult Function(LinkFederatedAccount value)? linkFederatedAccount,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this OAuthCallbackState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OAuthCallbackState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OAuthCallbackStateCopyWith<OAuthCallbackState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OAuthCallbackStateCopyWith<$Res> {
  factory $OAuthCallbackStateCopyWith(
          OAuthCallbackState value, $Res Function(OAuthCallbackState) then) =
      _$OAuthCallbackStateCopyWithImpl<$Res, OAuthCallbackState>;
  @useResult
  $Res call({String redirectUri, bool isNativeApp});
}

/// @nodoc
class _$OAuthCallbackStateCopyWithImpl<$Res, $Val extends OAuthCallbackState>
    implements $OAuthCallbackStateCopyWith<$Res> {
  _$OAuthCallbackStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OAuthCallbackState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? redirectUri = null,
    Object? isNativeApp = null,
  }) {
    return _then(_value.copyWith(
      redirectUri: null == redirectUri
          ? _value.redirectUri
          : redirectUri // ignore: cast_nullable_to_non_nullable
              as String,
      isNativeApp: null == isNativeApp
          ? _value.isNativeApp
          : isNativeApp // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegisterMemberImplCopyWith<$Res>
    implements $OAuthCallbackStateCopyWith<$Res> {
  factory _$$RegisterMemberImplCopyWith(_$RegisterMemberImpl value,
          $Res Function(_$RegisterMemberImpl) then) =
      __$$RegisterMemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String redirectUri, bool isNativeApp, int schoolId});
}

/// @nodoc
class __$$RegisterMemberImplCopyWithImpl<$Res>
    extends _$OAuthCallbackStateCopyWithImpl<$Res, _$RegisterMemberImpl>
    implements _$$RegisterMemberImplCopyWith<$Res> {
  __$$RegisterMemberImplCopyWithImpl(
      _$RegisterMemberImpl _value, $Res Function(_$RegisterMemberImpl) _then)
      : super(_value, _then);

  /// Create a copy of OAuthCallbackState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? redirectUri = null,
    Object? isNativeApp = null,
    Object? schoolId = null,
  }) {
    return _then(_$RegisterMemberImpl(
      redirectUri: null == redirectUri
          ? _value.redirectUri
          : redirectUri // ignore: cast_nullable_to_non_nullable
              as String,
      isNativeApp: null == isNativeApp
          ? _value.isNativeApp
          : isNativeApp // ignore: cast_nullable_to_non_nullable
              as bool,
      schoolId: null == schoolId
          ? _value.schoolId
          : schoolId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$RegisterMemberImpl implements RegisterMember {
  const _$RegisterMemberImpl(
      {required this.redirectUri,
      required this.isNativeApp,
      required this.schoolId,
      final String? $type})
      : $type = $type ?? 'registerMember';

  factory _$RegisterMemberImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegisterMemberImplFromJson(json);

  @override
  final String redirectUri;
  @override
  final bool isNativeApp;
  @override
  final int schoolId;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'OAuthCallbackState.registerMember(redirectUri: $redirectUri, isNativeApp: $isNativeApp, schoolId: $schoolId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterMemberImpl &&
            (identical(other.redirectUri, redirectUri) ||
                other.redirectUri == redirectUri) &&
            (identical(other.isNativeApp, isNativeApp) ||
                other.isNativeApp == isNativeApp) &&
            (identical(other.schoolId, schoolId) ||
                other.schoolId == schoolId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, redirectUri, isNativeApp, schoolId);

  /// Create a copy of OAuthCallbackState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterMemberImplCopyWith<_$RegisterMemberImpl> get copyWith =>
      __$$RegisterMemberImplCopyWithImpl<_$RegisterMemberImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String redirectUri, bool isNativeApp, int schoolId)
        registerMember,
    required TResult Function(String redirectUri, bool isNativeApp,
            int memberId, FederatedProvider provider)
        linkFederatedAccount,
  }) {
    return registerMember(redirectUri, isNativeApp, schoolId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String redirectUri, bool isNativeApp, int schoolId)?
        registerMember,
    TResult? Function(String redirectUri, bool isNativeApp, int memberId,
            FederatedProvider provider)?
        linkFederatedAccount,
  }) {
    return registerMember?.call(redirectUri, isNativeApp, schoolId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String redirectUri, bool isNativeApp, int schoolId)?
        registerMember,
    TResult Function(String redirectUri, bool isNativeApp, int memberId,
            FederatedProvider provider)?
        linkFederatedAccount,
    required TResult orElse(),
  }) {
    if (registerMember != null) {
      return registerMember(redirectUri, isNativeApp, schoolId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterMember value) registerMember,
    required TResult Function(LinkFederatedAccount value) linkFederatedAccount,
  }) {
    return registerMember(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterMember value)? registerMember,
    TResult? Function(LinkFederatedAccount value)? linkFederatedAccount,
  }) {
    return registerMember?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterMember value)? registerMember,
    TResult Function(LinkFederatedAccount value)? linkFederatedAccount,
    required TResult orElse(),
  }) {
    if (registerMember != null) {
      return registerMember(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RegisterMemberImplToJson(
      this,
    );
  }
}

abstract class RegisterMember implements OAuthCallbackState {
  const factory RegisterMember(
      {required final String redirectUri,
      required final bool isNativeApp,
      required final int schoolId}) = _$RegisterMemberImpl;

  factory RegisterMember.fromJson(Map<String, dynamic> json) =
      _$RegisterMemberImpl.fromJson;

  @override
  String get redirectUri;
  @override
  bool get isNativeApp;
  int get schoolId;

  /// Create a copy of OAuthCallbackState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterMemberImplCopyWith<_$RegisterMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LinkFederatedAccountImplCopyWith<$Res>
    implements $OAuthCallbackStateCopyWith<$Res> {
  factory _$$LinkFederatedAccountImplCopyWith(_$LinkFederatedAccountImpl value,
          $Res Function(_$LinkFederatedAccountImpl) then) =
      __$$LinkFederatedAccountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String redirectUri,
      bool isNativeApp,
      int memberId,
      FederatedProvider provider});
}

/// @nodoc
class __$$LinkFederatedAccountImplCopyWithImpl<$Res>
    extends _$OAuthCallbackStateCopyWithImpl<$Res, _$LinkFederatedAccountImpl>
    implements _$$LinkFederatedAccountImplCopyWith<$Res> {
  __$$LinkFederatedAccountImplCopyWithImpl(_$LinkFederatedAccountImpl _value,
      $Res Function(_$LinkFederatedAccountImpl) _then)
      : super(_value, _then);

  /// Create a copy of OAuthCallbackState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? redirectUri = null,
    Object? isNativeApp = null,
    Object? memberId = null,
    Object? provider = null,
  }) {
    return _then(_$LinkFederatedAccountImpl(
      redirectUri: null == redirectUri
          ? _value.redirectUri
          : redirectUri // ignore: cast_nullable_to_non_nullable
              as String,
      isNativeApp: null == isNativeApp
          ? _value.isNativeApp
          : isNativeApp // ignore: cast_nullable_to_non_nullable
              as bool,
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as int,
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as FederatedProvider,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$LinkFederatedAccountImpl implements LinkFederatedAccount {
  const _$LinkFederatedAccountImpl(
      {required this.redirectUri,
      required this.isNativeApp,
      required this.memberId,
      required this.provider,
      final String? $type})
      : $type = $type ?? 'linkFederatedAccount';

  factory _$LinkFederatedAccountImpl.fromJson(Map<String, dynamic> json) =>
      _$$LinkFederatedAccountImplFromJson(json);

  @override
  final String redirectUri;
  @override
  final bool isNativeApp;
  @override
  final int memberId;
  @override
  final FederatedProvider provider;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'OAuthCallbackState.linkFederatedAccount(redirectUri: $redirectUri, isNativeApp: $isNativeApp, memberId: $memberId, provider: $provider)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LinkFederatedAccountImpl &&
            (identical(other.redirectUri, redirectUri) ||
                other.redirectUri == redirectUri) &&
            (identical(other.isNativeApp, isNativeApp) ||
                other.isNativeApp == isNativeApp) &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.provider, provider) ||
                other.provider == provider));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, redirectUri, isNativeApp, memberId, provider);

  /// Create a copy of OAuthCallbackState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LinkFederatedAccountImplCopyWith<_$LinkFederatedAccountImpl>
      get copyWith =>
          __$$LinkFederatedAccountImplCopyWithImpl<_$LinkFederatedAccountImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String redirectUri, bool isNativeApp, int schoolId)
        registerMember,
    required TResult Function(String redirectUri, bool isNativeApp,
            int memberId, FederatedProvider provider)
        linkFederatedAccount,
  }) {
    return linkFederatedAccount(redirectUri, isNativeApp, memberId, provider);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String redirectUri, bool isNativeApp, int schoolId)?
        registerMember,
    TResult? Function(String redirectUri, bool isNativeApp, int memberId,
            FederatedProvider provider)?
        linkFederatedAccount,
  }) {
    return linkFederatedAccount?.call(
        redirectUri, isNativeApp, memberId, provider);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String redirectUri, bool isNativeApp, int schoolId)?
        registerMember,
    TResult Function(String redirectUri, bool isNativeApp, int memberId,
            FederatedProvider provider)?
        linkFederatedAccount,
    required TResult orElse(),
  }) {
    if (linkFederatedAccount != null) {
      return linkFederatedAccount(redirectUri, isNativeApp, memberId, provider);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterMember value) registerMember,
    required TResult Function(LinkFederatedAccount value) linkFederatedAccount,
  }) {
    return linkFederatedAccount(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterMember value)? registerMember,
    TResult? Function(LinkFederatedAccount value)? linkFederatedAccount,
  }) {
    return linkFederatedAccount?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterMember value)? registerMember,
    TResult Function(LinkFederatedAccount value)? linkFederatedAccount,
    required TResult orElse(),
  }) {
    if (linkFederatedAccount != null) {
      return linkFederatedAccount(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LinkFederatedAccountImplToJson(
      this,
    );
  }
}

abstract class LinkFederatedAccount implements OAuthCallbackState {
  const factory LinkFederatedAccount(
      {required final String redirectUri,
      required final bool isNativeApp,
      required final int memberId,
      required final FederatedProvider provider}) = _$LinkFederatedAccountImpl;

  factory LinkFederatedAccount.fromJson(Map<String, dynamic> json) =
      _$LinkFederatedAccountImpl.fromJson;

  @override
  String get redirectUri;
  @override
  bool get isNativeApp;
  int get memberId;
  FederatedProvider get provider;

  /// Create a copy of OAuthCallbackState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LinkFederatedAccountImplCopyWith<_$LinkFederatedAccountImpl>
      get copyWith => throw _privateConstructorUsedError;
}
