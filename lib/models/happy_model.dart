class HappyBirthdayModel {
  int? id;
  String content;
  int favourite;

  HappyBirthdayModel(
      {required this.id, required this.content, required this.favourite});

  // static String tableName = 'happy';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'favourite': favourite,
    };
  }

  factory HappyBirthdayModel.fromJson(Map<String, dynamic> json) {
    return HappyBirthdayModel(
      id: json['id'],
      content: json['content'],
      favourite: json['favourite'],
    );
  }
}
