part of 'version_bloc.dart';

class VersionState extends Equatable {
  final AppVersionEntity appVersion;

  const VersionState({
    this.appVersion = const AppVersionEntity(),
  });

  VersionState copyWith({
    AppVersionEntity? appVersion,
  }) {
    return VersionState(
      appVersion: appVersion ?? this.appVersion,
    );
  }

  @override
  List<Object> get props => [appVersion];
}
