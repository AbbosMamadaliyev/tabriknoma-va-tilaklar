import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabriklar/generated/locale_keys.g.dart';
import 'package:tabriklar/utils/extensions.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UsefulChannelItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final int usersCount;
  final String link;

  const UsefulChannelItem({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.usersCount,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.2),
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1,
                color: Colors.grey[200]!,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                height: 44,
                width: 44,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.displaySmall!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: context.textTheme.displaySmall!.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () async {
              await launchUrlString(link, mode: LaunchMode.externalApplication);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Text(
                    LocaleKeys.transition.tr(),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.link, size: 18)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
