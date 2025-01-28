import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tabriklar/assets/colors/app_colors.dart';
import 'package:tabriklar/assets/constants/app_icons.dart';
import 'package:tabriklar/generated/locale_keys.g.dart';

class NavigationBarWidget extends StatefulWidget {
  final Function(int index) onTabChanged;
  final int sectionIndex;
  const NavigationBarWidget({super.key, required this.onTabChanged, required this.sectionIndex});

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    log('===== NavigationBarWidget build, language: ${context.locale.languageCode} =====');
    return Container(
      height: 56,
      margin: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.r),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                widget.onTabChanged(0);
              },
              child: Column(
                children: [
                  AnimatedContainer(
                    height: 4,
                    width: widget.sectionIndex == 0 ? 56 : 0,
                    duration: const Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                      color: AppColors.blue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 4),
                  SvgPicture.asset(
                    AppIcons.home,
                    height: 24,
                    width: 24,
                    color: widget.sectionIndex == 0 ? AppColors.blue : null,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    LocaleKeys.main.tr(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: widget.sectionIndex == 0 ? AppColors.blue : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                widget.onTabChanged(1);
              },
              child: Column(
                children: [
                  AnimatedContainer(
                    height: 4,
                    width: widget.sectionIndex == 1 ? 56 : 0,
                    duration: const Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                      color: AppColors.blue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 4),
                  SvgPicture.asset(
                    AppIcons.gallery,
                    height: 24,
                    width: 24,
                    color: widget.sectionIndex == 1 ? AppColors.blue : null,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    LocaleKeys.photos.tr(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: widget.sectionIndex == 1 ? AppColors.blue : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                widget.onTabChanged(2);
              },
              child: Icon(
                Icons.more_horiz,
                size: 36,
                // height: 24,
                // width: 24,
                color: widget.sectionIndex == 2 ? AppColors.blue : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
