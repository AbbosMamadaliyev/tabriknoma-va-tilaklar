import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tabriklar/domain/service/ad_helper.dart';

class GoogleAdsWidget extends StatefulWidget {
  const GoogleAdsWidget({
    super.key,
    required this.adUnitId,
  });

  final String adUnitId;

  @override
  State<GoogleAdsWidget> createState() => _GoogleAdsWidgetState();
}

class _GoogleAdsWidgetState extends State<GoogleAdsWidget> {
  BannerAd? _bannerAd;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAdIfNeeded();
  }

  void _loadAdIfNeeded() {
    if (_bannerAd != null || _isLoading) return;
    _isLoading = true;

    // Standard banner (320x50) — large adaptive can take half the screen.
    AdHelper.loadBanner(
      adUnitId: widget.adUnitId,
      size: AdSize.banner,
      onLoaded: _onBannerLoaded,
    );
  }

  void _onBannerLoaded(BannerAd ad) {
    if (!mounted) {
      ad.dispose();
      return;
    }
    setState(() => _bannerAd = ad);
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bannerAd = _bannerAd;
    if (bannerAd == null) {
      return const SizedBox(height: 50);
    }

    // Fixed height only — do NOT wrap in Align/Expanded (expands in Stack → centers on screen).
    return SizedBox(
      width: bannerAd.size.width.toDouble(),
      height: bannerAd.size.height.toDouble(),
      child: AdWidget(ad: bannerAd),
    );
  }
}
