import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabriklar/assets/colors/app_colors.dart';
import 'package:tabriklar/core/data/singletons/service_locator.dart';
import 'package:tabriklar/core/data/singletons/storage.dart';
import 'package:tabriklar/domain/service/ad_helper.dart';
import 'package:tabriklar/features/common/presentation/widgets/lang_bottomsheet.dart';
import 'package:tabriklar/features/components/custom_alert_dialog.dart';
import 'package:tabriklar/features/components/google_ads_widget.dart';
import 'package:tabriklar/features/more/presentation/widgets/for_you_useful_card.dart';
import 'package:tabriklar/generated/locale_keys.g.dart';
import 'package:tabriklar/main_navigation.dart';
import 'package:tabriklar/utils/analytics_service.dart';
import 'package:tabriklar/utils/extensions.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MoreFunctionsScreen extends StatefulWidget {
  const MoreFunctionsScreen({super.key});

  @override
  State<MoreFunctionsScreen> createState() => _MoreFunctionsScreenState();
}

class _MoreFunctionsScreenState extends State<MoreFunctionsScreen> {
  @override
  void initState() {
    super.initState();
    AnalyticsService.logEvent(name: AnalyticsKeys.moreScreen);
  }

  @override
  Widget build(BuildContext context) {
    // MainScreen uses extendBody: true + floating nav (~56 + 24 margin).
    final bottomInset = MediaQuery.paddingOf(context).bottom + 96;

    return ListView(
      padding: EdgeInsets.only(top: 24, bottom: bottomInset),
      children: [
        _buildListTile(
          LocaleKeys.saved.tr(),
          Icons.favorite,
          Colors.redAccent,
          () {
            Navigator.of(context).pushNamed(MainNavigationNames.favourites);
          },
        ),
        _buildListTile(
          LocaleKeys.i_write.tr(),
          Icons.edit,
          Colors.green,
          () => Navigator.of(context).pushNamed(MainNavigationNames.writing),
        ),
        _buildListTile(
          LocaleKeys.langauge.tr(),
          Icons.language,
          Colors.blue,
          () {
            showModalBottomSheet(
              context: context,
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Expanded(
                child: _buildListTile(LocaleKeys.about_app.tr(), Icons.info, Colors.grey, () {
                  _showDialog();
                }, isRow: true),
              ),
              Expanded(
                child: _buildListTile(
                  LocaleKeys.evaluate.tr(),
                  Icons.star,
                  Colors.deepPurpleAccent,
                  () {
                    const url = 'https://play.google.com/store/apps/details?id=com.mamadaliyev.abbos.tabriklar';

                    launchUrlString(url, mode: LaunchMode.externalApplication);
                  },
                  isRow: true,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const UsefulForYouCard(),
        const SizedBox(height: 16),
        Center(
          child: GoogleAdsWidget(adUnitId: AdHelper.moreScreenBannerId),
        ),
      ],
    );
  }

  Widget _buildListTile(String title, IconData icon, Color color, void Function() func, {bool isRow = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: isRow ? 0 : 16),
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
      ),
      child: ListTile(
        onTap: func,
        leading: Icon(icon, color: color),
        title: Text(
          title,
          style: context.textTheme.displaySmall!.copyWith(fontSize: isRow ? 15 : 16, fontWeight: FontWeight.w500),
        ),
      ),
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
