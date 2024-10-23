import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tabriklar/features/components/custom_alert_dialog.dart';
import 'package:tabriklar/main_navigation.dart';
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
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
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
        _buildListTile('Dastur haqida', Icons.info, Colors.greenAccent, () {
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

  ListTile _buildListTile(String title, IconData icon, Color color, void Function() func) {
    return ListTile(
      onTap: func,
      leading: Icon(icon, color: color),
      title: Text(title),
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
