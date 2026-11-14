import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:social_share/social_share.dart';
import 'package:tabriklar/assets/colors/app_colors.dart';
import 'package:tabriklar/assets/constants/app_icons.dart';
import 'package:tabriklar/assets/themes/theme.dart';
import 'package:tabriklar/core/ui/app_ui.dart';
import 'package:tabriklar/generated/locale_keys.g.dart';
import 'package:tabriklar/utils/analytics_service.dart';
import 'package:tabriklar/view_models/get_data_from_firebase/get_images_provider.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import '../../domain/service/ad_helper.dart';

class PhotosPage extends StatefulWidget {
  const PhotosPage({Key? key}) : super(key: key);

  @override
  _PhotosPageState createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  bool appIsInstalled = false;

  /// Assets that failed to decode — no point offering to share a broken image.
  final Set<String> _failedImages = {};

  static const MethodChannel _channel = MethodChannel('com.example/checkInstagram');

  @override
  void initState() {
    super.initState();
    checkAppInstallFromChannel();
  }

  void checkAppInstallFromChannel() async {
    if (Platform.isAndroid) {
      try {
        final bool isInstalled = await _channel.invokeMethod('isInstagramInstalled');
        if (!mounted) return;
        setState(() {
          appIsInstalled = isInstalled;
          print('isInstalled: $isInstalled');
        });
      } on PlatformException catch (e) {
        print('PlatformException: $e');
      }
    }
  }

  Future<void> _shareToInstagramStory(WidgetsToImageController toImageController, String image, int index) async {
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
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ImageListProvider>();
    final imageLinkList = model.imageLinkList;
    final isLoading = model.isLoading;
    // Decode at screen resolution instead of the full 1080px source to keep memory low.
    final cacheWidth = (MediaQuery.sizeOf(context).width * MediaQuery.devicePixelRatioOf(context)).round().clamp(320, 1080);

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.congratulations_via_pic.tr()),
      ),
      body: isLoading
          ? ListView.separated(
              padding: const EdgeInsets.fromLTRB(AppSpace.l, AppSpace.xs, AppSpace.l, AppSpace.xxl),
              itemCount: 3,
              separatorBuilder: (_, __) => const SizedBox(height: AppSpace.l),
              itemBuilder: (_, __) => const SkeletonBox(height: 360),
            )
          : ListView.separated(
              itemCount: imageLinkList.length,
              padding: const EdgeInsets.fromLTRB(AppSpace.l, AppSpace.xs, AppSpace.l, AppSpace.xxl),
              separatorBuilder: (_, __) => const SizedBox(height: AppSpace.l),
              itemBuilder: (context, index) {
                final image = imageLinkList[index];
                final isSharing = index < model.isActiveBtn.length && model.isActiveBtn[index] == true;

                /// controller xar bir item uchun unique bo'lishi kerak
                final toImageController = WidgetsToImageController();
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.fill,
                    borderRadius: BorderRadius.circular(AppRadius.card),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Bundled cards are 1080x1350 (4:5); a fixed ratio keeps the list from jumping while decoding.
                      AspectRatio(
                        aspectRatio: 4 / 5,
                        child: WidgetsToImage(
                          controller: toImageController,
                          child: Image.asset(
                            image,
                            fit: BoxFit.cover,
                            cacheWidth: cacheWidth,
                            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                              if (wasSynchronouslyLoaded) return child;
                              return AnimatedOpacity(
                                opacity: frame == null ? 0 : 1,
                                duration: const Duration(milliseconds: 150),
                                child: child,
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              if (!_failedImages.contains(image)) {
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  if (mounted) setState(() => _failedImages.add(image));
                                });
                              }
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.broken_image_outlined, color: AppColors.inkTertiary, size: 36),
                                  const SizedBox(height: AppSpace.s),
                                  Text(LocaleKeys.image_load_error.tr(), style: AppText.caption),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      if (!_failedImages.contains(image))
                        Padding(
                          padding: const EdgeInsets.all(AppSpace.m),
                          child: Row(
                            children: [
                              Expanded(
                                child: PrimaryButton(
                                  height: 48,
                                  icon: Icons.send_rounded,
                                  label: LocaleKeys.share.tr(),
                                  loading: isSharing,
                                  onPressed: () {
                                    model.shareImage(image, index);
                                  },
                                ),
                              ),
                              if (appIsInstalled) ...[
                                const SizedBox(width: AppSpace.s),
                                _InstagramButton(
                                  onTap: () => _shareToInstagramStory(toImageController, image, index),
                                ),
                              ],
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomBannerBar(adUnitId: AdHelper.bannerAdUnitId),
    );
  }
}

class _InstagramButton extends StatelessWidget {
  const _InstagramButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Instagram Stories',
      child: Material(
        color: AppColors.surface,
        shape: const StadiumBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            width: 56,
            height: 48,
            child: Center(child: SvgPicture.asset(AppIcons.instagram, width: 24, height: 24)),
          ),
        ),
      ),
    );
  }
}
