import 'dart:developer';

import 'package:dio/dio.dart';

import '../singletons/storage.dart';

class AuthenticationInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = StorageRepository.getString(StorageKeys.TOKEN);
    if (token.isEmpty) {
      handler.next(options);
      log("Authorization $token");
    } else {
      if (options.headers.containsKey('Authorization')) {
        options.headers['Authorization'] = token;
      } else {
        options.headers.putIfAbsent('Authorization', () => token);
      }
      handler.next(options);
      log("Authorization $token");
    }
  }

  static final AuthenticationInterceptor _singleton = AuthenticationInterceptor._internal();

  factory AuthenticationInterceptor() {
    return _singleton;
  }

  AuthenticationInterceptor._internal();
}
