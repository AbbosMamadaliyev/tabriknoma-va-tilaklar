import 'package:flutter/material.dart';
import 'package:tabriklar/widgets/home_page/home_page.dart';
import 'package:tabriklar/widgets/saved_content_page/reading_saved_content.dart';
import 'package:tabriklar/widgets/saved_content_page/saved_content_page.dart';
import 'package:tabriklar/widgets/write_content/write_content_page.dart';

import 'widgets/congratulations/congratulations_birthday_widget.dart';
import 'widgets/congratulations/content.dart';

abstract class MainNavigationNames {
  static const home = '/home';
  static const congratulations = '/congratulations';
  static const content = '/content';
  static const favourites = '/favourites';
  static const writing = '/writing';
  static const readingFavorite = '/reading_favorite';
}

class MainNavigation {
  String initialRoute() => MainNavigationNames.home;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationNames.home: (context) => const HomePage(),
    MainNavigationNames.congratulations: (context) =>
        const CongratulationsWidget(),
    MainNavigationNames.content: (context) => ContentBirthday(),
    MainNavigationNames.favourites: (context) => const SavedContentPage(),
    MainNavigationNames.writing: (context) => WriteContentPage(),
    MainNavigationNames.readingFavorite: (context) => ReadingSavedContent(),
  };
}
