import 'package:dio/dio.dart';

import '../singletons/storage.dart';

class DeviceIdInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String deviceId = StorageRepository.getString(StorageKeys.DeviceId);
    if (deviceId != "") {
      options.headers['Device-ID'] = deviceId;
      handler.next(options);
    } else {
      handler.next(options);
    }
  }

  static final DeviceIdInterceptor _singleton = DeviceIdInterceptor._internal();

  factory DeviceIdInterceptor() {
    return _singleton;
  }

  DeviceIdInterceptor._internal();
}
