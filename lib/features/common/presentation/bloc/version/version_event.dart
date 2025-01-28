part of 'version_bloc.dart';

sealed class VersionEvent {
  const VersionEvent();
}

class RemoteConfigUpdateEvent extends VersionEvent {
  const RemoteConfigUpdateEvent();
}
