import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tabriklar/core/ui/app_ui.dart';
import 'package:tabriklar/core/ui/reading_scaffold.dart';
import 'package:tabriklar/domain/models/happy_model.dart';
import 'package:tabriklar/domain/service/ad_helper.dart';
import 'package:tabriklar/generated/locale_keys.g.dart';
import 'package:tabriklar/utils/analytics_service.dart';
import 'package:tabriklar/view_models/categor_model_provider/categor_model_provider.dart';
import 'package:tabriklar/view_models/database/db_service_provider.dart';

class ContentBirthday extends StatefulWidget {
  const ContentBirthday({Key? key}) : super(key: key);

  @override
  State<ContentBirthday> createState() => _ContentBirthdayState();
}

class _ContentBirthdayState extends State<ContentBirthday> {
  String _textLink = '';

  RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 7,
    minLaunches: 10,
    remindDays: 7,
    remindLaunches: 10,
    googlePlayIdentifier: 'com.mamadaliyev.abbos.tabriklar',
  );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await rateMyApp.init();
      rateMyApp
          .showRateDialog(
        title: context.locale.languageCode == 'uz'
            ? 'Dastur haqida fikringizni bildiring'
            : context.locale.languageCode == 'ru'
                ? 'Оставьте свой отзыв о приложении'
                : 'Leave your feedback about the app',
        message: context.locale.languageCode == 'uz'
            ? 'Dasturimizni baholab qo\'yish uchun iltimos, 5 yulduzchani bosing'
            : context.locale.languageCode == 'ru'
                ? 'Пожалуйста, оцените наше приложение, нажав на 5 звезд'
                : 'Please rate our app by clicking on 5 stars',
        context,
        listener: (button) {
          print('Clicked on "$button" button');
          return false;
        },
      )
          .then((_) {
        AnalyticsService.logEvent(name: AnalyticsKeys.rateApp);
      });
    });

    AnalyticsService.logEvent(name: AnalyticsKeys.readContent);

    super.initState();
  }

  String _title(Object? categoryIndex) {
    final categories = context.read<CategoryModelProvider>().categories(context.locale.languageCode);
    if (categoryIndex is int && categoryIndex >= 0 && categoryIndex < categories.length) {
      return categories[categoryIndex].category;
    }
    return context.locale.languageCode == 'uz'
        ? 'Tilak, tabrik, she’r'
        : context.locale.languageCode == 'ru'
            ? 'Поздравления, стихи'
            : 'Congratulations, poems';
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    var id = args['id'];
    var tableName = args['tableName'];

    final congratulations = context.watch<DbServiceProver>().congratulations;
    final congratulation = congratulations.firstWhere(
      (c) => c.id == id,
      orElse: () => congratulations[id - 1],
    );

    return ReadingScaffold(
      title: _title(args['categoryIndex']),
      content: congratulation.content,
      bannerAdUnitId: AdHelper.contentScreenBannerId,
      saved: congratulation.favourite == 1,
      onToggleSave: () {
        final service = context.read<DbServiceProver>();
        final willSave = congratulation.favourite == 0;
        service
            .setFavourite(
          model: CongratulationsModel(
            id: congratulation.id,
            content: congratulation.content,
            favourite: congratulation.favourite == 0 ? 1 : 0,
          ),
          tableName: tableName,
        )
            .then((value) {
          if (!mounted) return;
          setState(() {
            congratulation.favourite == 0 ? congratulation.favourite = 1 : congratulation.favourite = 0;
          });
          showAppSnack(
            context,
            willSave ? LocaleKeys.added_to_saved.tr() : LocaleKeys.removed_from_saved.tr(),
            icon: willSave ? Icons.bookmark_added_rounded : Icons.bookmark_remove_rounded,
          );
        });
      },
      onShare: () async {
        _textLink = congratulation.content;
        await Share.share(_textLink).then((value) {
          if (value.status == ShareResultStatus.success) {
            AnalyticsService.logEvent(name: AnalyticsKeys.sendContent);
          }
        });
      },
    );
  }
}
