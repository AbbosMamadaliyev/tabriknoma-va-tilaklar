import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tabriklar/assets/constants/app_constants.dart';
import 'package:tabriklar/core/data/singletons/storage.dart';

class CustomInterceptor implements Interceptor {
  final Dio dio;

  const CustomInterceptor({required this.dio});

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    try {
      if (err.type == DioExceptionType.badResponse &&
          (err.response?.statusCode == 403 || err.response?.statusCode == 401)) {
        StorageRepository.deleteString(StorageKeys.TOKEN);
        await _refreshToken(err.requestOptions.baseUrl);
        if (StorageRepository.getString(StorageKeys.TOKEN).replaceAll('Bearer', '').trim().isNotEmpty) {
          err.requestOptions.headers['Authorization'] = StorageRepository.getString(StorageKeys.TOKEN);
        }

        final response = await _resolveResponse(err.requestOptions);
        handler.resolve(response);
        return;
      }
    } catch (e) {}

    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options.copyWith(headers: {
      ...options.headers,
      'Device-ID': StorageRepository.getString(StorageKeys.DeviceId),
    }));
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    try {
      if (response.statusCode == 403 || response.statusCode == 401) {
        if (StorageRepository.getString(StorageKeys.REFRESH).isEmpty) {
          handler.next(response);
          return;
        }
        await _refreshToken(response.requestOptions.baseUrl);
        if (StorageRepository.getString(StorageKeys.TOKEN).replaceAll('Bearer', '').trim().isNotEmpty) {
          response.requestOptions.headers['Authorization'] = StorageRepository.getString(StorageKeys.TOKEN);
        }
        final resolved = await _resolveResponse(response.requestOptions);
        handler.resolve(resolved);
        return;
      }
    } on Exception {
      await StorageRepository.deleteString(StorageKeys.TOKEN);
      await StorageRepository.deleteString(StorageKeys.REFRESH);
      handler.next(response);
    }
    handler.next(response);
  }

  Future<void> _refreshToken(String baseUrl) async {
    if (StorageRepository.getString(StorageKeys.REFRESH).isNotEmpty) {
      try {
        final response = await Dio()
            .post('${baseUrl}refresh/token', data: {"refresh_token": StorageRepository.getString(StorageKeys.REFRESH)});
        if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
          log("refresh token function  called ${response.toString()}");
          await StorageRepository.putString(StorageKeys.TOKEN, 'Bearer ${response.data['access_token']}');
          await StorageRepository.putString(StorageKeys.REFRESH, response.data['refresh_token']);
        } else {
          StorageRepository.deleteString(StorageKeys.REFRESH);
          // statusController.add(AuthenticationStatus.unauthenticated);
        }
      } on DioException catch (e) {
        // statusController.add(AuthenticationStatus.unauthenticated);
      }
    } else {
      // statusController.add(AuthenticationStatus.unauthenticated);
    }
  }

  Future<Response<dynamic>> _resolveResponse(RequestOptions options) async {
    try {
      final path = options.path.replaceAll(AppConstants.baseUrl, '');
      if (options.data is FormData) {
        FormData formData = FormData();
        final fields = options.data.fields as List<MapEntry<String, String>>;
        formData.fields.addAll(fields);

        for (MapEntry mapFile in options.data.files) {
          formData.files.add(MapEntry(
              mapFile.key,
              MultipartFile.fromFileSync(
                  fields.firstWhere((element) => element.key == 'image', orElse: () => const MapEntry('', '')).value,
                  filename: mapFile.value.filename)));
        }
        options.data = formData;
      }
      return await Dio().request(AppConstants.baseUrl + path,
          data: options.data,
          queryParameters: options.queryParameters,
          options: Options(
            headers: options.headers,
            method: options.method,
          ));
    } catch (e) {
      // statusController.add(AuthenticationStatus.unauthenticated);
      return Response<dynamic>(data: null, statusCode: 500, requestOptions: options);
    }
  }
}
