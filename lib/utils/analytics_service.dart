import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  static Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    await _analytics
        .logEvent(
          name: name,
          parameters: parameters,
        )
        .then((value) => log('Event $name logged'));
  }
}

class AnalyticsKeys {
  static const String appLaunch = 'app_launch';
  static const String readContent = 'read_content';
  static const String rateApp = 'rate_app';
  static const String sendContent = 'send_content';
  static const String sendPhoto = 'send_photo';
  static const String moreScreen = 'more_screen';
  static const String projectsScreen = 'projects_screen';
  static const String installApp = 'install_app';
  static const String launchChannel = 'launch_channel';
  static const String ramadanTimes = 'ramadan_times';
}
