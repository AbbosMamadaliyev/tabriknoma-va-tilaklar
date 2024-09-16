import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:tabriklar/core/data/singletons/dio_settings.dart';
import 'package:tabriklar/core/data/singletons/storage.dart';

final serviceLocator = GetIt.I;

Future<void> setupLocator({String? lang}) async {
  await StorageRepository.getInstance();

  final dioSettings = DioSettings();

  serviceLocator.registerLazySingleton(() => dioSettings);
}

Future resetLocator({String? lang}) async {
  await serviceLocator.reset();
  await setupLocator(lang: lang);
}
