import 'member_model.dart';

class PartyPersonalModel {
  final String birthDate;
  final String birthPlace;
  final String education;
  final List<String> videoUrls;
  final List<Article> articles;
  bool ?isFollowed;
  final List<MemberModel> members;
  final MemberModel generalSecretary;


  PartyPersonalModel(
      {
        required this.birthDate,
        required this.birthPlace,
        required this.education,
        required this.videoUrls,
        required this.articles,
        required this.isFollowed,
        required this.members,
        required this.generalSecretary,

      });

  factory PartyPersonalModel.fromJson(Map<String, dynamic> json) {
    return PartyPersonalModel(
      birthDate: json['birth_date'] ?? '',
      birthPlace: json['birth_place'] ?? '',
      education: json['education'] ?? '',
      videoUrls: List<String>.from(json['videos'] ?? []),
      articles: (json['articles'] as List<dynamic>)
          .map((e) => Article.fromJson(e))
          .toList(),
      isFollowed: json['is_followed'] ?? false,
      members: (json['members'] as List<dynamic>)
          .map((e) => MemberModel.fromJson(e))
          .toList(),
      generalSecretary: MemberModel.fromJson(json['general_secretary']),

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
      image: json['image'] ?? '',
      title: json['title'] ?? '',
      date: json['date'] ?? '',
    );
  }
}
