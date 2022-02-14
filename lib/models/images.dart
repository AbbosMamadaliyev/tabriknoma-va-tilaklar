class Images {
  final int index;

  Images({required this.index});

  factory Images.fromRtDb(Map<String, dynamic> data) {
    return Images(
      index: data['index'] ?? 1,
    );
  }
}
