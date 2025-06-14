class Votting {
  final int candidateId;
  final String name;
  final String? imagePath;
  final String? governorate;
  final String? category;
  final String? description;
  final String? partyName;
  final String? partyLogoPath;
  final int? partyId;
  final int voteCount;

  Votting({
    required this.candidateId,
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

  factory Votting.fromJson(Map<String, dynamic> json) {
    final detail = json['detail'];
    final party = json['party'];

    return Votting(
      candidateId: json['id'] ?? 0,
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
    'id': candidateId,
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
