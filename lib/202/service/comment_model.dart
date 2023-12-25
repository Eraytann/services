class CommentModel {
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  CommentModel({this.postId, this.id, this.name, this.body, this.email});

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'postId': int postId,
        'id': int id,
        'name': String name,
        'email': String email,
        'body': String body
      } =>
        CommentModel(
          postId: postId,
          id: id,
          name: name,
          email: email,
          body: body,
        ),
      _ => throw const FormatException('Failed to load'),
    };
  }
}
