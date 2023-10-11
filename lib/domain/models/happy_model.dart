class CongratulationsModel {
  int? id;
  String content;
  int favourite;

  CongratulationsModel({required this.id, required this.content, required this.favourite});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'favourite': favourite,
    };
  }

  factory CongratulationsModel.fromJson(Map<String, dynamic> json) {
    return CongratulationsModel(
      id: json['id'],
      content: json['content'],
      favourite: json['favourite'],
    );
  }

  @override
  String toString() {
    return 'CongratulationsModel{id: $id, content: $content, favourite: $favourite}';
  }
}
