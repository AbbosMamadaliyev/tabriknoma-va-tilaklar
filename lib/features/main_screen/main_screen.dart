// import 'package:app_version_update/app_version_update.dart';
import 'dart:developer';
import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabriklar/assets/colors/app_colors.dart';
import 'package:tabriklar/core/utils/notification_service.dart';
import 'package:tabriklar/features/common/presentation/bloc/version/version_bloc.dart';
import 'package:tabriklar/features/components/background_home_page.dart';
import 'package:tabriklar/features/home_page/home_page.dart';
import 'package:tabriklar/features/main_screen/widgets/nav_bar.dart';
import 'package:tabriklar/features/more/presentation/more_screen.dart';
import 'package:tabriklar/features/photos_page/category_photos.dart';
import 'package:tabriklar/generated/locale_keys.g.dart';
import 'package:tabriklar/utils/my_functions.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int sectionIndex = 0;

  @override
  void initState() {
    super.initState();
    _notificationConfig();
  }

  Future<void> _notificationConfig() async {
    await PushNotificationService.configurationFirebaseNotification();

    PushNotificationService.initializeAndListenFirebaseMessaging();

    try {
      if (Platform.isAndroid) {
        PushNotificationService.initializeLocalNotificationPlugin(context);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VersionBloc, VersionState>(
      listenWhen: (previous, current) {
        return current.appVersion != previous.appVersion;
      },
      listener: (context, state) async {
        final needToUpdate = await MyFunctions.needToUpdate(state.appVersion.version);
        log('needToUpdate: $needToUpdate');
        if (needToUpdate) {
          checkerUpdate(state.appVersion.required);
        }
      },
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.white,
          title: Text(
            'Tabrik va tilaklar',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: BackgroundHomePage(
          child: sectionIndex == 0
              ? const HomePageBody()
              : sectionIndex == 1
                  ? const CategorPhotosWidget()
                  : const MoreFunctionsScreen(),
        ),
        bottomNavigationBar: NavigationBarWidget(
          onTabChanged: (int index) {
            setState(() {
              sectionIndex = index;
            });
          },
          sectionIndex: sectionIndex,
        ),
      ),
    );
  }

  Future<void> checkerUpdate(bool isRequired) async {
    const playStoreLink = 'https://play.google.com/store/apps/details?id=com.mamadaliyev.abbos.tabriklar';

    showDialog(
      barrierDismissible: !isRequired,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tabrik va tilaklar'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Text(
                LocaleKeys.update_app_info.tr(),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  await launchUrlString(playStoreLink, mode: LaunchMode.externalApplication);
                },
                child: Text(LocaleKeys.update.tr()),
              ),
              if (!isRequired) ...{
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(LocaleKeys.cancel.tr()),
                ),
              },
            ],
          ),
        );
      },
    );
  }

  CurvedNavigationBar customNavigationBar() {
    return CurvedNavigationBar(
      items: const [
        Icon(Icons.home, color: Colors.white),
        Icon(Icons.photo_library_outlined, color: Colors.white),
      ],
      index: 0,
      height: 56.h,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 600),
      color: const Color(0xff1c901e),
      backgroundColor: const Color(0xff1e027a),
      buttonBackgroundColor: Colors.transparent,
      onTap: (index) {
        setState(() {
          sectionIndex = index;
        });
        print('ss: $sectionIndex');
      },
    );
  }
}
