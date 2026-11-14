import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabriklar/assets/colors/app_colors.dart';
import 'package:tabriklar/assets/themes/theme.dart';
import 'package:tabriklar/core/ui/app_ui.dart';
import 'package:tabriklar/core/utils/notification_service.dart';
import 'package:tabriklar/features/common/presentation/bloc/internet_bloc/internet_bloc.dart';
import 'package:tabriklar/features/common/presentation/bloc/version/version_bloc.dart';
import 'package:tabriklar/features/home_page/home_page.dart';
import 'package:tabriklar/features/main_screen/widgets/nav_bar.dart';
import 'package:tabriklar/features/more/presentation/more_screen.dart';
import 'package:tabriklar/features/photos_page/category_photos.dart';
import 'package:tabriklar/generated/locale_keys.g.dart';
import 'package:tabriklar/utils/analytics_service.dart';
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

    context.read<InternetBloc>().add(CheckEvent());

    AnalyticsService.logEvent(name: AnalyticsKeys.appLaunch);

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
    return BlocListener<InternetBloc, InternetState>(
      listenWhen: (oldState, newState) =>
          oldState.isConnected != newState.isConnected || oldState.isCheck != newState.isCheck,
      listener: (context, state) {
        if (!state.isConnected) {
          showAppSnack(
            context,
            LocaleKeys.no_internet.tr(),
            error: true,
            icon: Icons.wifi_off_rounded,
          );
        }
      },
      child: BlocListener<VersionBloc, VersionState>(
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
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: AppTheme.systemOverlay,
          child: Scaffold(
            backgroundColor: AppColors.surface,
            body: SafeArea(
              bottom: false,
              child: sectionIndex == 0
                  ? const HomePageBody()
                  : sectionIndex == 1
                      ? const CategorPhotosWidget()
                      : const MoreFunctionsScreen(),
            ),
            bottomNavigationBar: NavigationBarWidget(
              onTabChanged: (int index) {
                if (index == sectionIndex) return;
                HapticFeedback.selectionClick();
                setState(() {
                  sectionIndex = index;
                });
              },
              sectionIndex: sectionIndex,
            ),
          ),
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
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 28),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const IconTile(icon: Icons.system_update_rounded, size: 56, iconSize: 28),
                const SizedBox(height: AppSpace.l),
                Text(LocaleKeys.app_name.tr(), style: AppText.title, textAlign: TextAlign.center),
                const SizedBox(height: AppSpace.s),
                Text(
                  LocaleKeys.update_app_info.tr(),
                  textAlign: TextAlign.center,
                  style: AppText.body.copyWith(color: AppColors.inkSecondary, fontSize: 15),
                ),
                const SizedBox(height: AppSpace.xxl),
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    label: LocaleKeys.update.tr(),
                    onPressed: () async {
                      await launchUrlString(playStoreLink, mode: LaunchMode.externalApplication);
                    },
                  ),
                ),
                if (!isRequired) ...[
                  const SizedBox(height: AppSpace.s),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(foregroundColor: AppColors.inkSecondary),
                      child: Text(LocaleKeys.cancel.tr()),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
