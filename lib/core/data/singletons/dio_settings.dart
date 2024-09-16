import 'package:dio/dio.dart';
import 'package:tabriklar/core/data/interceptors/token_referesh_interceptor.dart';

import '../interceptors/authorization_interceptor.dart';
import '../interceptors/device_id_intercepter.dart';
import '../interceptors/language_interceptor.dart';

class DioSettings {
  final BaseOptions _dioBaseOptions = BaseOptions(
    connectTimeout: const Duration(milliseconds: 35000),
    receiveTimeout: const Duration(milliseconds: 35000),
    followRedirects: false,
    validateStatus: (status) => status != null && status <= 500,
  );

  BaseOptions get dioBaseOptions => _dioBaseOptions;

  LanguageInterceptor get _languageInterceptor => LanguageInterceptor();

  DeviceIdInterceptor get _deviceIdInterceptor => DeviceIdInterceptor();

  AuthenticationInterceptor get _authenticationInterceptor => AuthenticationInterceptor();

  Dio get dio {
    final dio = Dio(_dioBaseOptions);
    dio.interceptors
      ..add(CustomInterceptor(dio: dio))
      ..add(_languageInterceptor)
      ..add(_deviceIdInterceptor)
      ..add(_authenticationInterceptor);
    return dio;
  }
}
