import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabriklar/assets/colors/app_colors.dart';
import 'package:tabriklar/assets/themes/theme.dart';
import 'package:tabriklar/core/ui/app_ui.dart';
import 'package:tabriklar/domain/service/ad_helper.dart';
import 'package:tabriklar/features/components/google_ads_widget.dart';
import 'package:tabriklar/generated/locale_keys.g.dart';
import 'package:tabriklar/main_navigation.dart';
import 'package:tabriklar/view_models/get_data_from_firebase/get_images_provider.dart';

class CategorPhotosWidget extends StatelessWidget {
  const CategorPhotosWidget({Key? key}) : super(key: key);

  static const List<String> imgs = ['0', 'juma1', 'new_year'];

  static const List<String> categories = [
    'Tug‘ilgan kun tabriklari rasmda',
    'Juma ayyomi tabriklari',
    'Aralash tabrik va tilaklar',
  ];

  // category name in russian language
  static const List<String> ruCategories = [
    'С днём рождения в картинках',
    'Поздравления с Джумой',
    'Разные поздравления и пожелания',
  ];

  static const List<String> enCategories = [
    'Birthday greetings in pictures',
    'Greetings for Juma',
    'Various greetings and wishes',
  ];

  String _title(BuildContext context, int index) {
    final lang = context.locale.languageCode;
    return lang == 'uz'
        ? categories[index]
        : lang == 'ru'
            ? ruCategories[index]
            : enCategories[index];
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpace.xxl),
      children: [
        ScreenHeader(
          title: LocaleKeys.photos.tr(),
          subtitle: LocaleKeys.congratulations_via_pic.tr(),
        ),
        for (var index = 0; index < imgs.length; index++) ...[
          _PhotoCategoryCard(
            image: 'assets/images/${imgs[index]}.jpg',
            title: _title(context, index),
            onTap: () {
              context.read<ImageListProvider>().loadCategory(index + 1);
              Navigator.of(context).pushNamed(MainNavigationNames.photos);
            },
          ),
          const SizedBox(height: AppSpace.m),
        ],
        const SizedBox(height: AppSpace.s),
        Center(
          child: GoogleAdsWidget(adUnitId: AdHelper.bannerAdUnitId),
        ),
      ],
    );
  }
}

class _PhotoCategoryCard extends StatelessWidget {
  const _PhotoCategoryCard({required this.image, required this.title, required this.onTap});

  final String image;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.l),
      child: Material(
        color: AppColors.fill,
        borderRadius: BorderRadius.circular(AppRadius.card),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 176,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Ink.image(image: AssetImage(image), fit: BoxFit.cover, child: const SizedBox.expand()),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.35, 1],
                      colors: [Color(0x00000000), Color(0xB3000000)],
                    ),
                  ),
                ),
                Positioned(
                  left: AppSpace.l,
                  right: AppSpace.l,
                  bottom: AppSpace.l,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: AppText.headline.copyWith(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      const SizedBox(width: AppSpace.s),
                      Container(
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        child: const Icon(Icons.arrow_forward_rounded, size: 20, color: AppColors.ink),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
