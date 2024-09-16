import 'dart:async';

class SavedStream {
  final StreamController<Map<int, bool>> _savedStreamController = StreamController<Map<int, bool>>.broadcast();
  Stream<Map<int, bool>> get stream => _savedStreamController.stream;
  StreamSink<Map<int, bool>> get sink => _savedStreamController.sink;
}