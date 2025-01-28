import 'package:flutter/cupertino.dart';
import 'package:tabriklar/domain/models/category_models.dart';

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

  final List<Category> _ruCategories = [
    Category(category: 'Поздравления с днем рождения'),
    Category(category: 'Поздравления с днем рождения близких'),
    Category(category: 'Поздравления с пятницей'),
    Category(category: '8 марта поздравления'),
    Category(category: 'Поздравления с месяцем Рамазан'),
    Category(category: 'Поздравления с праздником Курбан Хайт'),
    Category(category: 'Для влюбленных'),
    Category(category: 'Четверостишья о друге'),
    Category(category: 'Поздравления на 14 января'),
    Category(category: 'Стихи на имя девушки'),
    Category(category: 'Стихи на день учителя'),
  ];

  final List<Category> _enCategories = [
    Category(category: 'Birthday greetings'),
    Category(category: 'Birthday greetings to loved ones'),
    Category(category: 'Friday greetings'),
    Category(category: '8 March greetings'),
    Category(category: 'Ramadan month greetings'),
    Category(category: 'Kurban Hayit greetings'),
    Category(category: 'For lovers'),
    Category(category: 'Quatrains about a friend'),
    Category(category: 'Greetings for 14 January'),
    Category(category: 'Poems for girls\' names'),
    Category(category: 'Poems for teachers\' day'),
  ];

  List<Category> categories(String locale) {
    if (locale == 'uz') {
      return _categories;
    } else if (locale == 'ru') {
      return _ruCategories;
    } else {
      return _enCategories;
    }
  }
}
