import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tabriklar/features/common/presentation/bloc/version/version_bloc.dart';
import 'package:tabriklar/features/common/splash_page.dart';
import 'package:tabriklar/generated/codegen_loader.g.dart';
import 'package:tabriklar/main_navigation.dart';
import 'package:tabriklar/utils/app_init.dart';
import 'package:tabriklar/view_models/categor_model_provider/categor_model_provider.dart';
import 'package:tabriklar/view_models/database/db_service_provider.dart';
import 'package:tabriklar/view_models/db_table_model_provider/db_table_model_provider.dart';
import 'package:tabriklar/view_models/get_data_from_firebase/get_images_provider.dart';

void main() {
  runZonedGuarded(
    () async {
      await AppInit.create;

      runApp(
        EasyLocalization(
          supportedLocales: const [
            Locale('uz'),
            Locale('ru'),
            Locale('en'),
          ],
          path: 'assets/translations',
          fallbackLocale: const Locale('ru'),
          startLocale: const Locale('ru'),
          assetLoader: const CodegenLoader(),
          child: MyApp(),
        ),
      );
    },
    (error, stackTrace) {
      print('=======main error, error: ${error}');
      print('=======main error, stackTrace: ${stackTrace}');
    },
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final mainNavigation = MainNavigation();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => DbServiceProver(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => CategoryModelProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => DbTableModelProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => ImageListProvider(),
        ),
      ],
      child: BlocProvider(
        create: (context) => VersionBloc()..add(const RemoteConfigUpdateEvent()),
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          child: MaterialApp(
            title: 'Tabriklar',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                elevation: 0,
                color: Color(0xff1c901e),
              ),
            ),
            initialRoute: mainNavigation.initialRoute(),
            routes: mainNavigation.routes,
            onGenerateRoute: (_) => MaterialPageRoute(builder: (_) => const SplashPage()),
          ),
        ),
      ),
    );
  }
}
