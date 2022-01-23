import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tabriklar/models/happy_model.dart';
import 'package:tabriklar/services/database/db_service.dart';

class DbServiceProver extends ChangeNotifier {
  final db = DatabaseService.instance;
  String query = '';

  final List<HappyBirthdayModel> _texts = [];
  List<HappyBirthdayModel> get texts => _texts;

  Future<List<HappyBirthdayModel>> _getText(
      String query, String where, String tableName) async {
    final database = db.database;
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        tableName,
        where: '$where like ?',
        whereArgs: ['$query%'],
      );

      return List.generate(maps.length, (index) {
        return HappyBirthdayModel.fromJson(maps[index]);
      });
    } catch (e) {
      print('xatolik: $e');

      ///   , bu ozgarish qolbola ozim qildim, copy tepadan tryni ichidagi, chunki ikkita return sorayabdi get
      ///
      final db = await database;

      final List<Map<String, dynamic>> maps = await db.query(
        tableName,
        where: '$where like ?',
        whereArgs: ['$query%'],
      );

      return List.generate(maps.length, (index) {
        return HappyBirthdayModel.fromJson(maps[index]);
      });
    }
  }

  getData({required String where, required String tableName}) {
    _getText(query, where, tableName).then((value) {
      _texts.clear();
      _texts.addAll(value);
      notifyListeners();
    });
  }

  //get favourite words, tepadagi getWords bilan birxil yozilishi, faqat sql zapros boshqacha boladi
  Future<List<HappyBirthdayModel>> getFavouriteWords(
      String query, String tableName) async {
    final database = await db.database;

    final List<Map<String, dynamic>> maps = await database.rawQuery(
      'SELECT * FROM $tableName WHERE favourite = 1 AND content LIKE ?',
      ['$query%'],
    );

    return List.generate(maps.length, (index) {
      return HappyBirthdayModel.fromJson(maps[index]);
    });
  }

//set favourite words
  Future<int?> setFavourite(HappyBirthdayModel model, String tableName) async {
    final database = await db.database;

    return database.update(
      tableName,
      model.toJson(),
      where: 'id = ?',
      whereArgs: [model.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
