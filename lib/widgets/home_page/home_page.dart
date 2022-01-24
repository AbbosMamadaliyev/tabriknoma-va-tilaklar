import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:tabriklar/main_navigation.dart';
import 'package:tabriklar/services/categor_model_provider/categor_model_provider.dart';
import 'package:tabriklar/services/database/db_service_provider.dart';
import 'package:tabriklar/services/db_table_model_provider/db_table_model_provider.dart';
import 'package:tabriklar/widgets/components/background_home_page.dart';
import 'package:tabriklar/widgets/components/custom_advanced_drawer.dart';

import '../components/custom_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _advancedDrawerController = AdvancedDrawerController();

  void _handleMuneButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final categories = context.watch<CategoryModelProvider>().categories;
    final dbTables = context.watch<DbTableModelProvider>().dbTables;

    return CustomAdvancedDrawer(
      advancedDrawerController: _advancedDrawerController,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Color(0xff1e027a),
            ),
            onPressed: _handleMuneButtonPressed,
          ),
          title: const Text(
            'Tabrik va tilaklar',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: BackgroundHomePage(
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: dbTables.length,
              itemBuilder: (context, categoryIndex) {
                // dbTabel bu yerda categoryalar, adashma!!!
                var table = dbTables[categoryIndex];
                return GestureDetector(
                  onTap: () {
                    context.read<DbServiceProver>().getData(
                        where: table.rowName, tableName: table.tableName);

                    Navigator.of(context).pushNamed(
                        MainNavigationNames.congratulations,
                        arguments: {
                          'where': table.rowName,
                          'tableName': table.tableName,
                          'categoryIndex': categoryIndex,
                        });
                  },
                  child: CustomCard(
                    text: categories[categoryIndex].category,
                  ),
                );
              }),
        ),
      ),
    );
  }
}
