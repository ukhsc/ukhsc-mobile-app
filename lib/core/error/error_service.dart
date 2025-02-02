import 'dart:async';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:ukhsc_mobile_app/core/logger.dart';

import 'lib.dart';

part 'error_service.freezed.dart';
part 'error_service.g.dart';

@riverpod
class ErrorService extends _$ErrorService {
  Timer? _processTimer;
  final _logger = AppLogger.getLogger('error.handler');

  @override
  ErrorHandlerState build() {
    ref.onDispose(() {
      _processTimer?.cancel();
    });
    return const ErrorHandlerState();
  }

  Future<void> handleError(
    AppErrorEvent event, {
    final Object? originalError,
    final StackTrace? stackTrace,
  }) async {
    if (kEnableSentry) {
      late final SentryId eventId;

      if (event.severity == ErrorSeverity.panic) {
        eventId = await Sentry.captureException(
          originalError,
          stackTrace: stackTrace,
        );
      } else {
        eventId = await Sentry.captureEvent(
          SentryEvent(
            throwable: originalError,
            level: _getSentryLevel(event.severity),
          ),
          stackTrace: stackTrace,
        );
      }

      event = event.copyWith(sentryEventId: eventId);
    }
    _logger.warning('Error occurred: $event', originalError, stackTrace);

    state = state.copyWith(lastEvent: event);
    _scheduleErrorCleanup();
  }

  void _scheduleErrorCleanup() {
    _processTimer?.cancel();
    _processTimer = Timer(const Duration(seconds: 5), () {
      state = state.copyWith(lastEvent: null);
    });
  }

  SentryLevel _getSentryLevel(final ErrorSeverity severity) {
    switch (severity) {
      case ErrorSeverity.panic:
        return SentryLevel.fatal;

      case ErrorSeverity.scoped:
        return SentryLevel.error;

      case ErrorSeverity.warning:
        return SentryLevel.warning;

      case ErrorSeverity.global:
        return SentryLevel.info;
    }
  }
}

@Freezed(fromJson: false, toJson: false)
class ErrorHandlerState with _$ErrorHandlerState {
  const factory ErrorHandlerState({
    AppErrorEvent? lastEvent,
  }) = _ErrorState;
}
