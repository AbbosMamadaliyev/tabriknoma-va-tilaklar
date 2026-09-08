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
    return GestureDetector(
      onTap: () {
        void openUseful() {
          if (!mounted) return;
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const UsefulProjectsScreen()),
          );
        }

        // Session: 1-chi kirishda reklama yo'q, keyingilarida bor.
        if (!AdHelper.shouldShowInterstitialThisSession(AdHelper.placementUseful)) {
          openUseful();
          return;
        }

        final interstitialAd = _interstitialAd;
        _interstitialAd = null;
        AdHelper.showInterstitial(
          ad: interstitialAd,
          onComplete: () {
            _loadInterstitialAd();
            openUseful();
          },
        );
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

  void _loadInterstitialAd() {
    AdHelper.loadInterstitial(
      adUnitId: AdHelper.usefulInterstitialAdUnitId,
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
