import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ukhsc_mobile_app/features/auth/models/lib.dart';

part 'student_member.freezed.dart';
part 'student_member.g.dart';

@freezed
abstract class StudentMember with _$StudentMember {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory StudentMember(
    final String id,
    final int schoolAttendedId,
    final PartnerSchool schoolAttended,
    final int userId,
    final String? studentIdHash,
    final String? nickname,
    final DateTime createdAt,
    final DateTime? activatedAt,
    final DateTime? expiredAt,
    final bool isActivated,
  ) = _StudentMember;

  factory StudentMember.fromJson(Map<String, dynamic> json) =>
      _$StudentMemberFromJson(json);
}
