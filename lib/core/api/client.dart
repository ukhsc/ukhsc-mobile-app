import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentry_dio/sentry_dio.dart';
import 'package:ua_client_hints/ua_client_hints.dart';

import 'package:ukhsc_mobile_app/core/logger.dart';
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
  final _logger = AppLogger.getLogger('api');

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
    dio.addSentry();

    return ApiClient._(dio);
  }

  Future<ApiResponse<T>> _handleRequest<T>(Future<Response> request) async {
    try {
      final response = await request;
      return ApiResponse<T>.data(response.data);
    } on DioException catch (e) {
      final response = e.response;

      if (e.type == DioExceptionType.badResponse && response != null) {
        final data = ApiErrorData.fromJson(response.data);
        if (data is UnknownApiError) {
          _logger.warning('Unknown API error: ${data.raw}');
        }

        return ApiResponse.error(response.statusCode!, data);
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
        sendTimeout: kIsWeb ? null : const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    );

    return await _handleRequest<T>(request);
  }
}

enum HttpMethod {
  get,
  put,
  patch,
  post;

  String get value {
    switch (this) {
      case HttpMethod.get:
        return 'GET';
      case HttpMethod.post:
        return 'POST';
      case HttpMethod.put:
        return 'PUT';
      case HttpMethod.patch:
        return 'PATCH';
    }
  }
}

@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) {
  return ApiClient.configure();
}
