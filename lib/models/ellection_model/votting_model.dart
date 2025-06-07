class Votting {
  final String name;
  final String governorate;
  final String category;
  final String party;
  final String imagePath;
  final String partyLogoPath;

  Votting({
    required this.name,
    required this.governorate,
    required this.category,
    required this.party,
    required this.imagePath,
    required this.partyLogoPath,
  });

  factory Votting.fromJson(Map<String, dynamic> json) {
    return Votting(
      name: json['name'],
      governorate: json['governorate'],
      category: json['category'],
      party: json['party'],
      imagePath: json['image_path'],
      partyLogoPath: json['party_logo_path'],
    );
  }
}
