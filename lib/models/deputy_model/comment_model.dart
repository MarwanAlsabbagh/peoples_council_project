class CommentModel {
  final int id;
  final int userId;
  final String userName;
  final String content;
  final String createdAt;

  CommentModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.content,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      userId: json['user_id'],
      userName: json['user_name'],
      content: json['content'],
      createdAt: json['created_at'],
    );
  }
}
