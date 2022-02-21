import 'package:flutter/cupertino.dart';
import 'package:tabriklar/domain/models/db_table_model.dart';

class DbTableModelProvider extends ChangeNotifier {
  final List<DbTableModel> _dbTables = [
    DbTableModel(tableName: 'birthday', rowName: 'content', index: 0),
    DbTableModel(tableName: 'family', rowName: 'content', index: 1),
    DbTableModel(tableName: 'day', rowName: 'content', index: 2),
    DbTableModel(tableName: 'mart8', rowName: 'content', index: 3),
    DbTableModel(tableName: 'ramazan', rowName: 'content', index: 4),
    DbTableModel(tableName: 'kurban', rowName: 'content', index: 5),
    DbTableModel(tableName: 'love14', rowName: 'content', index: 6),
    DbTableModel(tableName: 'friend', rowName: 'content', index: 7),
    DbTableModel(tableName: 'january14', rowName: 'content', index: 8),
    DbTableModel(tableName: 'girl', rowName: 'content', index: 9),
    DbTableModel(tableName: 'teacher', rowName: 'content', index: 10),
  ];

  List<DbTableModel> get dbTables => _dbTables;
}
