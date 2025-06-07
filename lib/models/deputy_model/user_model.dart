class UserModel {
  final String name;
  final String profileImage;

  UserModel({
    required this.name,
    required this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'profileImage': profileImage,
  };
}
