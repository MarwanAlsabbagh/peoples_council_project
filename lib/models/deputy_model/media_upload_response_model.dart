class MediaUploadResponseModel {
  final String url;

  MediaUploadResponseModel({required this.url});

  factory MediaUploadResponseModel.fromJson(Map<String, dynamic> json) {
    return MediaUploadResponseModel(
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() => {
    'url': url,
  };
}
