import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory User(final int id, final String primaryEmail,
      final DateTime createdAt, final DateTime updatedAt) = _User;
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
