class PostViewModel {
  final int id;
  final String? mediaType;
  final String? mediaUrl;
  final String? content;
  final int? likesCount;
  final int? dislikesCount;
  final List<dynamic> comments;

  // الخصائص الجديدة
  final String? userImage;
  final String? userName;
  final DateTime? createdAt;
  final List<String> images;

  PostViewModel({
    required this.id,
    this.mediaType,
    this.mediaUrl,
    this.content,
    this.likesCount,
    this.dislikesCount,
    required this.comments,
    this.userImage,
    this.userName,
    this.createdAt,
    this.images = const [],
  });

  String get createdAtFormatted {
    if (createdAt == null) return 'منذ قليل';
    final difference = DateTime.now().difference(createdAt!);
    if (difference.inMinutes < 1) return 'الآن';
    if (difference.inHours < 1) return '${difference.inMinutes} دقيقة';
    if (difference.inDays < 1) return '${difference.inHours} ساعة';
    return '${difference.inDays} يوم';
  }

  factory PostViewModel.fromJson(Map<String, dynamic> json) {
    return PostViewModel(
      id: json['id'] ?? 0,
      mediaType: json['media_type'],
      mediaUrl: json['media_url'],
      content: json['content'],
      likesCount: json['likes_count'] ?? 0,
      dislikesCount: json['dislikes_count'] ?? 0,
      comments: json['comments'] ?? [],
      userImage: json['user'] != null ? json['user']['image'] : null,
      userName: json['user'] != null ? json['user']['name'] : null,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      images: (json['images'] as List?)?.map((e) => e.toString()).toList() ?? [],
    );
  }

}
