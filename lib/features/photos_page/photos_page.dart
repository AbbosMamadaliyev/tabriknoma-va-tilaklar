import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/src/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tabriklar/generated/locale_keys.g.dart';
import 'package:tabriklar/view_models/get_data_from_firebase/get_images_provider.dart';

import '../../domain/service/ad_helper.dart';

class PhotosPage extends StatefulWidget {
  const PhotosPage({Key? key}) : super(key: key);

  @override
  _PhotosPageState createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
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
    final model = context.watch<ImageListProvider>();
    var imageLinkList = model.imageLinkList;
    var defaultLink = model.defaultLink;
    var isActiveBtn = model.isActiveBtn;
    var isLoading = model.isLoading;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(LocaleKeys.congratulations_via_pic.tr()),
      ),
      body: Stack(
        children: [
          ListView.builder(
              itemCount: imageLinkList.length,
              padding: const EdgeInsets.only(top: 16, bottom: 56),
              itemBuilder: (context, index) {
                var image = imageLinkList[index] ?? defaultLink;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0, right: 4, left: 4, top: 4),
                  child: Card(
                    elevation: 8,
                    child: Column(
                      children: [
                        isLoading
                            ? Shimmer(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black.withOpacity(.1),
                                    Colors.black.withOpacity(.4),
                                  ],
                                ),
                                child: Container(
                                  height: 264,
                                  width: double.maxFinite,
                                  color: Colors.white,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: image,
                                  fadeInDuration: const Duration(milliseconds: 150),
                                  fadeOutDuration: const Duration(milliseconds: 150),
                                  placeholder: (context, url) => const SizedBox(
                                    height: 264,
                                    width: double.maxFinite,
                                    child: Center(child: CupertinoActivityIndicator()),
                                  ),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                              ),
                        InkWell(
                          child: SizedBox(
                            height: 64.h,
                            width: double.infinity,
                            child: IconButton(
                              icon: isActiveBtn[index]
                                  ? const CupertinoActivityIndicator()
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          LocaleKeys.share.tr(),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(
                                          Icons.send,
                                          color: Color(0xff1c901e),
                                        ),
                                      ],
                                    ),
                              onPressed: () {
                                model.shareImage(image ?? defaultLink, index);
                              },
                            ),
                          ),
                        )
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
    );
  }
}
