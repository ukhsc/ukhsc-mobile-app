import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ua_client_hints/ua_client_hints.dart';

import 'response.dart';
import '../env.dart';

part 'client.g.dart';

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
    Map<String, String>? uaHeaders;
    final options = BaseOptions(
      baseUrl: AppEnvironment.apiBaseUrl,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    final dio = Dio(options);
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        if (!kIsWeb) {
          options.headers
              .addAll(uaHeaders ??= await userAgentClientHintsHeader());
        }

        return handler.next(options);
      },
    ));

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

  Future<ApiResponse<T>> request<T>(
    HttpMethod method,
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    String? token,
    CancelToken? cancelToken,
  }) async {
    final request = _client.request<T>(
      path,
      options: Options(
        method: method.value,
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
        },
        responseType: ResponseType.json,
      ),
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    );

    return _handleResponse<T>(await request);
  }
}

enum HttpMethod {
  get,
  post;

  String get value {
    switch (this) {
      case HttpMethod.get:
        return 'GET';
      case HttpMethod.post:
        return 'POST';
    }
  }
}

@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) {
  return ApiClient.configure();
}
