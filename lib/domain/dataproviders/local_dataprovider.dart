import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tabriklar/core/data/singletons/storage.dart';

class LocalDataProvider {
  LocalDataProvider._();

  static const uzDatabaseName = 'happy.db';
  static const ruDatabaseName = 'ru_happy.db';
  static const enDatabaseName = 'en_happy.db';
  static const databaseVersion = 1;

  LocalDataProvider._privateConstructor();

  static final LocalDataProvider instance = LocalDataProvider._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database == null) {
      return initializeDatabase();
    }

    _database = await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    var databasePath = await getDatabasesPath();

    final langCode = StorageRepository.getString(StorageKeys.language, defValue: 'uz');
    print('langCode121: $langCode');

    String databaseName = langCode == 'ru'
        ? ruDatabaseName
        : langCode == 'en'
            ? enDatabaseName
            : uzDatabaseName;

    String path = join(databasePath, databaseName);
    var exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (e) {
        print(e);
      }
      ByteData data = await rootBundle.load(join('assets', databaseName));

      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);

      return openDatabase(path, version: databaseVersion);
    } else {
      //tepadagi ifdan ochvoladi birinchi, keyin elsedan ochilganni ishlataveradi

      return openDatabase(path, version: databaseVersion);
    }
  }
}
