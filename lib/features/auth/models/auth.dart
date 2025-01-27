import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';

part 'auth.freezed.dart';
part 'auth.g.dart';

@freezed
sealed class OAuthCallbackState with _$OAuthCallbackState {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory OAuthCallbackState.registerMember({
    required final String redirectUri,
    required final bool isNativeApp,
    required final int schoolId,
  }) = RegisterMember;

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory OAuthCallbackState.linkFederatedAccount({
    required final String redirectUri,
    required final bool isNativeApp,
    required final int memberId,
    required final FederatedProvider provider,
  }) = LinkFederatedAccount;

  factory OAuthCallbackState.fromJson(Map<String, dynamic> json) =>
      _$OAuthCallbackStateFromJson(json);
}

enum FederatedProvider { google, googleWorkspace }

@freezed
abstract class TokenPayload with _$TokenPayload {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TokenPayload({
    required final int userId,
    required final List<UserRole> roles,
    required final int deviceId,

    // Standard Registered Claims
    @EpochDateTimeConverter() required final DateTime iat,
    @EpochDateTimeConverter() required final DateTime exp,
  }) = _TokenPayload;

  factory TokenPayload.fromJson(Map<String, dynamic> json) =>
      _$TokenPayloadFromJson(json);

  factory TokenPayload.fromJwt(String jwt) {
    try {
      final raw = JWT.decode(jwt);
      return TokenPayload.fromJson(raw.payload);
    } catch (e) {
      throw Exception('Invalid JWT token payload: $e');
    }
  }
}

class EpochDateTimeConverter implements JsonConverter<DateTime, int> {
  const EpochDateTimeConverter();

  @override
  DateTime fromJson(int json) =>
      DateTime.fromMillisecondsSinceEpoch(json * 1000);

  @override
  int toJson(DateTime object) => object.millisecondsSinceEpoch ~/ 1000;
}
