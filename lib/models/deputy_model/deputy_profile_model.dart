import 'package:final_senior_project/models/deputy_model/party_model.dart';
import 'package:final_senior_project/models/deputy_model/post_view_model.dart';

class DeputyProfileModel {
  final int id;
  final String name;
  final String image;
  final String governorate;
  final String category;
  final String description;
  final String birthDate;
  final String birthPlace;
  final String education;
  final String academicDegree;
  final String electoralProgram;
  final PartyModel party;
  final List<PostViewModel> posts;
  final int postsCount;
  final int totalLikes;
  final int totalDislikes;

  DeputyProfileModel({
    required this.id,
    required this.name,
    required this.image,
    required this.governorate,
    required this.category,
    required this.description,
    required this.birthDate,
    required this.birthPlace,
    required this.education,
    required this.academicDegree,
    required this.electoralProgram,
    required this.party,
    required this.posts,
    required this.postsCount,
    required this.totalLikes,
    required this.totalDislikes,
  });

  factory DeputyProfileModel.fromJson(Map<String, dynamic> json) {
    return DeputyProfileModel(
      id: json['id'],
      name: json['name'],
      image: json['detail']['image'] ?? '',
      governorate: json['detail']['governorate'] ?? '',
      category: json['detail']['category'] ?? '',
      description: json['detail']['description'] ?? '',
      birthDate: json['detail']['birth_date'] ?? '',
      birthPlace: json['detail']['birth_place'] ?? '',
      education: json['detail']['education'] ?? '',
      academicDegree: json['detail']['academic_degree'] ?? '',
      electoralProgram: json['detail']['electoral_program'] ?? '',
      party: PartyModel.fromJson(json['party']),
      posts: (json['posts'] as List).map((p) => PostViewModel.fromJson(p)).toList(),
      postsCount: json['posts_count'] ?? 0,
      totalLikes: json['total_likes'] ?? 0,
      totalDislikes: json['total_dislikes'] ?? 0,
    );
  }

  static DeputyProfileModel empty() {
    return DeputyProfileModel(
      id: 0,
      name: '',
      image: '',
      governorate: '',
      category: '',
      description: '',
      birthDate: '',
      birthPlace: '',
      education: '',
      academicDegree: '',
      electoralProgram: '',
      party: PartyModel.empty(),
      posts: [],
      postsCount: 0,
      totalLikes: 0,
      totalDislikes: 0,
    );
  }

  DeputyProfileModel copyWith({
    int? id,
    String? name,
    String? image,
    String? governorate,
    String? category,
    String? description,
    String? birthDate,
    String? birthPlace,
    String? education,
    String? academicDegree,
    String? electoralProgram,
    PartyModel? party,
    List<PostViewModel>? posts,
    int? postsCount,
    int? totalLikes,
    int? totalDislikes,
  }) {
    return DeputyProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      governorate: governorate ?? this.governorate,
      category: category ?? this.category,
      description: description ?? this.description,
      birthDate: birthDate ?? this.birthDate,
      birthPlace: birthPlace ?? this.birthPlace,
      education: education ?? this.education,
      academicDegree: academicDegree ?? this.academicDegree,
      electoralProgram: electoralProgram ?? this.electoralProgram,
      party: party ?? this.party,
      posts: posts ?? this.posts,
      postsCount: postsCount ?? this.postsCount,
      totalLikes: totalLikes ?? this.totalLikes,
      totalDislikes: totalDislikes ?? this.totalDislikes,
    );
  }
}
