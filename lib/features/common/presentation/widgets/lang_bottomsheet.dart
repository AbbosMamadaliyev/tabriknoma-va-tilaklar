import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tabriklar/assets/colors/app_colors.dart';
import 'package:tabriklar/assets/constants/app_icons.dart';
import 'package:tabriklar/features/common/presentation/widgets/common_button.dart';
import 'package:tabriklar/features/common/presentation/widgets/common_scale_animation.dart';
import 'package:tabriklar/features/common/presentation/widgets/language_title.dart';
import 'package:tabriklar/generated/locale_keys.g.dart';
import 'package:tabriklar/utils/extensions.dart';

class LanguageBottomSheet extends StatefulWidget {
  final String locale;

  const LanguageBottomSheet({super.key, required this.onTapX, required this.locale});

  final Function() onTapX;

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  List<String> titleList = ['O‘zbekcha', 'Русский', 'English'];
  List<String> img = [
    AppIcons.flagUz,
    AppIcons.flagRu,
    AppIcons.flagEn,
  ];
  late int selectedLanguage;

  @override
  void initState() {
    widget.locale == 'uz'
        ? selectedLanguage = 0
        : widget.locale == 'ru'
            ? selectedLanguage = 1
            : selectedLanguage = 2;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          color: AppColors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  LocaleKeys.choose_lang.tr(),
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                ),
                const Spacer(),
                ButtonScaleAnimation(
                  child: SvgPicture.asset(
                    AppIcons.xBack,
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(AppColors.grey2, BlendMode.dstIn),
                  ),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Container(height: 1, color: AppColors.grey4),
            ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 16),
                separatorBuilder: (context, index) => Container(height: 1, color: AppColors.grey4),
                itemCount: titleList.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => LanguageTitle(
                      isHaveImage: true,
                      img: img[index],
                      onTap: (value) {
                        selectedLanguage = index;
                        setState(() {});
                      },
                      title: titleList[index],
                      value: selectedLanguage,
                      groupValue: index,
                    )),
            CommonButton(
              hasGradient: true,
              color: AppColors.blue,
              margin: EdgeInsets.only(top: 20, bottom: MediaQuery.of(context).padding.bottom),
              onTap: () {
                widget.onTapX();
                Navigator.pop(
                  context,
                  selectedLanguage == 0
                      ? 'uz'
                      : selectedLanguage == 1
                          ? 'ru'
                          : 'en',
                );
              },
              child: Text(
                LocaleKeys.confirm.tr(),
                style: context.textTheme.headlineMedium!
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.white),
              ),
            ),
          ],
        ));
  }
}

class LanguageModel {
  final String title;
  final String flag;
  final String keys;

  const LanguageModel({
    required this.title,
    required this.flag,
    required this.keys,
  });
}
