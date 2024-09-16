import 'package:tabriklar/assets/constants/app_icons.dart';

enum AppLang {
  uzbek(title: 'uz'),
  russian(title: 'ru'),
  english(title: 'en');

  const AppLang({required this.title});

  final String title;

  bool get isUzbek => this == AppLang.uzbek;
  bool get isRussian => this == AppLang.russian;
  bool get isEnglish => this == AppLang.english;
}

enum LocationPermissionStatus {
  locationServiceDisabled,
  permissionDenied,
  permissionGranted;

  bool get isLocationServiceDisabled => this == LocationPermissionStatus.locationServiceDisabled;
  bool get isPermissionDenied => this == LocationPermissionStatus.permissionDenied;
  bool get isPermissionGranted => this == LocationPermissionStatus.permissionGranted;
}

enum PopUpStatus {
  failure(AppIcons.failure),
  success(AppIcons.success),
  warning(AppIcons.failure);

  final String icon;
  const PopUpStatus(this.icon);
  bool get isFailure => this == PopUpStatus.failure;
  bool get isSuccess => this == PopUpStatus.success;
  bool get isWarning => this == PopUpStatus.warning;
}
