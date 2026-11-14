import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tabriklar/assets/colors/app_colors.dart';
import 'package:tabriklar/assets/constants/app_icons.dart';
import 'package:tabriklar/assets/themes/theme.dart';
import 'package:tabriklar/core/ui/app_ui.dart';
import 'package:tabriklar/generated/locale_keys.g.dart';

class LanguageBottomSheet extends StatefulWidget {
  final String locale;

  const LanguageBottomSheet({super.key, required this.onTapX, required this.locale});

  final Function(String locale) onTapX;

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
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppSpace.l, 0, AppSpace.l, AppSpace.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpace.s),
              child: Text(LocaleKeys.choose_lang.tr(), style: AppText.title),
            ),
            const SizedBox(height: AppSpace.l),
            for (var index = 0; index < titleList.length; index++) ...[
              _LanguageOption(
                flag: img[index],
                title: titleList[index],
                selected: selectedLanguage == index,
                onTap: () {
                  if (selectedLanguage == index) return;
                  HapticFeedback.selectionClick();
                  setState(() => selectedLanguage = index);
                },
              ),
              if (index != titleList.length - 1) const SizedBox(height: AppSpace.xs),
            ],
            const SizedBox(height: AppSpace.xl),
            PrimaryButton(
              label: LocaleKeys.confirm.tr(),
              onPressed: () {
                widget.onTapX(
                  selectedLanguage == 0
                      ? 'uz'
                      : selectedLanguage == 1
                          ? 'ru'
                          : 'en',
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.flag,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final String flag;
  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.accentSoft : Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.tile),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.m, vertical: 14),
          child: Row(
            children: [
              ClipOval(child: SvgPicture.asset(flag, width: 28, height: 28, fit: BoxFit.cover)),
              const SizedBox(width: AppSpace.m),
              Expanded(child: Text(title, style: AppText.bodyStrong)),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 150),
                child: selected
                    ? const Icon(Icons.check_circle_rounded, key: ValueKey(true), color: AppColors.accent)
                    : const Icon(Icons.circle_outlined, key: ValueKey(false), color: AppColors.line),
              ),
            ],
          ),
        ),
      ),
    );
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
