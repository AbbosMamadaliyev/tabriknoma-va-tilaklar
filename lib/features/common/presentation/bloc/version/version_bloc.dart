import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:tabriklar/features/common/data/models/app_version/app_version_model.dart';
import 'package:tabriklar/features/common/domain/entities/app_version/app_version_entity.dart';

part 'version_event.dart';

part 'version_state.dart';

class VersionBloc extends Bloc<VersionEvent, VersionState> {
  final remoteConfig = FirebaseRemoteConfig.instance;

  VersionBloc() : super(const VersionState()) {
    setupRemoteConfig();

    on<RemoteConfigUpdateEvent>((event, emit) {
      print('remoteConfig.getAll(): ${remoteConfig.getAll().values.map((e) => e.asString()).toList().length}');

      final configString = remoteConfig.getString('app_update_check');
      final isRamadanMonth = remoteConfig.getBool('is_ramadan_month');
      emit(state.copyWith(isRamadanMonth: isRamadanMonth));

      if (configString.isNotEmpty) {
        final version = jsonDecode(remoteConfig.getString('app_update_check'));

        emit(state.copyWith(
          appVersion: AppVersionModel.fromJson(version),
        ));
      }
    });
  }

  Future<void> setupRemoteConfig() async {
    log("Remote config setup");
    remoteConfig.onConfigUpdated.listen((event) async {
      log("Remote config remoteConfig.onConfigUpdated.listen");
      await remoteConfig.activate();
      add(const RemoteConfigUpdateEvent());
    });
  }
}
