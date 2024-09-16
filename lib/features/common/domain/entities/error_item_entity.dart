import 'package:json_annotation/json_annotation.dart';
import 'package:tabriklar/features/common/data/models/error_item_model.dart';

class ErrorItemEntity {
  final String code;
  final String detail;

  const ErrorItemEntity({
    this.code = '',
    this.detail = '',
  });
}

class ErrorItemConverter implements JsonConverter<ErrorItemEntity, Map<String, dynamic>?> {
  const ErrorItemConverter();
  @override
  ErrorItemEntity fromJson(Map<String, dynamic>? json) => ErrorItemModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(ErrorItemEntity object) => {};
}
