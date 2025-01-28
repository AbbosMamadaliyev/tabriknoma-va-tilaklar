import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tabriklar/generated/locale_keys.g.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(LocaleKeys.about_app.tr()),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(LocaleKeys.collection_contains_best_congrats_and_wishes.tr()),
          Text(LocaleKeys.if_you_like_app_please_rate_it.tr()),
          const SizedBox(height: 4),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      final url =
                          Uri.parse('https://play.google.com/store/apps/details?id=com.mamadaliyev.abbos.tabriklar');

                      launchUrl(url, mode: LaunchMode.externalApplication);
                    },
                    icon: const Icon(
                      Icons.star,
                      color: Colors.orangeAccent,
                    ),
                  ),
                  Text(LocaleKeys.evaluate.tr()),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () async {
                      const shareText =
                          'Bu dasturda siz yaqiningiz uchun tayyor tilaklar va tabriklar topishingiz mumkin. \n\nhttps://play.google.com/store/apps/details?id=com.mamadaliyev.abbos.tabriklar';

                      await Share.share(shareText);
                    },
                    icon: const Icon(
                      Icons.share,
                      color: Colors.green,
                    ),
                  ),
                  Text(LocaleKeys.share.tr()),
                ],
              ),
            ],
          ),
          const Divider(),
          Text(LocaleKeys.materials_in_the_app_taken_from_net.tr()),
        ],
      ),
    );
  }
}
