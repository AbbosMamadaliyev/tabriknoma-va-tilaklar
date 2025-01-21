// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ru = {
  "choose_lang": "Выберите язык",
  "confirm": "Подтвердить"
};
static const Map<String,dynamic> en = {
  "choose_lang": "Choose language",
  "confirm": "Confirm"
};
static const Map<String,dynamic> uz = {
  "choose_lang": "Tilni tanlang",
  "confirm": "Tasdiqlash"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ru": ru, "en": en, "uz": uz};
}
