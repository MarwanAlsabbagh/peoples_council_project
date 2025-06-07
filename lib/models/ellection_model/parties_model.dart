class PartiesModel {
  final int id;
  final String name;
  final String governorate;
  final String imagePath;
  final int numberMembers;

  PartiesModel({
    required this.id,
    required this.name,
    required this.governorate,
    required this.imagePath,
    required this.numberMembers,
  });

  factory PartiesModel.fromJson(Map<String, dynamic> json) {
    return PartiesModel(
      id: json['id'],
      name: json['name'],
      governorate: json['city'],
      imagePath: json['image'],
      numberMembers: json['members_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'city': governorate,
      'image': imagePath,
      'members_count': numberMembers,
    };
  }
}
