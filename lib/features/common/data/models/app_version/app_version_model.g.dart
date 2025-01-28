// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_version_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppVersionModel _$AppVersionModelFromJson(Map<String, dynamic> json) =>
    AppVersionModel(
      required: json['required'] as bool? ?? false,
      version: json['version'] as String? ?? "",
      deviceType: json['device_type'] as String? ?? "",
    );

Map<String, dynamic> _$AppVersionModelToJson(AppVersionModel instance) =>
    <String, dynamic>{
      'version': instance.version,
      'device_type': instance.deviceType,
      'required': instance.required,
    };
