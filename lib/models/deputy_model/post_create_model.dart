class PostCreateModel {
  final String? content;    // نص المنشور (اختياري)
  final String? mediaPath;  // مسار ملف الصورة أو الفيديو (اختياري)

  PostCreateModel({
    this.content,
    this.mediaPath,
  });

  Map<String, dynamic> toJson() {
    return {
      if (content != null && content!.isNotEmpty) 'content': content,
      // لا تضع media هنا لأنه في ملف multipart
    };
  }
}
