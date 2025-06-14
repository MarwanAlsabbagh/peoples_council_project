class PartyPersonalModel {
  final int id;
  final String name;
  final String image;
  final String city;
  final String foundedAt;
  final int membersCount;
  final List<PartyCandidate> candidates;

  PartyPersonalModel({
    required this.id,
    required this.name,
    required this.image,
    required this.city,
    required this.foundedAt,
    required this.membersCount,
    required this.candidates,
  });

  factory PartyPersonalModel.fromNewApi(Map<String, dynamic> json) {
    final party = json['party'];
    final candidatesList = json['candidates'] as List<dynamic>;
    return PartyPersonalModel(
      id: party['id'],
      name: party['name'],
      image: party['image'],
      city: party['city'],
      foundedAt: party['founded_at'],
      membersCount: party['members_count'],
      candidates: candidatesList.map((c) => PartyCandidate.fromJson(c)).toList(),
    );
  }
}

class PartyCandidate {
  final int id;
  final String name;
  final int voteCount;
  final String image;
  final String governorate;
  final String category;
  final String description;
  final String birthDate;
  final String birthPlace;
  final String education;
  final String academicDegree;

  PartyCandidate({
    required this.id,
    required this.name,
    required this.voteCount,
    required this.image,
    required this.governorate,
    required this.category,
    required this.description,
    required this.birthDate,
    required this.birthPlace,
    required this.education,
    required this.academicDegree,
  });

  factory PartyCandidate.fromJson(Map<String, dynamic> json) {
    return PartyCandidate(
      id: json['id'],
      name: json['name'],
      voteCount: json['voteCount'],
      image: json['image'],
      governorate: json['governorate'],
      category: json['category'],
      description: json['description'],
      birthDate: json['birth_date'],
      birthPlace: json['birth_place'],
      education: json['education'],
      academicDegree: json['academic_degree'],
    );
  }
}
