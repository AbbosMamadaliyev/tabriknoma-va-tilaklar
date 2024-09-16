import 'package:dio/dio.dart';

import '../singletons/storage.dart';

class LanguageInterceptor extends Interceptor {
  final String defaultLanguage = "ru";

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String language = StorageRepository.getString(StorageKeys.LANGUAGE, defValue: defaultLanguage);
    options.headers['Accept-Language'] = language;
    handler.next(options);
  }

  static final LanguageInterceptor _singleton = LanguageInterceptor._internal();

  factory LanguageInterceptor() {
    return _singleton;
  }

  LanguageInterceptor._internal();
}
