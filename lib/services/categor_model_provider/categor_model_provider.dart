import 'package:flutter/cupertino.dart';
import 'package:tabriklar/models/category_models.dart';

class CategoryModelProvider extends ChangeNotifier {
  final List<Category> _categories = [
    Category(category: 'Tug\'ulgan kun tabriklari'),
    Category(category: 'Yaqinlar tug\'ulgan kuni tabriklari'),
    Category(category: 'Juma kun tabriklari'),
    Category(category: '8 - mart tabriklari'),
    Category(category: 'Ramazon oyi tabriklari'),
    Category(category: 'Qurbon Hayit bayrami tabriklari'),
    Category(category: 'Sevishganlar uchun'),
    Category(category: 'Dost xaqida to\'rtliklar'),
    Category(category: '14 - yanvar uchun tabriklar'),
    Category(category: 'Qizlar ismiga sherlar'),
    Category(category: 'O\'qituvchilar kuniga sherlar'),
  ];

  List<Category> get categories => _categories;
}
