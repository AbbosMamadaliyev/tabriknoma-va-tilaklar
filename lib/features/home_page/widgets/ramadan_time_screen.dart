import 'package:flutter/material.dart';
import 'package:tabriklar/assets/constants/app_images.dart';
import 'package:tabriklar/domain/service/ad_helper.dart';
import 'package:tabriklar/features/components/google_ads_widget.dart';
import 'package:tabriklar/utils/analytics_service.dart';
import 'package:tabriklar/utils/extensions.dart';

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
        title: const Text("Ramazon vaqtlari 2025"),
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AppImages.ramadanTimes),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Manba: t.me/muslimuzportal',
              style: context.textTheme.displaySmall!.copyWith(fontSize: 12),
            ),
          ),
          const Spacer(),
          SafeArea(
            top: false,
            child: Center(
              child: GoogleAdsWidget(adUnitId: AdHelper.ramadanTimesBannerId),
            ),
          ),
        ],
      ),
    );
  }
}
