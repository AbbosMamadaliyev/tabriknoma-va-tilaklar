import 'dart:async';

import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tabriklar/assets/constants/app_constants.dart';
import 'package:tabriklar/core/data/singletons/storage.dart';

abstract class MyFunctions {
  static Future<bool> needToUpdate(String newVersion) async {
    final isValidNumber = isValidVersionNumber(newVersion);
    if (!isValidNumber) {
      return false;
    }
    final isGreater = await isNewVersionGreater(newVersion);
    return isGreater;
  }

  static bool isValidVersionNumber(String newVersion) => RegExp('^[0-9].[0-9].[0-9]').hasMatch(newVersion);

  static Future<bool> isNewVersionGreater(String newVersion) async {
    final cV = await currentVersionAsync;
    final newVersionList = newVersion.split('.');
    final currentVersionList = cV.split('.');
    for (int i = 0; i < newVersionList.length; i++) {
      if (int.parse(newVersionList[i]) > int.parse(currentVersionList[i])) {
        return true;
      }
    }
    return false;
  }

  static Future<String> get currentVersionAsync async {
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version;
    await StorageRepository.putString(StorageKeys.currentAppVersion, currentVersion);
    return currentVersion;
  }

  static String formatDoubleNumber(String doubleNumber) {
    double number = double.tryParse(doubleNumber) ?? 0;
    int numberInt = number.floor();
    double numberDouble = number - numberInt;
    String numberDoubleString = numberDouble.toString();
    if (numberDoubleString.length > 5) {
      return "${formatNumber(numberInt.toString())}.${numberDoubleString.substring(2, 5)}";
    } else {
      return "${formatNumber(numberInt.toString())}.0";
    }
  }

  static String formatNumber(String number) {
    // Remove spaces and dots from the input string
    final cleanedNumber = number.replaceAll(' ', '').split('.').first;

    // Reverse the cleaned string to format it more easily
    final reversedNumber = cleanedNumber.split('').reversed.join();

    String formatted = '';
    for (int i = 0; i < reversedNumber.length; i++) {
      if (i > 0 && i % 3 == 0) {
        formatted = ' $formatted';
      }
      formatted = reversedNumber[i] + formatted;
    }

    return formatted;
  }

  static String formatDateFromApi(
    String date, {
    String? format = 'dd.MM.yyyy',
    bool withTime = false,
    required String locale,
  }) {
    try {
      DateTime dateTime;
      if (date.isNotEmpty) {
        dateTime = DateTime.parse(date);
      } else {
        dateTime = DateTime.now();
      }
      if (!withTime) {
        return DateFormat(format, locale).format(dateTime);
      } else {
        return DateFormat("$format, HH:mm", locale).format(dateTime);
      }
    } catch (e) {
      return date;
    }
  }

  static String phoneFormatter(String content, List<int> stopsList) {
    final buffer = StringBuffer();
    for (int i = 0; i < content.length; i++) {
      if (stopsList.contains(i + 1)) {
        buffer.write(' ');
      }
      buffer.write(content[i]);
    }
    return buffer.toString();
  }

  static Future<PermissionStatus> getCameraPermission(bool platformIsAndroid) async {
    if (platformIsAndroid) {
      var permission = await Permission.camera.status;
      if (!permission.isGranted) {
        permission = await Permission.camera.request();
      }
      return permission;
    }
    return PermissionStatus.granted;
  }

  static String getMonthName(int index) {
    switch (index) {
      case 1:
        return 'Январь';
      case 2:
        return 'Февраль';
      case 3:
        return 'Март';
      case 4:
        return 'Апрель';
      case 5:
        return 'Май';
      case 6:
        return 'Июнь';
      case 7:
        return 'Июль';
      case 8:
        return 'Август';
      case 9:
        return 'Сентябрь';
      case 10:
        return 'Октябрь';
      case 11:
        return 'Ноябрь';
      case 12:
        return 'Декабрь';
      default:
        return '';
    }
  }

  static String getFormatCost(String cost) {
    if (cost.isEmpty) return '';
    var oldCost = cost;
    if (cost.contains('.')) {
      final arr = cost.split('.');
      oldCost = arr.first;
    }
    var newCost = '';
    for (var i = 0; i < oldCost.length; i++) {
      if ((oldCost.length - i) % 3 == 0) newCost += ' ';
      newCost += oldCost[i];
    }
    return newCost.trimLeft();
  }

  static String iftarTime() {
    int today = DateTime.now().day;
    String iftarTime = RamadanTimes.iftar[today] ?? '';

    return iftarTime;
  }

  static String suhoorTime() {
    int today = DateTime.now().day;
    String suhoorTime = RamadanTimes.suhoor[today] ?? '';

    return suhoorTime;
  }
}
