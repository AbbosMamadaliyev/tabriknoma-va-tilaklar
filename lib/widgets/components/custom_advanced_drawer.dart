import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:tabriklar/main_navigation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'custom_alert_dialog.dart';

class CustomAdvancedDrawer extends StatefulWidget {
  final Widget child;
  final AdvancedDrawerController advancedDrawerController;

  const CustomAdvancedDrawer({Key? key, required this.child, required this.advancedDrawerController}) : super(key: key);

  @override
  _CustomAdvancedDrawerState createState() => _CustomAdvancedDrawerState();
}

class _CustomAdvancedDrawerState extends State<CustomAdvancedDrawer> {
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      animationCurve: Curves.easeInOut,
      backdropColor: const Color(0xff1e027a),
      animateChildDecoration: false,
      animationDuration: const Duration(milliseconds: 500),
      controller: widget.advancedDrawerController,
      child: widget.child,
      drawer: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 12),
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
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
            ),
          ),
        ),
      ),
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
