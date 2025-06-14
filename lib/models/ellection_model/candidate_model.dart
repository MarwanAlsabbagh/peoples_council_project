import '../../utils/media_utils.dart';
import '../../view/screen/after_ellection/articles_and_research.dart';

class CandidatePartyModel {
  final int id;
  final String name;
  final String imageUrl;
  final String city;
  final String foundedAt;
  final int memberCount;

  CandidatePartyModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.city,
    required this.foundedAt,
    required this.memberCount,
  });

  factory CandidatePartyModel.fromJson(Map<String, dynamic> json) {
    return CandidatePartyModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: (json['name'] ?? '').toString().replaceAll('"', ''),
      imageUrl: json['image'] != null ? getFullMediaUrl(json['image']) : '',
      city: (json['city'] ?? '').toString().replaceAll('"', ''),
      foundedAt: (json['founded_at'] ?? '').toString(),
      memberCount: int.tryParse(json['member_count'].toString()) ?? 0,
    );
  }
}

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
  final String imagePath;
  final List<String> videoUrls;
  final List<Article> articles;
  final CandidatePartyModel? party;

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
    final articlesJson = json['articles'] as List<dynamic>? ?? [];

    return CandidateModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: (json['name'] ?? '').toString().replaceAll('"', ''),
      voteCount: int.tryParse(json['voteCount'].toString()) ?? 0,
      birthDate: (detail['birth_date'] ?? '').toString().replaceAll('"', ''),
      birthPlace: (detail['birth_place'] ?? '').toString().replaceAll('"', ''),
      education: (detail['education'] ?? '').toString().replaceAll('"', ''),
      academicDegree: (detail['academic_degree'] ?? '').toString().replaceAll('"', ''),
      description: (detail['description'] ?? '').toString().replaceAll('"', ''),
      electoralProgram: (detail['electoral_program'] ?? '').toString().replaceAll('"', ''),
      imagePath: detail['image'] != null ? getFullMediaUrl(detail['image']) : '',
      videoUrls: videos
          .where((v) => v['video_path'] != null)
          .map((v) => getFullMediaUrl(v['video_path'].toString()))
          .toList(),
      articles: articlesJson.map((e) => Article.fromJson(e)).toList(),
      party: partyJson != null ? CandidatePartyModel.fromJson(partyJson) : null,
    );
  }
}
class Article {
  final String image;
  final String title;
  final String date;
  final String pdfPath;

  Article({
    required this.image,
    required this.title,
    required this.date,
    required this.pdfPath,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      image: getFullMediaUrl(json['image_path'] ?? ''),
      pdfPath: getFullMediaUrl(json['pdf_path'] ?? ''),
      date: formatDate(json['created_at']),
    );
  }

}
String formatDate(String isoDate) {
  try {
    final dateTime = DateTime.parse(isoDate);
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  } catch (e) {
    return isoDate;
  }
}
