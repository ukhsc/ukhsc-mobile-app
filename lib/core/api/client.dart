import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentry_dio/sentry_dio.dart';
import 'package:ua_client_hints/ua_client_hints.dart';

import 'package:ukhsc_mobile_app/core/config/network_config.dart';
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
      connectTimeout: NetworkConfig.defaultConnectTimeout,
      receiveTimeout: NetworkConfig.defaultReceiveTimeout,
      sendTimeout: NetworkConfig.defaultSendTimeout,
      headers: {
        'Content-Type': 'application/json',
      },
      validateStatus: (status) {
        return status != null && 
               status >= 200 && 
               status < 300;
      },
    );

    final dio = Dio(options);
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        if (!kIsWeb) {
          uaHeaders ??= await userAgentClientHintsHeader();
          uaHeaders = uaHeaders!.map((key, value) =>
              MapEntry(key, value.replaceAll('高校特約', 'ukhsc-mobile-app')));
          options.extra['startTime'] = DateTime.now().millisecondsSinceEpoch;
          options.headers.addAll(uaHeaders!);
        }


        return handler.next(options);
      },
    ));
    dio.addSentry();
    
    // Add retry interceptor
    dio.interceptors.add(InterceptorsWrapper(
      onError: (DioException e, handler) async {
        final options = e.requestOptions;
        final attemptCount = (options.extra['retryCount'] ?? 0) as int;
        
        if (_shouldRetry(e) && attemptCount < NetworkConfig.maxRetryAttempts) {
          options.extra['retryCount'] = attemptCount + 1;
          
          final delay = NetworkConfig.getRetryDelay(attemptCount);
          AppLogger.getLogger('api').info(
            'Retrying request (${attemptCount + 1}/${NetworkConfig.maxRetryAttempts}) '
            'to ${options.path} after ${delay.inSeconds}s'
          );
          
          await Future.delayed(delay);
          
          try {
            final response = await dio.fetch(options);
            return handler.resolve(response);
          } catch (retryError) {
            return handler.next(e);
          }
        }
        
        return handler.next(e);
      },
      onResponse: (response, handler) {
        final startTime = response.requestOptions.extra['startTime'] as int?;
        if (startTime != null) {
          final duration = DateTime.now().millisecondsSinceEpoch - startTime;
          AppLogger.getLogger('api').fine(
            'Request completed: ${response.requestOptions.path} '
            '(${duration}ms)'
          );
        }
        return handler.next(response);
      },
    ));

    return ApiClient._(dio);
  }
  
  bool _shouldRetry(DioException error) {
    return error.type == DioExceptionType.connectionTimeout ||
           error.type == DioExceptionType.sendTimeout ||
           error.type == DioExceptionType.receiveTimeout ||
           (error.response?.statusCode != null &&
            NetworkConfig.retryableStatusCodes.contains(error.response!.statusCode));
  }

  Future<ApiResponse<T>> _handleRequest<T>(Future<Response> request) async {

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
        sendTimeout: kIsWeb ? null : NetworkConfig.defaultSendTimeout,
        receiveTimeout: NetworkConfig.defaultReceiveTimeout,
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
