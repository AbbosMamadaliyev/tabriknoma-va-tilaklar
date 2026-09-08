import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:tabriklar/domain/service/ad_helper.dart';
import 'package:tabriklar/features/components/background_congratulations_page.dart';
import 'package:tabriklar/features/components/custom_card_songratulations.dart';
import 'package:tabriklar/features/components/google_ads_widget.dart';
import 'package:tabriklar/main_navigation.dart';
import 'package:tabriklar/view_models/categor_model_provider/categor_model_provider.dart';
import 'package:tabriklar/view_models/database/db_service_provider.dart';

class CongratulationsWidget extends StatefulWidget {
  const CongratulationsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CongratulationsWidget> createState() => _CongratulationsWidgetState();
}

class _CongratulationsWidgetState extends State<CongratulationsWidget> {
  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    super.initState();
    _loadInterstitialAd();
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // bu appbar title' uchun
    final categories = context.watch<CategoryModelProvider>().categories(context.locale.languageCode);

    final congratulations = context.watch<DbServiceProver>().congratulations;

    var args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    var where = args['where'];
    var tableName = args['tableName'];
    var categoryIndex = args['categoryIndex'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(categories[categoryIndex].category),
      ),
      body: BackgroundCongratulationsPage(
        child: Stack(
          children: [
            ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: congratulations.length,
                padding: EdgeInsets.only(bottom: 56.h),
                itemBuilder: (context, index) {
                  var congratulation = congratulations[index];
                  return GestureDetector(
                    onTap: () {
                      // tabriklar bosilganda provider orqali borib read() qilib keladi
                      // keyingi oynaga otganda , bosilganini sezib chiqarib beradi contentni
                      context.read<DbServiceProver>().getData(where: where, tableName: tableName);

                      void openContent() {
                        if (!mounted) return;
                        Navigator.of(context).pushNamed(
                          MainNavigationNames.content,
                          arguments: {
                            'id': congratulation.id,
                            'tableName': tableName,
                          },
                        );
                      }

                      // Session: 1-chi kirishda reklama yo'q, keyingilarida bor.
                      if (!AdHelper.shouldShowInterstitialThisSession(AdHelper.placementContent)) {
                        openContent();
                        return;
                      }

                      final interstitialAd = _interstitialAd;
                      _interstitialAd = null;
                      AdHelper.showInterstitial(
                        ad: interstitialAd,
                        onComplete: () {
                          _loadInterstitialAd();
                          openContent();
                        },
                      );
                    },
                    child: CustomCardCongratulations(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: 8.w),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: Image.asset(
                              'assets/images/$categoryIndex.jpg',
                              height: 76.h,
                              fit: BoxFit.cover,
                              width: 64.w,
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                congratulation.content,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                top: false,
                child: Material(
                  color: Colors.transparent,
                  child: GoogleAdsWidget(adUnitId: AdHelper.bannerAdUnitId),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _loadInterstitialAd() {
    AdHelper.loadInterstitial(
      adUnitId: AdHelper.interstitialAdUnitId,
      onLoaded: (ad) {
        if (!mounted) {
          ad.dispose();
          return;
        }
        setState(() => _interstitialAd = ad);
      },
    );
  }
}
