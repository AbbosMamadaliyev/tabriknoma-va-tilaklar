import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logging/logging.dart';
import 'package:tabriklar/core/data/singletons/service_locator.dart';
import 'package:tabriklar/firebase_options.dart';

class AppInit {
  AppInit._();

  static Future<AppInit> get create async {
    await appInitialized();
    return AppInit._();
  }

  static Future<void> appInitialized() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // Not awaited on purpose. Nothing is drawn until runApp() (Flutter holds
    // back the first Android frame until its own first frame), and this Future
    // can take up to 30 s on a slow network. Waiting here caused
    // "Input dispatching timed out (No focused window)" ANRs. Ad requests made
    // before it completes are queued by the SDK (no mediation adapters here).
    unawaited(MobileAds.instance.initialize());

    /// Device Orientation
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    await setupLocator();
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
