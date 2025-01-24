import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';

part 'member.freezed.dart';
part 'member.g.dart';

@freezed
abstract class StudentMember with _$StudentMember {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory StudentMember(
    final String id,
    final int schoolAttendedId,
    final int userId,
    final String? studentId,
    final String? nickname,
    final DateTime createdAt,
    final DateTime? activatedAt,
    final DateTime? expiredAt,
    final bool isActivated,
    final User user,
  ) = _StudentMember;

  factory StudentMember.fromJson(Map<String, dynamic> json) =>
      _$StudentMemberFromJson(json);
}
