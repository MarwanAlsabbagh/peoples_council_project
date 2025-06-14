class PostViewModel {
  final int id;
  final String? mediaType;
  final String? mediaPath;
  final String? content;
  final int likes;
  final int dislikes;
  final int commentsCount;

  final String? userImage;
  final String? userName;
  final DateTime? createdAt;

  PostViewModel({
    required this.id,
    this.mediaType,
    this.mediaPath,
    this.content,
    this.likes = 0,
    this.dislikes = 0,
    this.commentsCount = 0,
    this.userImage,
    this.userName,
    this.createdAt,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'media_type': mediaType,
      'media_path': mediaPath?.replaceFirst('storage/', ''),
      'content': content,
      'likes': likes,
      'dislikes': dislikes,
      'comments_count': commentsCount,
      'owner_image': userImage,
      'owner_name': userName,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  String get createdAtFormatted {
    if (createdAt == null) return '';
    return "${createdAt!.year}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')} "
        "${createdAt!.hour.toString().padLeft(2, '0')}:${createdAt!.minute.toString().padLeft(2, '0')}";
  }
  factory PostViewModel.fromJson(Map<String, dynamic> json) {
    return PostViewModel(
      id: json['id'] ?? 0,
      mediaType: json['media_type'],
      mediaPath: _normalizePath("storage/${json['media_path']}"),
      content: json['content'],
      likes: json['likes'] ?? 0,
      dislikes: json['dislikes'] ?? 0,
      commentsCount: json['comments_count'] ?? 0,
      userImage: _normalizePath(json['owner_image']),
      userName: json['owner_name'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
    );
  }
  static String? _normalizePath(String? path) {
    if (path == null || path.isEmpty) return null;
    return path.startsWith('/') ? path : path;
  }

}
