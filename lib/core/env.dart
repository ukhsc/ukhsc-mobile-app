import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(useConstantCase: true, requireEnvFile: false, obfuscate: true)
abstract class AppEnvironment {
  @EnviedField(defaultValue: 'development')
  static final DeployEnvironment deployEnvironment = _AppEnvironment.deployEnvironment;
  @EnviedField(defaultValue: 'https://api.ukhsc.org/api/v1')
  static final String apiBaseUrl = _AppEnvironment.apiBaseUrl;
  @EnviedField(optional: true)
  static final bool? useLocalFrontend = _AppEnvironment.useLocalFrontend;

  @EnviedField()
  static final String socialMediaLink = _AppEnvironment.socialMediaLink;
  @EnviedField(defaultValue: 'https://discord.gg/d5HhBG5jJA')
  static final String technicalSupportGroupLink = _AppEnvironment.technicalSupportGroupLink;
  @EnviedField()
  static final String privacyPolicyLink = _AppEnvironment.privacyPolicyLink;
  @EnviedField()
  static final String termsOfServiceLink = _AppEnvironment.termsOfServiceLink;

  @EnviedField(varName: 'SENTRY_DSN', optional: true)
  static final String? sentryDSN = _AppEnvironment.sentryDSN;
  @EnviedField()
  static final String googleOauthClientId = _AppEnvironment.googleOauthClientId;

  @EnviedField(optional: true)
  static final String? storeReviewerUsername = _AppEnvironment.storeReviewerUsername;
  @EnviedField(optional: true)
  static final String? storeReviewerPassword = _AppEnvironment.storeReviewerPassword;
  @EnviedField(optional: true)
  static final String? storeReviewerRefreshToken = _AppEnvironment.storeReviewerRefreshToken;
}

enum DeployEnvironment { development, staging, production }
