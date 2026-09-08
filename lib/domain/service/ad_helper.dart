import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {
  static bool get _useTestAds => kDebugMode;

  /// In-memory only — resets when the app process is killed.
  static final Map<String, int> _sessionEntryCounts = {};

  static const String placementContent = 'content';
  static const String placementUseful = 'useful';

  /// First entry in this session → skip ad. Later entries → show.
  static bool shouldShowInterstitialThisSession(String placement) {
    final count = _sessionEntryCounts[placement] ?? 0;
    _sessionEntryCounts[placement] = count + 1;
    return count > 0;
  }

  static String get bannerAdUnitId {
    if (_useTestAds) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    if (Platform.isAndroid) {
      return 'ca-app-pub-8830329988183040/1875424491';
    }
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    }
    throw UnsupportedError('Unsupported platform');
  }

  static String get moreScreenBannerId {
    if (_useTestAds) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    if (Platform.isAndroid) {
      return 'ca-app-pub-8830329988183040/6662771417';
    }
    if (Platform.isIOS) {
      return 'ca-app-pub-8830329988183040/1875424491';
    }
    throw UnsupportedError('Unsupported platform');
  }

  static String get ramadanTimesBannerId {
    if (_useTestAds) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    if (Platform.isAndroid) {
      return 'ca-app-pub-8830329988183040/6171341466';
    }
    if (Platform.isIOS) {
      return 'ca-app-pub-8830329988183040/1875424491';
    }
    throw UnsupportedError('Unsupported platform');
  }

  static String get contentScreenBannerId {
    if (_useTestAds) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    if (Platform.isAndroid) {
      return 'ca-app-pub-8830329988183040/2347351295';
    }
    throw UnsupportedError('Unsupported platform');
  }

  static String get interstitialAdUnitId {
    if (_useTestAds) {
      return 'ca-app-pub-3940256099942544/1033173712';
    }
    if (Platform.isAndroid) {
      return 'ca-app-pub-8830329988183040/9056668687';
    }
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910';
    }
    throw UnsupportedError('Unsupported platform');
  }

  static String get usefulInterstitialAdUnitId {
    if (_useTestAds) {
      return 'ca-app-pub-3940256099942544/1033173712';
    }
    if (Platform.isAndroid) {
      return 'ca-app-pub-8830329988183040/3890737029';
    }
    throw UnsupportedError('Unsupported platform');
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917';
    }
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1712485313';
    }
    throw UnsupportedError('Unsupported platform');
  }

  static void loadBanner({
    required String adUnitId,
    AdSize size = AdSize.banner,
    required void Function(BannerAd ad) onLoaded,
  }) {
    if (!Platform.isAndroid) return;

    developer.log(
      'Loading banner unit=$adUnitId size=${size.width}x${size.height} test=$_useTestAds',
      name: 'AdMob',
    );

    BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: size,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          developer.log('Banner loaded unit=$adUnitId', name: 'AdMob');
          onLoaded(ad as BannerAd);
        },
        onAdFailedToLoad: (ad, err) {
          developer.log(
            'Banner failed unit=$adUnitId code=${err.code} '
            'domain=${err.domain} message=${err.message}',
            name: 'AdMob',
          );
          ad.dispose();
        },
      ),
    ).load();
  }

  static void loadInterstitial({
    required String adUnitId,
    required void Function(InterstitialAd ad) onLoaded,
    int attempt = 0,
    int maxAttempts = 3,
  }) {
    if (!Platform.isAndroid) return;

    developer.log(
      'Loading interstitial unit=$adUnitId attempt=${attempt + 1} test=$_useTestAds',
      name: 'AdMob',
    );

    InterstitialAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          developer.log('Interstitial loaded unit=$adUnitId', name: 'AdMob');
          onLoaded(ad);
        },
        onAdFailedToLoad: (err) {
          developer.log(
            'Interstitial failed unit=$adUnitId code=${err.code} '
            'domain=${err.domain} message=${err.message}',
            name: 'AdMob',
          );
          if (attempt + 1 < maxAttempts) {
            loadInterstitial(
              adUnitId: adUnitId,
              onLoaded: onLoaded,
              attempt: attempt + 1,
              maxAttempts: maxAttempts,
            );
          }
        },
      ),
    );
  }

  static void showInterstitial({
    required InterstitialAd? ad,
    required VoidCallback onComplete,
  }) {
    if (ad == null) {
      onComplete();
      return;
    }

    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (shown) {
        shown.dispose();
        onComplete();
      },
      onAdFailedToShowFullScreenContent: (shown, error) {
        developer.log(
          'Interstitial show failed code=${error.code} message=${error.message}',
          name: 'AdMob',
        );
        shown.dispose();
        onComplete();
      },
    );
    ad.show();
  }
}
