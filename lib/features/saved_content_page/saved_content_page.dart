import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tabriklar/assets/colors/app_colors.dart';
import 'package:tabriklar/domain/models/happy_model.dart';
import 'package:tabriklar/generated/locale_keys.g.dart';
import 'package:tabriklar/main_navigation.dart';
import 'package:tabriklar/view_models/database/db_service_provider.dart';

class SavedContentPage extends StatefulWidget {
  const SavedContentPage({Key? key}) : super(key: key);

  @override
  _SavedContentPageState createState() => _SavedContentPageState();
}

class _SavedContentPageState extends State<SavedContentPage> {
  List<CongratulationsModel> favoriteCongratulations = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() {
    context.read<DbServiceProver>().getFavoriteData('day');
    context.read<DbServiceProver>().getFavoriteData('birthday');
    context.read<DbServiceProver>().getFavoriteData('family');
    context.read<DbServiceProver>().getFavoriteData('mart8');
    context.read<DbServiceProver>().getFavoriteData('ramazan');
    context.read<DbServiceProver>().getFavoriteData('kurban');
    context.read<DbServiceProver>().getFavoriteData('love14');
    context.read<DbServiceProver>().getFavoriteData('friend');
    context.read<DbServiceProver>().getFavoriteData('january14');
    context.read<DbServiceProver>().getFavoriteData('girl');
    context.read<DbServiceProver>().getFavoriteData('teacher');
  }

  void addToList() {
    favoriteCongratulations.clear();
    favoriteCongratulations.addAll(context.watch<DbServiceProver>().days);
    favoriteCongratulations.addAll(context.watch<DbServiceProver>().families);
    favoriteCongratulations.addAll(context.watch<DbServiceProver>().birthdays);
    favoriteCongratulations.addAll(context.watch<DbServiceProver>().mart8);
    favoriteCongratulations.addAll(context.watch<DbServiceProver>().ramazans);
    favoriteCongratulations.addAll(context.watch<DbServiceProver>().kurbans);
    favoriteCongratulations.addAll(context.watch<DbServiceProver>().love);
    favoriteCongratulations.addAll(context.watch<DbServiceProver>().friend);
    favoriteCongratulations.addAll(context.watch<DbServiceProver>().january14);
    favoriteCongratulations.addAll(context.watch<DbServiceProver>().girlNames);
    favoriteCongratulations.addAll(context.watch<DbServiceProver>().teachers);
  }

  @override
  Widget build(BuildContext context) {
    addToList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(LocaleKeys.saved.tr()),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/back.jpg'), fit: BoxFit.cover),
        ),
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: favoriteCongratulations.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(MainNavigationNames.readingFavorite, arguments: {
                    'favoriteCongratulations': favoriteCongratulations,
                    'index': index,
                  });
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  color: Colors.white.withOpacity(0.8),
                  child: ListTile(
                    title: Text(
                      favoriteCongratulations[index].content,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
