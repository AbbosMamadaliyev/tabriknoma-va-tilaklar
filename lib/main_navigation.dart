import 'package:flutter/material.dart';
import 'package:tabriklar/my_app.dart';
import 'package:tabriklar/widgets/main_screen/main_screen.dart';
import 'package:tabriklar/widgets/no_connection.dart';
import 'package:tabriklar/widgets/photos_page/category_photos.dart';
import 'package:tabriklar/widgets/photos_page/photos_page.dart';
import 'package:tabriklar/widgets/saved_content_page/reading_saved_content.dart';
import 'package:tabriklar/widgets/saved_content_page/saved_content_page.dart';
import 'package:tabriklar/widgets/write_content/write_content_page.dart';

import 'widgets/congratulations/congratulations_birthday_widget.dart';
import 'widgets/congratulations/content.dart';

abstract class MainNavigationNames {
  static const home = '/home';
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
  String initialRoute(bool connectivityX) => connectivityX
      ? MainNavigationNames.mainScreen
      : MainNavigationNames.noConnection;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationNames.mainScreen: (context) => const MainScreen(),
    MainNavigationNames.noConnection: (context) => const NoConnection(),
    MainNavigationNames.congratulations: (context) =>
        const CongratulationsWidget(),
    MainNavigationNames.content: (context) => ContentBirthday(),
    MainNavigationNames.favourites: (context) => const SavedContentPage(),
    MainNavigationNames.writing: (context) => WriteContentPage(),
    MainNavigationNames.readingFavorite: (context) =>
        const ReadingSavedContent(),
    MainNavigationNames.photos: (context) => const PhotosPage(),
    MainNavigationNames.categoryPhotos: (context) =>
        const CategorPhotosWidget(),
  };
}
