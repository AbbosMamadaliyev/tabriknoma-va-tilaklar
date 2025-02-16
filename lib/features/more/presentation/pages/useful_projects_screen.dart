import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabriklar/assets/constants/app_constants.dart';
import 'package:tabriklar/assets/constants/app_images.dart';
import 'package:tabriklar/domain/models/useful_apps_model.dart';
import 'package:tabriklar/features/more/presentation/widgets/useful_channel_item.dart';
import 'package:tabriklar/features/more/presentation/widgets/useful_project_item.dart';
import 'package:tabriklar/generated/locale_keys.g.dart';
import 'package:tabriklar/utils/analytics_service.dart';
import 'package:tabriklar/utils/extensions.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UsefulProjectsScreen extends StatefulWidget {
  const UsefulProjectsScreen({super.key});

  @override
  State<UsefulProjectsScreen> createState() => _UsefulProjectsScreenState();
}

class _UsefulProjectsScreenState extends State<UsefulProjectsScreen> {
  @override
  void initState() {
    AnalyticsService.logEvent(name: AnalyticsKeys.projectsScreen);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(LocaleKeys.useful.tr()),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Container(
            color: Colors.grey[300],
            height: .6,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 24),
              child: Text(
                LocaleKeys.useful_projects.tr(),
                style: context.textTheme.displaySmall!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 12),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final app = AppConstants.apps[index];
                return UsefulProjectItem(
                  image: app.image,
                  title: app.title,
                  link: app.storeLink,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 12);
              },
              itemCount: AppConstants.apps.length,
            ),

            const SizedBox(height: 16),

            /// Useful Channels
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 24),
              child: Text(
                LocaleKeys.useful_channels.tr(),
                style: context.textTheme.displaySmall!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 12),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final channel = AppConstants.channels[index];
                return UsefulChannelItem(
                  image: channel.image,
                  title: channel.title,
                  link: channel.storeLink,
                  description: channel.description,
                  usersCount: channel.usersCount,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 12);
              },
              itemCount: AppConstants.channels.length,
            ),
          ],
        ),
      ),
    );
  }
}
