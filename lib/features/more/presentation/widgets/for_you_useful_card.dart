import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tabriklar/assets/colors/app_colors.dart';
import 'package:tabriklar/domain/service/ad_helper.dart';
import 'package:tabriklar/features/more/presentation/pages/useful_projects_screen.dart';
import 'package:tabriklar/generated/locale_keys.g.dart';
import 'package:tabriklar/utils/extensions.dart';

class UsefulForYouCard extends StatefulWidget {
  const UsefulForYouCard({super.key});

  @override
  State<UsefulForYouCard> createState() => _UsefulForYouCardState();
}

class _UsefulForYouCardState extends State<UsefulForYouCard> {
  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  int maxFailedLoadAttempts = 3;

  @override
  void initState() {
    if (Platform.isAndroid) {
      loadInterstitialAd();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('_interstitialAd: $_interstitialAd');
        if (_interstitialAd != null) {
          _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UsefulProjectsScreen()));
            },
          );
          _interstitialAd?.show();
          _interstitialAd = null;
        } else {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UsefulProjectsScreen()));
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
        ),
        child: Row(
          children: [
            const Icon(Icons.phonelink_rounded, color: Colors.pink),
            const SizedBox(width: 12),
            Text(
              LocaleKeys.useful_for_you.tr(),
              style: context.textTheme.displaySmall!.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  void loadInterstitialAd() async {
    await InterstitialAd.load(
      adUnitId: AdHelper.usefulInterstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            _numInterstitialLoadAttempts = 0;
            _interstitialAd = ad;
            print('_interstitialAd: $ad');
          });
        },
        onAdFailedToLoad: (err) {
          _numInterstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
            loadInterstitialAd();
          }
          print('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }
}
