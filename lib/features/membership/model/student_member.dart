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
    final int userId,
    final String? studentIdHash,
    final DateTime createdAt,
    final DateTime? activatedAt,
    final DateTime? expiredAt,
    final bool isActivated,
    final PartnerSchool schoolAttended,
    final MemberSettings? settings,
  ) = _StudentMember;

  factory StudentMember.fromJson(Map<String, dynamic> json) =>
      _$StudentMemberFromJson(json);
}

@freezed
abstract class MemberSettings with _$MemberSettings {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory MemberSettings({
    final String? nickname,
    final String? eInvoiceBarcode,
  }) = _MemberSettings;

  factory MemberSettings.fromJson(Map<String, dynamic> json) =>
      _$MemberSettingsFromJson(json);
}
