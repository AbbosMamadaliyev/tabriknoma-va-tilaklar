import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabriklar/core/ui/app_ui.dart';
import 'package:tabriklar/generated/locale_keys.g.dart';

class NoConnection extends StatefulWidget {
  const NoConnection({Key? key}) : super(key: key);

  @override
  State<NoConnection> createState() => _NoConnectionState();
}

class _NoConnectionState extends State<NoConnection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppEmptyState(
          icon: Icons.wifi_off_rounded,
          title: LocaleKeys.no_internet.tr(),
          message: 'Internet bilan aloqa borligini tekshiring',
        ),
      ),
    );
  }
}
