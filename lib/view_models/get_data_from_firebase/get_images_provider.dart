import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tabriklar/utils/analytics_service.dart';

/// Greeting pictures bundled with the app under `assets/photos/<category>/`.
///
/// They used to come from Firebase Storage; now every image ships inside the
/// app, so the feed works offline. To add pictures, drop JPEGs into the
/// category folder — they are picked up from the asset manifest automatically.
class ImageListProvider extends ChangeNotifier {
  static const _root = 'assets/photos';

  /// Card index on the photos screen (1-based) → asset folder.
  static const Map<int, String> categoryFolders = {
    1: 'birthday',
    2: 'juma',
    3: 'aralash',
  };

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  List<bool> _isActiveBtn = [];

  List<bool> get isActiveBtn => _isActiveBtn;

  List<String> _imageLinkList = [];

  /// Asset paths of the currently opened category.
  List<String> get imageLinkList => _imageLinkList;

  int _request = 0;

  Future<void> loadCategory(int cardId) async {
    final request = ++_request;
    final folder = categoryFolders[cardId] ?? 'aralash';
    _isLoading = true;
    _imageLinkList = [];
    notifyListeners();

    List<String> images = [];
    try {
      final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
      images = manifest
          .listAssets()
          .where((path) => path.startsWith('$_root/$folder/') && _isImage(path))
          .toList()
        ..shuffle();
    } catch (e) {
      debugPrint('photo assets error: $e');
    }

    // A newer category was opened while this one was loading.
    if (request != _request) return;
    _imageLinkList = images;
    _isActiveBtn = List.filled(images.length, false, growable: true);
    _isLoading = false;
    notifyListeners();
  }

  static bool _isImage(String path) {
    final p = path.toLowerCase();
    return p.endsWith('.jpg') || p.endsWith('.jpeg') || p.endsWith('.png') || p.endsWith('.webp');
  }

  Future<void> shareImage(String assetPath, int index) async {
    if (index >= _isActiveBtn.length) return;
    _isActiveBtn[index] = true;
    notifyListeners();

    try {
      final data = await rootBundle.load(assetPath);
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/${assetPath.split('/').last}');
      await file.writeAsBytes(data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes), flush: true);

      Share.shareXFiles(
        [XFile(file.path)],
        text: 'Tabrik va tilaklar',
        subject: 'Tabrik va tilaklar',
      ).then((result) {
        if (result.status == ShareResultStatus.success) {
          AnalyticsService.logEvent(name: AnalyticsKeys.sendContent);
        }
      });
    } catch (e) {
      debugPrint('Share error: $e');
    }

    if (index < _isActiveBtn.length) {
      _isActiveBtn[index] = false;
      notifyListeners();
    }
  }
}
