import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ua_client_hints/ua_client_hints.dart';

import 'response.dart';

part 'client.g.dart';

const apiBaseUrl = 'https://api.ukhsc.org';

extension CancelTokenX on Ref {
  CancelToken get cancelToken {
    final token = CancelToken();
    onDispose(token.cancel);

    return token;
  }
}

class ApiClient {
  final Dio _client;

  ApiClient._(this._client);

  factory ApiClient.configure() {
    final options = BaseOptions(
      baseUrl: apiBaseUrl,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    final dio = Dio(options);
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        if (Platform.isIOS || Platform.isAndroid) {
          final uaHeaders = await userAgentClientHintsHeader();
          options.headers.addAll(uaHeaders);
        }

        return handler.next(options);
      },
    ));
    dio.interceptors.add(
      LogInterceptor(responseBody: false),
    );

    return ApiClient._(dio);
  }

  ApiResponse<T> _handleResponse<T>(Response response) {
    try {
      return ApiResponse<T>.data(response.data);
    } on DioException catch (e) {
      final response = e.response;

      if (e.type == DioExceptionType.badResponse && response != null) {
        return ApiResponse<T>.error(response.statusCode!, response.data);
      } else {
        rethrow;
      }
    }
  }

  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    final request = _client.request<T>(
      path,
      options: Options(method: 'GET'),
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    );

    return _handleResponse<T>(await request);
  }
}

@riverpod
ApiClient apiClient(Ref ref) {
  return ApiClient.configure();
}
