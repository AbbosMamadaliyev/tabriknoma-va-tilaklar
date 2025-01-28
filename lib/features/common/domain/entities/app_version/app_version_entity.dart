import 'package:equatable/equatable.dart';

class AppVersionEntity extends Equatable {
  final String version;
  final String deviceType;
  final bool required;

  const AppVersionEntity({this.version = "", this.required = false, this.deviceType = ""});

  @override
  List<Object?> get props => [version, required, deviceType];
}
