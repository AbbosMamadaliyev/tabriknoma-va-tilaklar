import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tabriklar/assets/colors/app_colors.dart';
import 'package:tabriklar/assets/themes/theme.dart';
import 'package:tabriklar/core/ui/app_ui.dart';
import 'package:tabriklar/generated/locale_keys.g.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({Key? key}) : super(key: key);

  static const shareText =
      'Bu dasturda siz yaqiningiz uchun tayyor tilaklar va tabriklar topishingiz mumkin. \n\nhttps://play.google.com/store/apps/details?id=com.mamadaliyev.abbos.tabriklar';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 28),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const BrandMark(size: 56),
            const SizedBox(height: AppSpace.l),
            Text(LocaleKeys.about_app.tr(), style: AppText.title, textAlign: TextAlign.center),
            const SizedBox(height: AppSpace.s),
            Text(
              LocaleKeys.collection_contains_best_congrats_and_wishes.tr(),
              textAlign: TextAlign.center,
              style: AppText.body.copyWith(fontSize: 15, color: AppColors.inkSecondary),
            ),
            const SizedBox(height: AppSpace.s),
            Text(
              LocaleKeys.if_you_like_app_please_rate_it.tr(),
              textAlign: TextAlign.center,
              style: AppText.body.copyWith(fontSize: 15, color: AppColors.inkSecondary),
            ),
            const SizedBox(height: AppSpace.xl),
            Row(
              children: [
                Expanded(
                  child: TonalButton(
                    dense: true,
                    height: 48,
                    icon: Icons.star_rounded,
                    label: LocaleKeys.evaluate.tr(),
                    onPressed: () {
                      final url =
                          Uri.parse('https://play.google.com/store/apps/details?id=com.mamadaliyev.abbos.tabriklar');

                      launchUrl(url, mode: LaunchMode.externalApplication);
                    },
                  ),
                ),
                const SizedBox(width: AppSpace.s),
                Expanded(
                  child: TonalButton(
                    dense: true,
                    height: 48,
                    icon: Icons.ios_share_rounded,
                    label: LocaleKeys.share.tr(),
                    onPressed: () async {
                      await Share.share(shareText);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpace.l),
            Text(
              LocaleKeys.materials_in_the_app_taken_from_net.tr(),
              textAlign: TextAlign.center,
              style: AppText.caption.copyWith(color: AppColors.inkTertiary),
            ),
          ],
        ),
      ),
    );
  }
}
