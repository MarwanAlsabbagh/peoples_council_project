class CouncilMember {
  final String name;
  final String governorate;
  final String category;
  final String party;
  final String imagePath;
  final String? partyLogoPath;

  CouncilMember({
    required this.name,
    required this.governorate,
    required this.category,
    required this.party,
    required this.imagePath,
    this.partyLogoPath,
  });

  factory CouncilMember.fromJson(Map<String, dynamic> json) {
    return CouncilMember(
      name: json['name'] ?? '',
      governorate: json['governorate'] ?? '',
      category: json['category'] ?? '',
      party: json['party'] ?? '',
      imagePath: json['imagePath'] ?? '',
      partyLogoPath: json['partyLogoPath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'governorate': governorate,
      'category': category,
      'party': party,
      'imagePath': imagePath,
      'partyLogoPath': partyLogoPath,
    };
  }
}
