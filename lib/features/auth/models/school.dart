import 'package:freezed_annotation/freezed_annotation.dart';

part 'school.freezed.dart';
part 'school.g.dart';

@freezed
sealed class PartnerSchool with _$PartnerSchool {
  const PartnerSchool._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PartnerSchool.withConfig(
    final int id,
    final String shortName,
    final String fullName,
    final GoogleAccountConfig googleAccountConfig,
  ) = SchoolWithConfig;

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PartnerSchool(
    final int id,
    final String shortName,
    final String fullName,
  ) = School;

  factory PartnerSchool.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('google_account_config')) {
      return _$$SchoolWithConfigImplFromJson(json);
    }

    return _$$SchoolImplFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return map(
      (value) => _$$SchoolImplToJson(value as _$SchoolImpl),
      withConfig: (value) =>
          _$$SchoolWithConfigImplToJson(value as _$SchoolWithConfigImpl),
    );
  }
}

@freezed
abstract class GoogleAccountConfig with _$GoogleAccountConfig {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  factory GoogleAccountConfig(
    final String usernameFormat,
    final String studentUsernameFormat,
    final String passwordFormat,
    final String domainName,
  ) = _GoogleAccountConfig;

  factory GoogleAccountConfig.fromJson(Map<String, dynamic> json) =>
      _$GoogleAccountConfigFromJson(json);
}
