import 'package:final_senior_project/models/deputy_model/story_media_model.dart';

class StoryModel {
  final String name;
  final String image;
  final List<StoryMediaModel> mediaList;
  bool isViewed;

  StoryModel({
    required this.name,
    required this.image,
    required this.mediaList,
    this.isViewed = false,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      name: json['name'],
      image: json['image'],
      mediaList: (json['mediaList'] as List)
          .map((e) => StoryMediaModel.fromJson(e))
          .toList(),
      isViewed: json['isViewed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'image': image,
    'mediaList': mediaList.map((e) => e.toJson()).toList(),
    'isViewed': isViewed,
  };

  String get mediaUrl => mediaList.isNotEmpty ? mediaList.first.url : image;
  String get userName => name;
}
