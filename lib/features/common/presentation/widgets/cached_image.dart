import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tabriklar/assets/constants/app_images.dart';
import 'package:tabriklar/features/common/presentation/widgets/image_preloader.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;

  const CachedImage({
    this.imageUrl = "",
    this.width,
    this.height,
    this.fit = BoxFit.fill,
    this.color,
    this.borderRadius,
    super.key,
    this.errorWidget,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        color: color,
        fit: fit,
        placeholder: (context, url) => placeholder ?? const ImagePreloadShimmer(),
        errorWidget: (context, url, error) => errorWidget ?? Image.asset(AppImages.logo),
      ),
    );
  }
}
