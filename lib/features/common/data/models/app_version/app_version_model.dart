import 'package:json_annotation/json_annotation.dart';
import 'package:tabriklar/features/common/domain/entities/app_version/app_version_entity.dart';

part 'app_version_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AppVersionModel extends AppVersionEntity {
  const AppVersionModel({
    super.required,
    super.version,
    super.deviceType,
  });

  factory AppVersionModel.fromJson(Map<String, dynamic> data) => _$AppVersionModelFromJson(data);
}
