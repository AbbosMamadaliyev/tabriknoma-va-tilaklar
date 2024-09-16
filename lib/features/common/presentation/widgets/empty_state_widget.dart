import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tabriklar/assets/colors/app_colors.dart';

class EmptyStateWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final double? sizeBetweenTitleSubtitle;
  final double? sizeBetweenIconTitle;
  final VoidCallback? onRefresh;

  final bool isNeedTopPadding;

  const EmptyStateWidget(
      {super.key,
      this.icon = '',
      required this.title,
      required this.subtitle,
      this.titleTextStyle,
      this.subtitleTextStyle,
      this.isNeedTopPadding = true,
      this.sizeBetweenTitleSubtitle,
      this.sizeBetweenIconTitle,
      this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        if (onRefresh != null) {
          onRefresh!();
        }
      },
      color: AppColors.orange,
      child: SingleChildScrollView(
        physics: onRefresh != null ? const AlwaysScrollableScrollPhysics() : null,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: isNeedTopPadding ? MediaQuery.of(context).size.height * 0.2 : 0),
            if (icon.contains('.svg'))
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: SvgPicture.asset(icon, height: 100),
              )
            else if (icon.contains('.png'))
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Image.asset(
                  icon,
                  height: 130,
                  width: 130,
                ),
              ),
            SizedBox(height: sizeBetweenIconTitle ?? 8),
            Text(
              title,
              style: titleTextStyle ??
                  Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontSize: 12,
                      ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: sizeBetweenTitleSubtitle ?? 8),
            Text(
              subtitle,
              style: subtitleTextStyle ??
                  Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
