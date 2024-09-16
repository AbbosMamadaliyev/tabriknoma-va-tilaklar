import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/src/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tabriklar/domain/models/happy_model.dart';
import 'package:tabriklar/view_models/database/db_service_provider.dart';

class ContentBirthday extends StatefulWidget {
  ContentBirthday({Key? key}) : super(key: key);

  @override
  State<ContentBirthday> createState() => _ContentBirthdayState();
}

class _ContentBirthdayState extends State<ContentBirthday> {
  String _textLink = '';

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    var id = args['id'];
    var tableName = args['tableName'];

    final congratulation = context.watch<DbServiceProver>().congratulations[id];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tilak, tabrik, sher'),
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
                  congratulation.favourite == 0
                      ? congratulation.favourite = 1
                      : congratulation.favourite = 0;
                });
              });
            },
            icon: Icon(
              congratulation.favourite == 0
                  ? Icons.favorite_border
                  : Icons.favorite,
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
          await Share.share(_textLink);
        },
        child: const Icon(Icons.send),
        backgroundColor: const Color(0xff378842),
      ),
    );
  }
}
