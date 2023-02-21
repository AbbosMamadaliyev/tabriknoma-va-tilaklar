import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tabriklar/main_navigation.dart';
import 'package:tabriklar/view_models/categor_model_provider/categor_model_provider.dart';
import 'package:tabriklar/view_models/database/db_service_provider.dart';
import 'package:tabriklar/widgets/components/background_congratulations_page.dart';
import 'package:tabriklar/widgets/components/custom_card_songratulations.dart';

class CongratulationsWidget extends StatelessWidget {
  const CongratulationsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // bu appbar title' uchun
    final categories = context.watch<CategoryModelProvider>().categories;

    final congratulations = context.watch<DbServiceProver>().congratulations;

    var args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    var where = args['where'];
    var tableName = args['tableName'];
    var categoryIndex = args['categoryIndex'];

    return Scaffold(
      appBar: AppBar(
        title: Text(categories[categoryIndex].category),
      ),
      body: BackgroundCongratulationsPage(
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: congratulations.length,
            itemBuilder: (context, id) {
              var congratulation = congratulations[id];
              return GestureDetector(
                onTap: () {
                  // tabriklar bosilganda provider orqali borib read() qilib keladi
                  // keyingi oynaga otganda , bosilganini sezib chiqarib beradi contentni
                  context
                      .read<DbServiceProver>()
                      .getData(where: where, tableName: tableName);

                  Navigator.of(context).pushNamed(
                    MainNavigationNames.content,
                    arguments: {
                      'id': id,
                      'tableName': tableName,
                    },
                  );
                },
                child: CustomCardCongratulations(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: 8.w),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Image.asset(
                          'assets/images/$categoryIndex.jpg',
                          height: 76.h,
                          fit: BoxFit.cover,
                          width: 64.w,
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(
                            congratulation.content,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
