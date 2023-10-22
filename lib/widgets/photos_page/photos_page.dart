import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/src/provider.dart';
import 'package:shimmer/shimmer.dart';
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

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ImageListProvider>();
    var imageLinkList = model.imageLinkList;
    var defaultLink = model.defaultLink;
    var isActiveBtn = model.isActiveBtn;
    var isLoading = model.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabriklar rasmda'),
      ),
      body: Stack(
        children: [
          ListView.builder(
              itemCount: imageLinkList.length,
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
                            : CachedNetworkImage(imageUrl: image),
                        InkWell(
                          child: SizedBox(
                            height: 64.h,
                            width: double.infinity,
                            child: IconButton(
                              icon: isActiveBtn[index]
                                  ? const CircularProgressIndicator(
                                      color: Color(0xff1c901e),
                                    )
                                  : const Icon(
                                      Icons.send,
                                      color: Color(0xff1c901e),
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
