import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tabriklar/models/happy_model.dart';
import 'package:tabriklar/services/database/db_service_provider.dart';

// ignore: must_be_immutable
class ContentBirthday extends StatelessWidget {
  ContentBirthday({Key? key}) : super(key: key);

  String _textLink = '';

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    var id = args['id'];
    var tableName = args['tableName'];

    final model = context.watch<DbServiceProver>().texts[id];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tilak, tabrik, sher'),
        actions: [
          IconButton(
            onPressed: () {
              final service = context.watch<DbServiceProver>();
              // set button
              service.setFavourite(
                  HappyBirthdayModel(id: id, content: content, favourite: 0),
                  tableName);
            },
            icon: Icon(
              Icons.favorite_border,
              color: Colors.redAccent,
              size: 28,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
        child: Text(
          model.content,
          style: const TextStyle(height: 1.3, fontSize: 18),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _textLink = model.content;
          await Share.share(_textLink);
        },
        child: const Icon(Icons.send),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
