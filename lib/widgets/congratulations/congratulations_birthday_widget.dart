import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabriklar/main_navigation.dart';
import 'package:tabriklar/services/categor_model_provider/categor_model_provider.dart';
import 'package:tabriklar/services/database/db_service_provider.dart';
import 'package:tabriklar/widgets/components/background_congratulations_page.dart';
import 'package:tabriklar/widgets/components/custom_card_songratulations.dart';

class CongratulationsWidget extends StatelessWidget {
  const CongratulationsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = context.watch<CategoryModelProvider>().categories;
    final model = context.watch<DbServiceProver>().texts;

    var args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    var content = args['content'];
    var tableName = args['tableName'];
    var index = args['index'];

    return Scaffold(
      appBar: AppBar(
        title: Text(categories[index].category),
      ),
      body: BackgroundCongratulationsPage(
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: model.length,
            itemBuilder: (context, id) {
              var text = model[id];
              return GestureDetector(
                onTap: () {
                  context
                      .read<DbServiceProver>()
                      .getData(where: content, tableName: tableName);

                  Navigator.of(context).pushNamed(
                    MainNavigationNames.content,
                    arguments: {
                      'id': id,
                      'tableName': tableName,
                    },
                  );
                },
                child: CustomCardCongratulations(
                  child: ListTile(
                    leading: Image.asset(
                      'assets/images/$index.jpg',
                      height: 64,
                      width: 50,
                    ),
                    title: Text(
                      text.content,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: Colors.white),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
