class PhotoModel {
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  PhotoModel({this.id, this.title, this.url, this.thumbnailUrl});

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'title': String title,
        'url': String url,
        'thumbnailUrl': String thumbnailUrl,
      } =>
        PhotoModel(
          id: id,
          title: title,
          url: url,
          thumbnailUrl: thumbnailUrl,
        ),
      _ => throw const FormatException('Failed to load'),
    };
  }
}
