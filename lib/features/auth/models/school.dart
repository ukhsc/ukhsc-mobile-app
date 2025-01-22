import 'package:freezed_annotation/freezed_annotation.dart';

part 'school.freezed.dart';
part 'school.g.dart';

@freezed
abstract class PartnerSchool with _$PartnerSchool {
  @JsonSerializable(explicitToJson: true)
  factory PartnerSchool(
    final int id,
    @JsonKey(name: 'short_name') final String shortName,
    @JsonKey(name: 'full_name') final String fullName,
    @JsonKey(name: 'google_account_config')
    final GoogleAccountConfig googleAccountConfig,
  ) = _School;
  factory PartnerSchool.fromJson(Map<String, dynamic> json) =>
      _$PartnerSchoolFromJson(json);
}

@freezed
abstract class GoogleAccountConfig with _$GoogleAccountConfig {
  @JsonSerializable(explicitToJson: true)
  factory GoogleAccountConfig(
    @JsonKey(name: 'username_format') final String usernameFormat,
    @JsonKey(name: 'student_username_format')
    final String studentUsernameFormat,
    @JsonKey(name: 'password_format') final String passwordFormat,
    @JsonKey(name: 'domain_name') final String domainName,
  ) = _GoogleAccountConfig;

  factory GoogleAccountConfig.fromJson(Map<String, dynamic> json) =>
      _$GoogleAccountConfigFromJson(json);
}
