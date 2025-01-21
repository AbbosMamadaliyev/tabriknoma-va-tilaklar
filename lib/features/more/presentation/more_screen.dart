import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabriklar/assets/colors/app_colors.dart';
import 'package:tabriklar/core/data/singletons/service_locator.dart';
import 'package:tabriklar/core/data/singletons/storage.dart';
import 'package:tabriklar/features/common/presentation/widgets/lang_bottomsheet.dart';
import 'package:tabriklar/features/components/custom_alert_dialog.dart';
import 'package:tabriklar/main_navigation.dart';
import 'package:tabriklar/utils/extensions.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MoreFunctionsScreen extends StatefulWidget {
  const MoreFunctionsScreen({super.key});

  @override
  State<MoreFunctionsScreen> createState() => _MoreFunctionsScreenState();
}

class _MoreFunctionsScreenState extends State<MoreFunctionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: 24),
        _buildListTile(
          'Saqlanganlar',
          Icons.favorite,
          Colors.redAccent,
          () {
            Navigator.of(context).pushNamed(MainNavigationNames.favourites);
          },
        ),
        _buildListTile(
          'O\'zim yozaman',
          Icons.edit,
          Colors.green,
          () => Navigator.of(context).pushNamed(MainNavigationNames.writing),
        ),
        _buildListTile(
          'Dastur tili',
          Icons.language,
          Colors.blue,
          () {
            showModalBottomSheet(
              context: context,
              builder: (context) => LanguageBottomSheet(
                locale: context.locale.languageCode,
                onTapX: () {},
              ),
            ).then((value) async {
              if (value is String) {
                await context.setLocale(Locale(value.toString()));
                await StorageRepository.putString(StorageKeys.language, value.toString());
                // serviceLocator<DioSettings>().setBaseOptions(lang: value);
                await resetLocator();

                setState(() {});
              }
            });
          },
        ),
        _buildListTile('Dastur haqida', Icons.info, Colors.grey, () {
          _showDialog();
        }),

        if (Platform.isAndroid)
          _buildListTile(
            'Dasturni baholash',
            Icons.star,
            Colors.yellowAccent,
            () {
              const url = 'https://play.google.com/store/apps/details?id=com.mamadaliyev.abbos.tabriklar';

              launchUrlString(url);
            },
          ),
        // _buildListTile(
        //   'Dasturdan chiqish',
        //   Icons.logout,
        //   Colors.white,
        //   () => SystemNavigator.pop(),
        // ),
      ],
    );
  }

  Container _buildListTile(String title, IconData icon, Color color, void Function() func) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.navBarColor,
      ),
      child: ListTile(
        onTap: func,
        leading: Icon(icon, color: color),
        title: Text(
          title,
          style: context.textTheme.displaySmall!.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return const CustomAlertDialog();
        });
  }
}
