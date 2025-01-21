import 'package:flutter/material.dart';
import 'package:tabriklar/features/common/no_connection.dart';
import 'package:tabriklar/features/common/splash_page.dart';
import 'package:tabriklar/features/main_screen/main_screen.dart';
import 'package:tabriklar/features/photos_page/category_photos.dart';
import 'package:tabriklar/features/photos_page/photos_page.dart';
import 'package:tabriklar/features/saved_content_page/reading_saved_content.dart';
import 'package:tabriklar/features/saved_content_page/saved_content_page.dart';
import 'package:tabriklar/features/write_content/write_content_page.dart';

import 'features/congratulations/congratulations_birthday_widget.dart';
import 'features/congratulations/content.dart';

abstract class MainNavigationNames {
  static const home = '/home';
  static const splash = '/splash';
  static const mainScreen = '/mainScreen';
  static const congratulations = '/congratulations';
  static const content = '/content';
  static const favourites = '/favourites';
  static const writing = '/writing';
  static const readingFavorite = '/reading_favorite';
  static const photos = '/photos';
  static const categoryPhotos = '/categoryPhotos';
  static const noConnection = '/noConnection';
  static const myApp = '/myApp';
}

class MainNavigation {
  String initialRoute() => MainNavigationNames.splash;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationNames.mainScreen: (context) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: const MainScreen(),
        ),
    MainNavigationNames.splash: (context) => const SplashPage(),
    MainNavigationNames.noConnection: (context) => const NoConnection(),
    MainNavigationNames.congratulations: (context) => const CongratulationsWidget(),
    MainNavigationNames.content: (context) => ContentBirthday(),
    MainNavigationNames.favourites: (context) => const SavedContentPage(),
    MainNavigationNames.writing: (context) => WriteContentPage(),
    MainNavigationNames.readingFavorite: (context) => const ReadingSavedContent(),
    MainNavigationNames.photos: (context) => const PhotosPage(),
    MainNavigationNames.categoryPhotos: (context) => const CategorPhotosWidget(),
  };
}
