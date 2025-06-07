class PartyModel {
  final int id;
  final String name;
  final String image;
  final String city;
  final String foundedAt;
  final int? memberCount;

  PartyModel({
    required this.id,
    required this.name,
    required this.image,
    required this.city,
    required this.foundedAt,
    this.memberCount,
  });

  factory PartyModel.fromJson(Map<String, dynamic> json) {
    return PartyModel(
      id: json['id'],
      name: json['name'],
      image: json['image'] ?? '',
      city: json['city'],
      foundedAt: json['founded_at'],
      memberCount: json['member_count'],
    );
  }
  static PartyModel empty() {
    return PartyModel(
      id: 0,
      name: '',
      image: '',
      city: '',
      foundedAt: '',
      memberCount: null,
    );
  }
}
