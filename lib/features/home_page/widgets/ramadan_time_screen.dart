import 'package:flutter/material.dart';
import 'package:tabriklar/assets/themes/theme.dart';
import 'package:tabriklar/assets/constants/app_images.dart';
import 'package:tabriklar/core/ui/app_ui.dart';
import 'package:tabriklar/domain/service/ad_helper.dart';
import 'package:tabriklar/utils/analytics_service.dart';

class RamadanTimeScreen extends StatefulWidget {
  const RamadanTimeScreen({super.key});

  @override
  State<RamadanTimeScreen> createState() => _RamadanTimeScreenState();
}

class _RamadanTimeScreenState extends State<RamadanTimeScreen> {
  @override
  void initState() {
    super.initState();
    AnalyticsService.logEvent(name: AnalyticsKeys.ramadanTimes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ramazon vaqtlari 2025'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(AppSpace.l, AppSpace.s, AppSpace.l, AppSpace.xxl),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.card),
            child: InteractiveViewer(
              maxScale: 4,
              child: Image.asset(AppImages.ramadanTimes),
            ),
          ),
          const SizedBox(height: AppSpace.m),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpace.xs),
            child: Text('Manba: t.me/muslimuzportal', style: AppText.caption),
          ),
        ],
      ),
      bottomNavigationBar: BottomBannerBar(adUnitId: AdHelper.ramadanTimesBannerId),
    );
  }
}
