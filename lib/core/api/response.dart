import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ukhsc_mobile_app/core/api/error.dart';

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
