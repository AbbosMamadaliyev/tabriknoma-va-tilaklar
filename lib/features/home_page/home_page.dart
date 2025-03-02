import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:tabriklar/features/home_page/widgets/ramadan_time_widget.dart';
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
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const RamadanTimeWidget(),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: dbTables.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 88),
              itemBuilder: (context, categoryIndex) {
                // dbTabel bu yerda categoryalar, adashma!!!
                var table = dbTables[categoryIndex];
                return AnimationConfiguration.staggeredList(
                  position: categoryIndex,
                  duration: const Duration(milliseconds: 500),
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
                );
              }),
        ],
      ),
    );
  }
}
