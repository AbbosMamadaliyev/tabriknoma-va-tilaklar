import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';
import 'package:tabriklar/assets/colors/app_colors.dart';

class CommonButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String text;
  final Color? color;
  final Color? rippleColor;
  final Color? textColor;
  final bool hasGradient;
  final TextStyle? textStyle;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final GestureTapCallback onTap;
  final BoxBorder? border;
  final double borderRadius;
  final Widget? child;
  final Widget? loadingWidget;
  final Color disabledColor;
  final bool isDisabled;
  final bool isLoading;
  final double? scaleValue;
  final List<BoxShadow>? shadow;

  const CommonButton({
    required this.onTap,
    this.text = '',
    this.color = AppColors.white,
    this.textColor,
    this.borderRadius = 10,
    this.disabledColor = AppColors.grey4,
    this.isDisabled = false,
    this.isLoading = false,
    this.width,
    this.height,
    this.hasGradient = false,
    this.margin,
    this.padding,
    this.textStyle,
    this.border,
    this.child,
    this.scaleValue,
    this.shadow,
    this.loadingWidget,
    Key? key,
    this.rippleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isLoading || isDisabled,
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: TouchRipple(
          rippleColor: rippleColor ?? AppColors.black.withAlpha(50),
          // scaleValue: scaleValue ?? 0.95,
          onTap: () {
            if (!(isLoading || isDisabled)) {
              Timer.periodic(const Duration(milliseconds: 100), (timer) {
                onTap();
                timer.cancel();
              });
            }
          },
          borderRadius: BorderRadius.circular(borderRadius),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: width,
            height: height ?? 44,
            padding: padding ?? EdgeInsets.zero,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isDisabled ? disabledColor : color,
              borderRadius: BorderRadius.circular(borderRadius),
              border: border,
              boxShadow: shadow,
            ),
            child: isLoading
                ? loadingWidget ?? const Center(child: CupertinoActivityIndicator(color: AppColors.white))
                : AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontSize: 15, color: isDisabled ? AppColors.grey2 : textColor),
                    child: child ??
                        Text(
                          text,
                          style: textStyle,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                        ),
                  ),
          ),
        ),
      ),
    );
  }
}
