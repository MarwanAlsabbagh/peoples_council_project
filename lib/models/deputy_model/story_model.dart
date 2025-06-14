class StoryModel {
  final int id;
  final String content;
  final String mediaType;
  final String mediaPath; // فقط المسار النسبي هنا
  final DateTime expiresAt;
  final bool isExpired;
  final String ownerName;
  final String ownerImage;
  bool isViewed;

  StoryModel({
    required this.id,
    required this.content,
    required this.mediaType,
    required this.mediaPath,
    required this.expiresAt,
    required this.isExpired,
    required this.ownerName,
    required this.ownerImage,
    this.isViewed = false,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      id: json['id'] ?? 0,
      content: json['content'] ?? '',
      mediaType: (json['media_type'] as String?)?.toLowerCase() ?? 'text',
      mediaPath: json['media_path'] ?? '',
      expiresAt: DateTime.tryParse(json['expires_at'] ?? '') ?? DateTime.now().add(const Duration(hours: 24)),
      isExpired: json['is_expired'] ?? false,
      ownerName: (json['owner_name'] ?? 'مستخدم').toString().replaceAll('"', ''),
      ownerImage: json['owner_image'] ?? '',
      isViewed: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'media_type': mediaType,
      'media_path': mediaPath,
      'expires_at': expiresAt.toIso8601String(),
      'is_expired': isExpired,
      'owner_name': ownerName,
      'owner_image': ownerImage,
      'is_viewed': isViewed,
    };
  }
}
