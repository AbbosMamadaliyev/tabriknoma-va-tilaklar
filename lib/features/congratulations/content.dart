import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/src/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tabriklar/assets/colors/app_colors.dart';
import 'package:tabriklar/domain/models/happy_model.dart';
import 'package:tabriklar/utils/analytics_service.dart';
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
      rateMyApp.showRateDialog(
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
      ).then((_) {
        AnalyticsService.logEvent(name: AnalyticsKeys.rateApp);
      });
    });

    AnalyticsService.logEvent(name: AnalyticsKeys.readContent);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    var id = args['id'];
    var tableName = args['tableName'];

    final congratulation = context.watch<DbServiceProver>().congratulations[id - 1];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: context.locale.languageCode == 'uz'
            ? const Text('Tilak, tabrik, sher')
            : context.locale.languageCode == 'ru'
                ? const Text('Поздравления, стихи')
                : const Text('Congratulations, poems'),
        actions: [
          IconButton(
            onPressed: () {
              final service = context.read<DbServiceProver>();
              // set button
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
                setState(() {
                  congratulation.favourite == 0 ? congratulation.favourite = 1 : congratulation.favourite = 0;
                });
              });
            },
            icon: Icon(
              congratulation.favourite == 0 ? Icons.favorite_border : Icons.favorite,
              color: Colors.redAccent,
              size: 28,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/back1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: Text(
              congratulation.content,
              style: TextStyle(
                height: 1.3,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _textLink = congratulation.content;
          await Share.share(_textLink).then((value) {
            if (value.status == ShareResultStatus.success) {
              AnalyticsService.logEvent(name: AnalyticsKeys.sendContent);
            }
          });
        },
        backgroundColor: Colors.white,
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.skewY(0.0)..rotateZ(-0.3),
          child: const Icon(
            Icons.send,
            color: AppColors.green,
          ),
        ),
      ),
    );
  }
}
