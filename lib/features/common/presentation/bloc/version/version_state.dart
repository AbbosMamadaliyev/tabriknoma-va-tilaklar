part of 'version_bloc.dart';

class VersionState extends Equatable {
  final AppVersionEntity appVersion;
  final bool isRamadanMonth;

  const VersionState({
    this.appVersion = const AppVersionEntity(),
    this.isRamadanMonth = false,
  });

  VersionState copyWith({
    AppVersionEntity? appVersion,
    bool? isRamadanMonth,
  }) {
    return VersionState(
      appVersion: appVersion ?? this.appVersion,
      isRamadanMonth: isRamadanMonth ?? this.isRamadanMonth,
    );
  }

  @override
  List<Object> get props => [
        appVersion,
        isRamadanMonth,
      ];
}
