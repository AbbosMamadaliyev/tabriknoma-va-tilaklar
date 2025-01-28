import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:tabriklar/features/components/background_congratulations_page.dart';
import 'package:tabriklar/features/components/custom_card_songratulations.dart';
import 'package:tabriklar/main_navigation.dart';
import 'package:tabriklar/view_models/categor_model_provider/categor_model_provider.dart';
import 'package:tabriklar/view_models/database/db_service_provider.dart';

import '../../domain/service/ad_helper.dart';

class CongratulationsWidget extends StatefulWidget {
  const CongratulationsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CongratulationsWidget> createState() => _CongratulationsWidgetState();
}

class _CongratulationsWidgetState extends State<CongratulationsWidget> {
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      loadInterstitialAd();

      BannerAd(
        adUnitId: AdHelper.bannerAdUnitId,
        request: const AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            _bannerAd = ad as BannerAd?;
            setState(() {});
            print('_bannerAd: $ad');
          },
          onAdFailedToLoad: (ad, err) {
            print('Failed to load a banner ad: ${err.message}');
            ad.dispose();
          },
        ),
      ).load();
    }
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
                padding: EdgeInsets.only(bottom: 64.h),
                itemBuilder: (context, index) {
                  var congratulation = congratulations[index];
                  return GestureDetector(
                    onTap: () {
                      // print('congratulation: ${congratulation.id}');
                      // return;
                      // tabriklar bosilganda provider orqali borib read() qilib keladi
                      // keyingi oynaga otganda , bosilganini sezib chiqarib beradi contentni
                      context.read<DbServiceProver>().getData(where: where, tableName: tableName);

                      if (_interstitialAd != null) {
                        _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
                          onAdDismissedFullScreenContent: (ad) {
                            Navigator.of(context).pushNamed(
                              MainNavigationNames.content,
                              arguments: {
                                'id': congratulation.id,
                                'tableName': tableName,
                              },
                            );
                          },
                        );
                        _interstitialAd?.show();
                        _interstitialAd = null;
                      } else {
                        Navigator.of(context).pushNamed(
                          MainNavigationNames.content,
                          arguments: {
                            'id': congratulation.id,
                            'tableName': tableName,
                          },
                        );
                      }
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
              child: _bannerAd == null
                  ? Container()
                  : SizedBox(
                      height: 52.h,
                      width: 1.sw,
                      child: AdWidget(ad: _bannerAd!),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            _interstitialAd = ad;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }
}
