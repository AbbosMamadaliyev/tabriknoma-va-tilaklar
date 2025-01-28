import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tabriklar/domain/dataproviders/local_dataprovider.dart';
import 'package:tabriklar/domain/models/happy_model.dart';

class DbServiceProver extends ChangeNotifier {
  final db = LocalDataProvider.instance;
  String query = '';

  final List<CongratulationsModel> _congratulations = [];
  List<CongratulationsModel> get congratulations {
    return _congratulations;
  }

  final List<CongratulationsModel> birthdays = [];
  final List<CongratulationsModel> families = [];
  final List<CongratulationsModel> days = [];
  final List<CongratulationsModel> mart8 = [];
  final List<CongratulationsModel> ramazans = [];
  final List<CongratulationsModel> kurbans = [];
  final List<CongratulationsModel> love = [];
  final List<CongratulationsModel> friend = [];
  final List<CongratulationsModel> january14 = [];
  final List<CongratulationsModel> girlNames = [];
  final List<CongratulationsModel> teachers = [];

  Future<List<CongratulationsModel>> _getText(String query, String where, String tableName) async {
    final database = db.database;
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        tableName,
        where: '$where like ?',
        whereArgs: ['$query%'],
      );

      return List.generate(maps.length, (index) {
        return CongratulationsModel.fromJson(maps[index]);
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
        return CongratulationsModel.fromJson(maps[index]);
      });
    }
  }

  getData({required String where, required String tableName}) {
    _getText(query, where, tableName).then((value) {
      _congratulations.clear();
      _congratulations.addAll(value);

      // _congratulations.shuffle();
      notifyListeners();
    });
  }

  //get favourite words, tepadagi getWords bilan birxil yozilishi, faqat sql zapros boshqacha boladi
  Future<List<CongratulationsModel>> _getFavouriteWords(String query, String tableName) async {
    final database = await db.database;

    final List<Map<String, dynamic>> maps = await database.rawQuery(
      'SELECT * FROM $tableName WHERE favourite = 1 AND content LIKE ?',
      ['$query%'],
    );

    return List.generate(maps.length, (index) {
      return CongratulationsModel.fromJson(maps[index]);
    });
  }

  getFavoriteData(String tableName) {
    _getFavouriteWords(query, tableName).then((value) {
      switch (tableName) {
        case 'birthday':
          birthdays.clear();
          birthdays.addAll(value);
          break;
        case 'family':
          families.clear();
          families.addAll(value);
          break;
        case 'day':
          days.clear();
          days.addAll(value);
          break;
        case 'mart8':
          mart8.clear();
          mart8.addAll(value);
          break;
        case 'ramazan':
          ramazans.clear();
          ramazans.addAll(value);
          break;
        case 'kurban':
          kurbans.clear();
          kurbans.addAll(value);
          break;
        case 'love14':
          love.clear();
          love.addAll(value);
          break;
        case 'friend':
          friend.clear();
          friend.addAll(value);
          break;
        case 'january14':
          january14.clear();
          january14.addAll(value);
          break;
        case 'girl':
          girlNames.clear();
          girlNames.addAll(value);
          break;
        case 'teacher':
          teachers.clear();
          teachers.addAll(value);
          break;
      }
      notifyListeners();
    });
  }

//set favourite words
  Future<int?> setFavourite({required CongratulationsModel model, required String tableName}) async {
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
