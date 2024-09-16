import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tabriklar/assets/colors/app_colors.dart';

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer({
    super.key,
    required this.width,
    required this.height,
    required this.borderRadius,
    this.padding,
    this.margin,
    this.bgColor,
    this.baseColor,
    this.highlightColor,
    this.child,
    this.enable,
  });

  final double width;
  final double height;
  final double borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? bgColor;
  final Color? baseColor;
  final Color? highlightColor;
  final Widget? child;
  final bool? enable;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      enabled: enable ?? true,
      baseColor: baseColor ?? AppColors.grey4,
      highlightColor: highlightColor ?? AppColors.grey3,
      child: Container(
          height: height,
          width: width,
          padding: padding,
          margin: margin,
          decoration:
              BoxDecoration(color: bgColor ?? AppColors.white, borderRadius: BorderRadius.circular(borderRadius)),
          child: child),
    );
  }
}
