class ResetPasswordModel {
  String password;
  String confirmPassword;

  ResetPasswordModel({
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'confirm_password': confirmPassword,
    };
  }

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordModel(
      password: json['password'],
      confirmPassword: json['confirm_password'],
    );
  }
}
