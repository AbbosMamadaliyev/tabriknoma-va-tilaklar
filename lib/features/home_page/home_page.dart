import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:tabriklar/main_navigation.dart';
import 'package:tabriklar/view_models/categor_model_provider/categor_model_provider.dart';
import 'package:tabriklar/view_models/database/db_service_provider.dart';
import 'package:tabriklar/view_models/db_table_model_provider/db_table_model_provider.dart';

import '../components/custom_card.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = context.watch<CategoryModelProvider>().categories(context.locale.languageCode);
    final dbTables = context.watch<DbTableModelProvider>().dbTables;
    return AnimationLimiter(
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: dbTables.length,
          padding: const EdgeInsets.only(bottom: 88),
          itemBuilder: (context, categoryIndex) {
            // dbTabel bu yerda categoryalar, adashma!!!
            var table = dbTables[categoryIndex];
            return AnimationConfiguration.staggeredList(
              position: categoryIndex,
              duration: const Duration(milliseconds: 500),
              child: SlideAnimation(
                curve: Curves.bounceIn,
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: GestureDetector(
                    onTap: () {
                      context.read<DbServiceProver>().getData(where: table.rowName, tableName: table.tableName);

                      Navigator.of(context).pushNamed(MainNavigationNames.congratulations, arguments: {
                        'where': table.rowName,
                        'tableName': table.tableName,
                        'categoryIndex': categoryIndex,
                      });
                    },
                    child: CustomCard(
                      text: categories[categoryIndex].category,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
