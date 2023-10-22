import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ImageListProvider extends ChangeNotifier {
  final dataBase = FirebaseDatabase.instance.ref();
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  List _isActiveBtn = [];

  List get isActiveBtn => _isActiveBtn;

  List _imageLinkList = [];

  List get imageLinkList => _imageLinkList;

  final _defaultLink =
      'https://firebasestorage.googleapis.com/v0/b/tabrik-va-tilaklar.appspot.com/o/aralash%2F1ef4ac809937c4935ce06938dcf29cc9.jpg?alt=media&token=bb8fa2ae-a7e1-4422-a009-d9f1ea6a2af2';

  get defaultLink => _defaultLink;

  void getDataFromRtDb(int cardId) {
    String category = 'aralash';
    switch (cardId) {
      case 1:
        category = 'happy_birthday';
        break;
      case 2:
        category = 'juma';
        break;
      case 3:
        category = 'aralash';
        break;
    }
    try {
      _isLoading = true;
      notifyListeners();
      dataBase.child(category).onValue.listen((event) {
        var list = event.snapshot.value as List;
        _imageLinkList = list;
        _imageLinkList.shuffle();
        _isActiveBtn = List.filled(_imageLinkList.length, false, growable: true);
        _isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      print('firebase error: $e');
    }
  }

  shareImage(String imageLink, int index) async {
    _isActiveBtn[index] = true;
    notifyListeners();

    try {
      var url = imageLink;
      print('imageLink: $imageLink');
      var response = await get(Uri.parse(url));
      final Uint8List list = response.bodyBytes;

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/img$index.jpg').create();
      file.writeAsBytesSync(list);

      Share.shareFiles([file.path]);
      notifyListeners();
    } catch (e) {
      print('Share error: $e');
    }
    _isActiveBtn[index] = false;
    notifyListeners();
  }
}
