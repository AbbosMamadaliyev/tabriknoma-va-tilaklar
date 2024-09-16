import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'deep_link_event.dart';
part 'deep_link_state.dart';

class DeepLinkBloc extends Bloc<DeepLinkEvent, DeepLinkState> {
  static const dlStream = EventChannel('https://xolodilnik.uz/event');

  static const platform = MethodChannel('https://xolodilnik.uz/channel');

  final StreamController<String> _stateController = StreamController();

  Stream<String> get dlState => _stateController.stream;

  Sink<String> get stateSink => _stateController.sink;

  DeepLinkBloc() : super(DeepLinkInitState()) {
    startUri().then(_onRedirected);
    dlStream.receiveBroadcastStream().listen((d) => _onRedirected(d));

    on<DeepLinkChanged>((event, emit) async {
      String? parsedSlug;
      log('=====>> event.uri: ${event.uri}');
      if (event.uri.contains('https://xolodilnik.uz')) {
        parsedSlug = event.uri.replaceAll('https://xolodilnik.uz', '');
        final List<String> pathParams = parsedSlug.split('/');
        final firstParam = pathParams.first;
        final lastParam = pathParams.last;
        log('=====>> firstParam: $firstParam');
        log('=====>> lastParam: $lastParam');

        if (parsedSlug.contains('product')) {
          String slug = lastParam;

          emit(ProductLinkTriggeredWithSlug(slug: slug));
        } else {
          emit(PaymentTriggered());
        }
      }
    });
    on<GetNewsDetails>((event, emit) async {});
  }

  void _onRedirected(String uri) {
    print('uriuriuri deeplink');
    add(DeepLinkChanged(uri: uri));
    stateSink.add(uri);
  }

  Future<String> startUri() async {
    try {
      final link = await platform.invokeMethod('deeplink');
      add(DeepLinkChanged(uri: link));
      return link;
    } on PlatformException catch (e) {
      return "Failed to Invoke: '${e.message}'.";
    }
  }

  void dispose() {
    _stateController.close();
  }
}
