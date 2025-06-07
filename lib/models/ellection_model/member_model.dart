class MemberModel {
  final int id;
  final String name;
  final String? imagePath;
  final String? governorate;
  final String? category;
  final String? description;
  final String? partyName;
  final String? partyLogoPath;
  final int? partyId;
  final int voteCount;

  MemberModel({
    required this.id,
    required this.name,
    this.imagePath,
    this.governorate,
    this.category,
    this.description,
    this.partyName,
    this.partyLogoPath,
    this.partyId,
    required this.voteCount,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    final detail = json['detail'];
    final party = json['party'];

    return MemberModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      voteCount: json['voteCount'] ?? 0,
      imagePath: detail?['image'],
      governorate: detail?['governorate'],
      category: detail?['category'],
      description: detail?['description'],
      partyName: party?['name'],
      partyLogoPath: party?['image'],
      partyId: party?['id'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'voteCount': voteCount,
    'image': imagePath,
    'governorate': governorate,
    'category': category,
    'description': description,
    'party_name': partyName,
    'party_logo_path': partyLogoPath,
    'party_id': partyId,
  };
}
