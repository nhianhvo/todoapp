import 'dart:io';

import 'package:dio/dio.dart';
import 'package:todoapp/data_source/local/share_refer.dart';
import 'package:injectable/injectable.dart';

@singleton
class ApiClient {
  final Dio dio;
  final SharedPreferencesRepo _sharedPreferencesRepo;

  ApiClient(this._sharedPreferencesRepo, this.dio) {
    dio.options.baseUrl = ApiEndpoint.END_POINT + ApiEndpoint.API_PREFIX;
    dio.interceptors.addAll([
      // Log
      LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
      ),

      InterceptorsWrapper(onRequest: (
        RequestOptions options,
        RequestInterceptorHandler handler,
      ) {
        Map<String, dynamic> header = {};

        if (header != null && header['Authorization'] != null) {
          options.headers.addAll(header);
        }
        return handler.next(options);
      }, onError: (DioError e, ErrorInterceptorHandler handler) {
        if (e.response?.statusCode == 401) {
          // onTokenExpired();
          return;
        }
        return handler.next(e);
      }),
    ]);
  }

  Future<Response> get({
    required String path,
    bool isAuthorizedNeeded = true,
    String? accessToken,
    Map<String, String> headers = const {},
    Map<String, dynamic>? queryParam,
    Options? options,
    CancelToken? cancelToken,
    Function(int, int)? onReceiveProgress,
  }) async {
    // Track performance
    Map<String, dynamic> _headers = {};
    if (isAuthorizedNeeded) {
      _headers = {
        HttpHeaders.authorizationHeader: accessToken ??= await getAccessToken(),
      };
    }

    if (headers.isNotEmpty) {
      _headers.addAll(headers);
    }

    dio.options.headers.addAll(_headers);

    final response = await dio.get(
      path,
      queryParameters: queryParam,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
    return response;
  }

  Future<String> getAccessToken() async {
    var accessToken = _sharedPreferencesRepo.getToken();

    return accessToken ?? '';
  }
}

class ApiEndpoint {
  static const String END_POINT = 'https://todoapp.com';
  static const String API_PREFIX = '/v1';
}
