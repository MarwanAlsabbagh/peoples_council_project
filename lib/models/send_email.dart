class SendEmail{
  String email;

  SendEmail({
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }

  factory SendEmail.fromJson(Map<String, dynamic> json) {
    return SendEmail(
      email: json['email'],
    );
  }
}