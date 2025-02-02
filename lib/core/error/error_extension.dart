import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app_error_event.dart';
import 'error_service.dart';
import 'error_severity.dart';
import 'exception.dart';

extension AsyncErrorHandler<T> on AsyncValue<T> {
  void handleError(
    final WidgetRef ref, {
    final ErrorSeverity severity = ErrorSeverity.scoped,
    final VoidCallback? action,
    final String? actionLabel,
  }) {
    if (!hasError) return;

    String? message;
    Object? originalError = error;
    StackTrace? stackTrace = this.stackTrace;
    if (error case final AppException exception) {
      message = exception.userReadableMessage;
      originalError = exception.originalError;
      stackTrace = exception.stackTrace;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(errorServiceProvider.notifier);
      notifier.handleError(
        AppErrorEvent(
          severity: severity,
          message: message,
          action: action,
          actionLabel: actionLabel,
        ),
        originalError: originalError,
        stackTrace: stackTrace,
      );
    });
  }
}
