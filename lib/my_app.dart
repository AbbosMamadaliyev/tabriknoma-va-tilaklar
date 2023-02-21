import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'main_navigation.dart';

class MyApp extends StatelessWidget {
  final bool connectivityX;
  MyApp({Key? key, required this.connectivityX}) : super(key: key);

  final mainNavigation = MainNavigation();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tabriklar',
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Color(0xff1c901e),
        ),
      ),
      initialRoute: mainNavigation.initialRoute(connectivityX),
      routes: mainNavigation.routes,
    );
  }
}
