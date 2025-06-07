import '../../view/screen/after_ellection/articles_and_research.dart';
import 'parties_model.dart';

class CandidateModel {
  final int id;
  final String name;
  final int voteCount;
  final String birthDate;
  final String birthPlace;
  final String education;
  final String academicDegree;
  final String description;
  final String electoralProgram;
  final String? imagePath;
  final List<String> videoUrls;
  final List<Article> articles;
  final PartiesModel? party;

  CandidateModel({
    required this.id,
    required this.name,
    required this.voteCount,
    required this.birthDate,
    required this.birthPlace,
    required this.education,
    required this.academicDegree,
    required this.description,
    required this.electoralProgram,
    required this.imagePath,
    required this.videoUrls,
    required this.articles,
    this.party,
  });

  factory CandidateModel.fromJson(Map<String, dynamic> json) {
    final detail = json['detail'] ?? {};
    final partyJson = json['party'];
    final videos = json['videos'] as List<dynamic>? ?? [];

    return CandidateModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] ?? '',
      voteCount: int.tryParse(json['voteCount'].toString()) ?? 0,
      birthDate: detail['birth_date'] ?? '',
      birthPlace: detail['birth_place'] ?? '',
      education: detail['education'] ?? '',
      academicDegree: detail['academic_degree'] ?? '',
      description: detail['description'] ?? '',
      electoralProgram: detail['electoral_program'] ?? '',
      imagePath: detail['image'],
      videoUrls: videos
          .where((v) => v['video_path'] != null)
          .map((v) => v['video_path'] as String)
          .toList(),
      articles: (json['articles'] as List<dynamic>)
          .map((e) => Article.fromJson(e))
          .toList(),
      party: partyJson != null ? PartiesModel.fromJson(partyJson) : null,
    );
  }

}
class Article {
  final String image;
  final String title;
  final String date;

  Article({
    required this.image,
    required this.title,
    required this.date,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      image: json['image_path'] ?? '',
      title: json['title'] ?? '',
      date: json['created_at'] ?? '',
    );
  }

  // دالة toJson لتحويل كائن Article إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'image_path': image,
      'title': title,
      'created_at': date,
    };
  }
}

