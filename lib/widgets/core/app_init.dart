import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logging/logging.dart';

import '../../domain/service/connectivity.dart';

class AppInit {
  static bool? connectivityX;

  AppInit._();

  static Future<AppInit> get create async {
    await appInitialized();
    connectivityX ??= await ConnectivityX().create();
    return AppInit._();
  }

  static Future<void> appInitialized() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    /// Device Orientation
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    _setupLogging();
    configLoading();
  }

  static void _setupLogging() => Logger.root
    ..level = kDebugMode ? Level.ALL : Level.WARNING
    ..onRecord.listen((record) => debugPrint(
          '${record.level.name}: '
          '${record.time} '
          '${record.loggerName}: '
          '${record.message}',
        ));

  static void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(seconds: 1)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.white
      ..backgroundColor = const Color(0xff09B0E7).withOpacity(0.4)
      ..errorWidget
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..maskColor = const Color(0xff09B0E7).withOpacity(0.2)
      ..userInteractions = true
      ..dismissOnTap = false;
  }
}
