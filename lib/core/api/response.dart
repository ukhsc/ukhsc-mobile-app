import 'package:freezed_annotation/freezed_annotation.dart';

import 'error.dart';
import '../error/exception.dart';

part 'response.freezed.dart';

@freezed
sealed class ApiResponse<T> with _$ApiResponse<T> {
  const ApiResponse._();

  const factory ApiResponse.data(T data) = ApiResponseData;
  const factory ApiResponse.error(int statusCode, ApiErrorData data) =
      ApiResponseError;
}

@freezed
sealed class ApiErrorData with _$ApiErrorData {
  const ApiErrorData._();

  const factory ApiErrorData.known(KnownErrorCode code) = KnownApiError;
  const factory ApiErrorData.internal() = InternalApiError;
  const factory ApiErrorData.unknown(Map<String, dynamic> raw) =
      UnknownApiError;

  factory ApiErrorData.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('code')) {
      final code = json['code'] as String;
      final knownError = KnownErrorCode.fromJson(code);
      if (knownError != null) {
        return ApiErrorData.known(knownError);
      }
      throw ArgumentError.value(code, 'json', 'Unknown error code');
    }

    if (json.containsKey('error')) {
      return const ApiErrorData.internal();
    }

    return ApiErrorData.unknown(json);
  }
}

extension ApiResponseExtension<D> on ApiResponse<D> {
  T handle<T>({
    required T Function(D data) onData,
    AppException? Function(KnownErrorCode code)? errorMapper,
  }) {
    switch (this) {
      case ApiResponseData(:final data):
        return onData(data);
      case ApiResponseError(:final data):
        final AppException? exception;

        if (data is KnownApiError) {
          exception = errorMapper?.call(data.code);
        } else {
          exception = null;
        }

        if (exception != null) {
          throw AppException(
            userReadableMessage: exception.userReadableMessage,
            originalError: this,
            stackTrace: StackTrace.current,
          );
        } else {
          throw this;
        }
    }
  }
}
