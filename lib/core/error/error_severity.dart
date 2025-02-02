enum ErrorSeverity {
  /// Unknown error that causes the entire app to crash.
  panic,

  /// Known error that affects the overall operation.
  global,

  /// Known error that impacts specific functionality.
  scoped,

  /// Warning that does not affect the current operation.
  warning,
}
