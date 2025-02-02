import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'error_severity.dart';

part 'app_error_event.freezed.dart';

@freezed
abstract class AppErrorEvent with _$AppErrorEvent {
  const factory AppErrorEvent({
    required ErrorSeverity severity,
    String? message,
    VoidCallback? action,
    String? actionLabel,
    SentryId? sentryEventId,
  }) = _AppError;
}
