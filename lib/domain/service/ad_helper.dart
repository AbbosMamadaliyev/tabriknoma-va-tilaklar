import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      // return 'ca-app-pub-8830329988183040/1875424491';

      /// test ads id
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      // return 'ca-app-pub-8830329988183040/9056668687';

      /// test ads id
      return 'ca-app-pub-3940256099942544/1033173712';
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/4411468910";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/5224354917";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/1712485313";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static BannerAdListener listener = BannerAdListener(
    onAdLoaded: (ad) {
      print('_bannerAd: $ad');
    },
    onAdFailedToLoad: (ad, err) {
      print('Failed to load a banner ad: ${err.message}');
      ad.dispose();
    },
  );
}
