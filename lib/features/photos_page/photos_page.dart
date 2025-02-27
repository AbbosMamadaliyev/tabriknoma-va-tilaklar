import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/src/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_share/social_share.dart';
import 'package:tabriklar/assets/colors/app_colors.dart';
import 'package:tabriklar/assets/constants/app_icons.dart';
import 'package:tabriklar/generated/locale_keys.g.dart';
import 'package:tabriklar/utils/analytics_service.dart';
import 'package:tabriklar/utils/my_functions.dart';
import 'package:tabriklar/view_models/get_data_from_firebase/get_images_provider.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import '../../domain/service/ad_helper.dart';

class PhotosPage extends StatefulWidget {
  const PhotosPage({Key? key}) : super(key: key);

  @override
  _PhotosPageState createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  BannerAd? _bannerAd;
  bool appIsInstalled = false;
  static const MethodChannel _channel = MethodChannel('com.example/checkInstagram');

  @override
  void initState() {
    super.initState();

    checkAppInstallFromChannel();

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

  void checkAppInstallFromChannel() async {
    if (Platform.isAndroid) {
      try {
        final bool isInstalled = await _channel.invokeMethod('isInstagramInstalled');
        setState(() {
          appIsInstalled = isInstalled;
          print('isInstalled: $isInstalled');
        });
      } on PlatformException catch (e) {
        print('PlatformException: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ImageListProvider>();
    var imageLinkList = model.imageLinkList;
    var defaultLink = model.defaultLink;
    var isLoading = model.isLoading;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(LocaleKeys.congratulations_via_pic.tr()),
      ),
      body: Stack(
        children: [
          if (isLoading) ...{
            const Center(child: CupertinoActivityIndicator()),
          } else ...{
            ListView.builder(
              itemCount: imageLinkList.length,
              padding: const EdgeInsets.only(top: 16, bottom: 56),
              itemBuilder: (context, index) {
                String image = imageLinkList[index] ?? defaultLink;

                /// controller xar bir item uchun unique bo'lishi kerak
                final toImageController = WidgetsToImageController();
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0, right: 4, left: 4, top: 4),
                  child: Card(
                    elevation: 8,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: image,
                            fadeInDuration: const Duration(milliseconds: 150),
                            fadeOutDuration: const Duration(milliseconds: 150),
                            imageBuilder: (context, imageProvider) => WidgetsToImage(
                              controller: toImageController,
                              child: Image(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                            placeholder: (context, url) => const SizedBox(
                              height: 264,
                              width: double.maxFinite,
                              child: Center(child: CupertinoActivityIndicator()),
                            ),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0).copyWith(right: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  model.shareImage(image ?? defaultLink, index);
                                },
                                child: Container(
                                  height: 36.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: const Color(0xff08364F)),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  child: Row(
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
                                      SvgPicture.asset(AppIcons.send),
                                    ],
                                  ),
                                ),
                              ),
                              if (appIsInstalled) ...{
                                const SizedBox(width: 16),
                                GestureDetector(
                                  onTap: () async {
                                    final bytes = await toImageController.capture();
                                    if (bytes == null) return;

                                    //  Faylni vaqtinchalik papkaga saqlash
                                    final tempDir = await getTemporaryDirectory();
                                    final filePath = '${tempDir.path}/${image.split('/').last}$index.png';
                                    final file = File(filePath);
                                    await file.writeAsBytes(bytes);

                                    await SocialShare.shareInstagramStory(
                                      backgroundTopColor: "#ffffff",
                                      backgroundBottomColor: "#ffffff",
                                      appId: 'com.mamadaliyev.abbos.tabriklar',
                                      imagePath: filePath,
                                    ).then((value) async {
                                      await AnalyticsService.logEvent(name: 'image_instagram_story');
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: const Color(0xff08364F)),
                                    ),
                                    child: SvgPicture.asset(AppIcons.instagram),
                                  ),
                                ),
                              }
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          },
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
