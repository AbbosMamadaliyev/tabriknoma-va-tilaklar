import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabriklar/assets/colors/app_colors.dart';
import 'package:tabriklar/generated/locale_keys.g.dart';

class NavigationBarWidget extends StatelessWidget {
  final Function(int index) onTabChanged;
  final int sectionIndex;

  const NavigationBarWidget({super.key, required this.onTabChanged, required this.sectionIndex});

  @override
  Widget build(BuildContext context) {
    // Rebuild labels when the locale changes.
    context.locale;

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.line)),
      ),
      child: NavigationBar(
        selectedIndex: sectionIndex,
        onDestinationSelected: (index) => onTabChanged(index),
        animationDuration: const Duration(milliseconds: 250),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home_rounded),
            label: LocaleKeys.main.tr(),
          ),
          NavigationDestination(
            icon: const Icon(Icons.photo_library_outlined),
            selectedIcon: const Icon(Icons.photo_library_rounded),
            label: LocaleKeys.photos.tr(),
          ),
          NavigationDestination(
            icon: const Icon(Icons.more_horiz_rounded),
            selectedIcon: const Icon(Icons.more_horiz_rounded),
            label: LocaleKeys.more.tr(),
          ),
        ],
      ),
    );
  }
}
