import 'package:flutter/material.dart';

/// Icon for each greeting category. Index matches
/// `DbTableModelProvider.dbTables` / `CategoryModelProvider.categories`.
abstract class CategoryVisuals {
  static const List<IconData> _icons = [
    Icons.cake_rounded, // 0  birthday
    Icons.family_restroom_rounded, // 1  family birthday
    Icons.mosque_rounded, // 2  juma
    Icons.local_florist_rounded, // 3  8 march
    Icons.nightlight_round, // 4  ramadan
    Icons.celebration_rounded, // 5  qurbon hayit
    Icons.favorite_rounded, // 6  lovers
    Icons.handshake_rounded, // 7  friends
    Icons.shield_rounded, // 8  14 january
    Icons.spa_rounded, // 9  girls' names
    Icons.school_rounded, // 10 teachers
  ];

  static IconData icon(int index) => index >= 0 && index < _icons.length ? _icons[index] : Icons.article_rounded;

  /// Category worth suggesting today, or null.
  /// Fixed-date holidays win over the weekly Friday suggestion.
  static int? suggestionFor(DateTime now) {
    final m = now.month, d = now.day;
    if (m == 3 && d >= 1 && d <= 8) return 3; // 8-mart
    if (m == 1 && d >= 10 && d <= 14) return 8; // 14-yanvar
    if (m == 2 && d >= 8 && d <= 14) return 6; // 14-fevral
    if ((m == 9 && d >= 25) || (m == 10 && d == 1)) return 10; // 1-oktabr, O'qituvchilar kuni
    if (now.weekday == DateTime.friday) return 2; // Juma
    return null;
  }
}
