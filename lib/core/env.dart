import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(useConstantCase: true, requireEnvFile: false, obfuscate: true)
abstract class AppEnvironment {
  @EnviedField(defaultValue: 'https://api.ukhsc.org')
  static final String apiBaseUrl = _AppEnvironment.apiBaseUrl;

  @EnviedField()
  static final String socialMediaLink = _AppEnvironment.socialMediaLink;
  @EnviedField()
  static final String privacyPolicyLink = _AppEnvironment.privacyPolicyLink;
  @EnviedField()
  static final String termsOfServiceLink = _AppEnvironment.termsOfServiceLink;

  @EnviedField()
  static final String googleOauthClientId = _AppEnvironment.googleOauthClientId;
}
