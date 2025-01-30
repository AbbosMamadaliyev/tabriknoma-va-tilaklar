import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tabriklar/assets/colors/app_colors.dart';

class PushNotificationService {
  static ValueNotifier<int> unReadNotifyCountNotifier = ValueNotifier<int>(0);
  static final StreamController<int> _notificationStreamController = StreamController.broadcast(sync: true);

  static Stream<int> notificationStream() async* {
    yield* _notificationStreamController.stream;
  }

  static late FirebaseMessaging messaging;

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
      "high importance channel", "High importance Notifications",
      description: "This channel is used for important notifications", importance: Importance.max);

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print('==== messagemessage data: ${message.data}');
    print('==== messagemessage title: ${message.notification?.title}');
    print('==== messagemessage body: ${message.notification?.body}');
    _notificationStreamController.add(1);
  }

  static Future<void> resolvePlatformSpecificImplementationAndroid() async {
    if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }
  }

  static Future<void> resolvePlatformSpecificImplementationIos() async {
    if (Platform.isIOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    }
  }

  static Future<void> setForegroundNotificationPresentationOptions() async => await FirebaseMessaging.instance
      .setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);

  static Future<void> messagingRequestPermission() async => await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true);

  static Future<void> configurationFirebaseNotification() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    resolvePlatformSpecificImplementationAndroid();
    resolvePlatformSpecificImplementationIos();

    messaging = FirebaseMessaging.instance;
    final token = await messaging.getToken();
    print('==== fcm token: $token');

    await setForegroundNotificationPresentationOptions();
    // await FirebaseMessaging.instance.subscribeToTopic("all")
    await messagingRequestPermission();
  }

  static void initializeFlutterLocalNotificationsPlugin(BuildContext context) {
    const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = const DarwinInitializationSettings();
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static void listenFireBaseOnMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      _notificationStreamController.add(1);

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            1,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: 'ic_stat_name',
              importance: Importance.max,
              priority: Priority.max,
              color: AppColors.green,
            )));
      }
    }, onError: (error) {
      print("Error in receiving message: $error");
    });
  }

  static void initializeAndListenFirebaseMessaging() async {
    listenFireBaseOnMessage();
    FirebaseMessaging.instance.getInitialMessage();
  }

  static void initializeLocalNotificationPlugin(BuildContext context) async {
    initializeFlutterLocalNotificationsPlugin(context);
  }

// static void initializeFirebaseApp() async {
//   await Firebase.initializeApp();
// }
}
