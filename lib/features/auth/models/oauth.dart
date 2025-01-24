import 'package:freezed_annotation/freezed_annotation.dart';

part 'oauth.freezed.dart';
part 'oauth.g.dart';

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
