// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StudentMember _$StudentMemberFromJson(Map<String, dynamic> json) {
  return _StudentMember.fromJson(json);
}

/// @nodoc
mixin _$StudentMember {
  String get id => throw _privateConstructorUsedError;
  int get schoolAttendedId => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  String? get studentId => throw _privateConstructorUsedError;
  String? get nickname => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get activatedAt => throw _privateConstructorUsedError;
  DateTime? get expiredAt => throw _privateConstructorUsedError;
  bool get isActivated => throw _privateConstructorUsedError;
  User get user => throw _privateConstructorUsedError;

  /// Serializes this StudentMember to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StudentMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudentMemberCopyWith<StudentMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentMemberCopyWith<$Res> {
  factory $StudentMemberCopyWith(
          StudentMember value, $Res Function(StudentMember) then) =
      _$StudentMemberCopyWithImpl<$Res, StudentMember>;
  @useResult
  $Res call(
      {String id,
      int schoolAttendedId,
      int userId,
      String? studentId,
      String? nickname,
      DateTime createdAt,
      DateTime? activatedAt,
      DateTime? expiredAt,
      bool isActivated,
      User user});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class _$StudentMemberCopyWithImpl<$Res, $Val extends StudentMember>
    implements $StudentMemberCopyWith<$Res> {
  _$StudentMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudentMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? schoolAttendedId = null,
    Object? userId = null,
    Object? studentId = freezed,
    Object? nickname = freezed,
    Object? createdAt = null,
    Object? activatedAt = freezed,
    Object? expiredAt = freezed,
    Object? isActivated = null,
    Object? user = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      schoolAttendedId: null == schoolAttendedId
          ? _value.schoolAttendedId
          : schoolAttendedId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      studentId: freezed == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String?,
      nickname: freezed == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      activatedAt: freezed == activatedAt
          ? _value.activatedAt
          : activatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiredAt: freezed == expiredAt
          ? _value.expiredAt
          : expiredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isActivated: null == isActivated
          ? _value.isActivated
          : isActivated // ignore: cast_nullable_to_non_nullable
              as bool,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ) as $Val);
  }

  /// Create a copy of StudentMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StudentMemberImplCopyWith<$Res>
    implements $StudentMemberCopyWith<$Res> {
  factory _$$StudentMemberImplCopyWith(
          _$StudentMemberImpl value, $Res Function(_$StudentMemberImpl) then) =
      __$$StudentMemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      int schoolAttendedId,
      int userId,
      String? studentId,
      String? nickname,
      DateTime createdAt,
      DateTime? activatedAt,
      DateTime? expiredAt,
      bool isActivated,
      User user});

  @override
  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$StudentMemberImplCopyWithImpl<$Res>
    extends _$StudentMemberCopyWithImpl<$Res, _$StudentMemberImpl>
    implements _$$StudentMemberImplCopyWith<$Res> {
  __$$StudentMemberImplCopyWithImpl(
      _$StudentMemberImpl _value, $Res Function(_$StudentMemberImpl) _then)
      : super(_value, _then);

  /// Create a copy of StudentMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? schoolAttendedId = null,
    Object? userId = null,
    Object? studentId = freezed,
    Object? nickname = freezed,
    Object? createdAt = null,
    Object? activatedAt = freezed,
    Object? expiredAt = freezed,
    Object? isActivated = null,
    Object? user = null,
  }) {
    return _then(_$StudentMemberImpl(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      null == schoolAttendedId
          ? _value.schoolAttendedId
          : schoolAttendedId // ignore: cast_nullable_to_non_nullable
              as int,
      null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      freezed == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      freezed == activatedAt
          ? _value.activatedAt
          : activatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      freezed == expiredAt
          ? _value.expiredAt
          : expiredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      null == isActivated
          ? _value.isActivated
          : isActivated // ignore: cast_nullable_to_non_nullable
              as bool,
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$StudentMemberImpl implements _StudentMember {
  _$StudentMemberImpl(
      this.id,
      this.schoolAttendedId,
      this.userId,
      this.studentId,
      this.nickname,
      this.createdAt,
      this.activatedAt,
      this.expiredAt,
      this.isActivated,
      this.user);

  factory _$StudentMemberImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudentMemberImplFromJson(json);

  @override
  final String id;
  @override
  final int schoolAttendedId;
  @override
  final int userId;
  @override
  final String? studentId;
  @override
  final String? nickname;
  @override
  final DateTime createdAt;
  @override
  final DateTime? activatedAt;
  @override
  final DateTime? expiredAt;
  @override
  final bool isActivated;
  @override
  final User user;

  @override
  String toString() {
    return 'StudentMember(id: $id, schoolAttendedId: $schoolAttendedId, userId: $userId, studentId: $studentId, nickname: $nickname, createdAt: $createdAt, activatedAt: $activatedAt, expiredAt: $expiredAt, isActivated: $isActivated, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentMemberImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.schoolAttendedId, schoolAttendedId) ||
                other.schoolAttendedId == schoolAttendedId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.activatedAt, activatedAt) ||
                other.activatedAt == activatedAt) &&
            (identical(other.expiredAt, expiredAt) ||
                other.expiredAt == expiredAt) &&
            (identical(other.isActivated, isActivated) ||
                other.isActivated == isActivated) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      schoolAttendedId,
      userId,
      studentId,
      nickname,
      createdAt,
      activatedAt,
      expiredAt,
      isActivated,
      user);

  /// Create a copy of StudentMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentMemberImplCopyWith<_$StudentMemberImpl> get copyWith =>
      __$$StudentMemberImplCopyWithImpl<_$StudentMemberImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudentMemberImplToJson(
      this,
    );
  }
}

abstract class _StudentMember implements StudentMember {
  factory _StudentMember(
      final String id,
      final int schoolAttendedId,
      final int userId,
      final String? studentId,
      final String? nickname,
      final DateTime createdAt,
      final DateTime? activatedAt,
      final DateTime? expiredAt,
      final bool isActivated,
      final User user) = _$StudentMemberImpl;

  factory _StudentMember.fromJson(Map<String, dynamic> json) =
      _$StudentMemberImpl.fromJson;

  @override
  String get id;
  @override
  int get schoolAttendedId;
  @override
  int get userId;
  @override
  String? get studentId;
  @override
  String? get nickname;
  @override
  DateTime get createdAt;
  @override
  DateTime? get activatedAt;
  @override
  DateTime? get expiredAt;
  @override
  bool get isActivated;
  @override
  User get user;

  /// Create a copy of StudentMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentMemberImplCopyWith<_$StudentMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
