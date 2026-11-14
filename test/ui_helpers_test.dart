import 'package:flutter_test/flutter_test.dart';
import 'package:tabriklar/core/ui/app_ui.dart';
import 'package:tabriklar/core/ui/category_visuals.dart';

void main() {
  group('greetingPreview', () {
    test('skips leading emoji-only lines', () {
      const content = '🎁🌹🎁🌹\n🎁🌹🎁🌹\n\nОлмосдан БАХТ,\nТиллодан ТАХТ,\nЧинордек УМР,\nЁшликдек ДАВР,';
      expect(greetingPreview(content), 'Олмосдан БАХТ,\nТиллодан ТАХТ,\nЧинордек УМР,');
    });

    test('drops blank lines and keeps at most three lines', () {
      const content = 'ONA\n\nTavallud kun muborak.\n\nOnajonim ushbu kun.\n\nYo‘llaymiz Sizga tabrik,';
      expect(greetingPreview(content), 'ONA\nTavallud kun muborak.\nOnajonim ushbu kun.');
    });

    test('falls back to emoji when there are no words at all', () {
      expect(greetingPreview('🥳🌸🥳\n\n🌸🥳🌸'), '🥳🌸🥳\n🌸🥳🌸');
    });
  });

  group('normalizeForSearch', () {
    test('unifies Uzbek apostrophes and case', () {
      final a = normalizeForSearch("Tug'ilgan");
      expect(normalizeForSearch('tugʻilgan'), a);
      expect(normalizeForSearch('TUG‘ILGAN'), a);
      expect(normalizeForSearch('tug’ilgan'), a);
    });

    test('lower-cases Cyrillic', () {
      expect(normalizeForSearch('ОНАЖОН'), 'онажон');
    });
  });

  group('CategoryVisuals.suggestionFor', () {
    test('suggests Juma on Fridays', () {
      expect(CategoryVisuals.suggestionFor(DateTime(2026, 11, 13)), 2); // Friday
    });

    test('no suggestion on an ordinary weekday', () {
      expect(CategoryVisuals.suggestionFor(DateTime(2026, 11, 12)), isNull); // Thursday
    });

    test('fixed holidays beat Friday', () {
      expect(CategoryVisuals.suggestionFor(DateTime(2024, 3, 8)), 3); // 8-mart, a Friday
      expect(CategoryVisuals.suggestionFor(DateTime(2027, 1, 14)), 8);
      expect(CategoryVisuals.suggestionFor(DateTime(2027, 2, 14)), 6);
      expect(CategoryVisuals.suggestionFor(DateTime(2027, 10, 1)), 10);
      expect(CategoryVisuals.suggestionFor(DateTime(2027, 9, 28)), 10);
    });

    test('every category has an icon', () {
      for (var i = 0; i < 11; i++) {
        expect(CategoryVisuals.icon(i), isNotNull);
      }
    });
  });
}
