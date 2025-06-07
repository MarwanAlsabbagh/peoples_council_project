class UserLogin{
  String email;
  String password;


  UserLogin({
    required this.email,
    required this.password,

  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return UserLogin(
      email: json['email'],
      password: json['password'],
    );
  }
}