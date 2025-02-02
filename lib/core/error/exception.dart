class AppException implements Exception {
  final String userReadableMessage;
  final Object? originalError;
  final StackTrace? stackTrace;

  const AppException({
    required this.userReadableMessage,
    this.originalError,
    this.stackTrace,
  });
}
