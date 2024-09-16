import 'package:json_annotation/json_annotation.dart';
import 'package:tabriklar/features/common/domain/entities/error_item_entity.dart';

part 'error_item_model.g.dart';

@JsonSerializable(createToJson: false)
class ErrorItemModel extends ErrorItemEntity {
  const ErrorItemModel({required super.code, required super.detail});
  factory ErrorItemModel.fromJson(Map<String, dynamic> json) => _$ErrorItemModelFromJson(json);
}
