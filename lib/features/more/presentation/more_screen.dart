import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tabriklar/assets/themes/theme.dart';
import 'package:tabriklar/core/data/singletons/service_locator.dart';
import 'package:tabriklar/core/data/singletons/storage.dart';
import 'package:tabriklar/core/ui/app_ui.dart';
import 'package:tabriklar/domain/service/ad_helper.dart';
import 'package:tabriklar/features/common/presentation/widgets/lang_bottomsheet.dart';
import 'package:tabriklar/features/components/custom_alert_dialog.dart';
import 'package:tabriklar/features/components/google_ads_widget.dart';
import 'package:tabriklar/generated/locale_keys.g.dart';
import 'package:tabriklar/main_navigation.dart';
import 'package:tabriklar/utils/analytics_service.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MoreFunctionsScreen extends StatefulWidget {
  const MoreFunctionsScreen({super.key});

  @override
  State<MoreFunctionsScreen> createState() => _MoreFunctionsScreenState();
}

class _MoreFunctionsScreenState extends State<MoreFunctionsScreen> {
  static const _playStoreUrl = 'https://play.google.com/store/apps/details?id=com.mamadaliyev.abbos.tabriklar';

  String _version = '';

  @override
  void initState() {
    super.initState();
    AnalyticsService.logEvent(name: AnalyticsKeys.moreScreen);
    PackageInfo.fromPlatform().then((info) {
      if (mounted) setState(() => _version = info.version);
    });
  }

  String _languageName(String code) => switch (code) {
        'ru' => 'Русский',
        'en' => 'English',
        _ => 'O‘zbekcha',
      };

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpace.xxl),
      children: [
        ScreenHeader(title: LocaleKeys.more.tr()),
        AppGroup(
          dividerIndent: 58,
          children: [
            AppRow(
              leading: const RowIcon(Icons.bookmark_border_rounded),
              title: LocaleKeys.saved.tr(),
              onTap: () {
                Navigator.of(context).pushNamed(MainNavigationNames.favourites);
              },
            ),
            AppRow(
              leading: const RowIcon(Icons.edit_outlined),
              title: LocaleKeys.i_write.tr(),
              onTap: () => Navigator.of(context).pushNamed(MainNavigationNames.writing),
            ),
          ],
        ),
        const SizedBox(height: AppSpace.l),
        AppGroup(
          dividerIndent: 58,
          children: [
            AppRow(
              leading: const RowIcon(Icons.language_rounded),
              title: LocaleKeys.langauge.tr(),
              trailing: Text(_languageName(context.locale.languageCode), style: AppText.caption.copyWith(fontSize: 15)),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  showDragHandle: true,
                  builder: (context) => LanguageBottomSheet(
                    locale: context.locale.languageCode,
                    onTapX: (locale) async {
                      await context.setLocale(Locale(locale));
                      await StorageRepository.putString(StorageKeys.language, locale);
                      await resetLocator();

                      setState(() {});
                    },
                  ),
                );
              },
            ),
            AppRow(
              leading: const RowIcon(Icons.info_outline_rounded),
              title: LocaleKeys.about_app.tr(),
              onTap: _showDialog,
            ),
            AppRow(
              leading: const RowIcon(Icons.star_outline_rounded),
              title: LocaleKeys.evaluate.tr(),
              onTap: () {
                launchUrlString(_playStoreUrl, mode: LaunchMode.externalApplication);
              },
            ),
            AppRow(
              leading: const RowIcon(Icons.ios_share_rounded),
              title: LocaleKeys.share_app.tr(),
              onTap: () {
                Share.share(CustomAlertDialog.shareText);
              },
            ),
          ],
        ),
        const SizedBox(height: AppSpace.xxl),
        Center(
          child: GoogleAdsWidget(adUnitId: AdHelper.moreScreenBannerId),
        ),
        if (_version.isNotEmpty) ...[
          const SizedBox(height: AppSpace.l),
          Center(
            child: Text('${LocaleKeys.version.tr()} $_version', style: AppText.caption),
          ),
        ],
      ],
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return const CustomAlertDialog();
      },
    );
  }
}
