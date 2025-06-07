class StoryMediaModel {
  final String url;
  final String type;

  StoryMediaModel({
    required this.url,
    required this.type,
  });

  factory StoryMediaModel.fromJson(Map<String, dynamic> json) {
    return StoryMediaModel(
      url: json['url'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() => {
    'url': url,
    'type': type,
  };
}
