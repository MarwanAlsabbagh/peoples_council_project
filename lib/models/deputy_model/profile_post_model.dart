class ProfilePostModel {
  final int id;
  final String? content;
  final String? mediaUrl;
  final String? mediaType;
  final DateTime createdAt;
  final int likesCount;
  final int dislikesCount;
  final List<dynamic> comments;

  ProfilePostModel({
    required this.id,
    this.content,
    this.mediaUrl,
    this.mediaType,
    required this.createdAt,
    required this.likesCount,
    required this.dislikesCount,
    required this.comments,
  });

  factory ProfilePostModel.fromJson(Map<String, dynamic> json) {
    return ProfilePostModel(
      id: json['id'],
      content: json['content'],
      mediaUrl: json['media_url'],
      mediaType: json['media_type'],
      createdAt: DateTime.parse(json['created_at']),
      likesCount: json['likes_count'] ?? 0,
      dislikesCount: json['dislikes_count'] ?? 0,
      comments: json['comments'] ?? [],
    );
  }
}
