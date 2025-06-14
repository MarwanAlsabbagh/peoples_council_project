class ChatMessageModel {
  final String message;
  final String senderName;
  final String senderImage;
  final bool isMe;
  final String? question;

  ChatMessageModel({
    required this.message,
    required this.senderName,
    required this.senderImage,
    required this.isMe,
    this.question,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      message: json['message'],
      senderName: json['sender_name'],
      senderImage: json['sender_image'],
      isMe: json['is_me'],
      question: json['question'],
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'sender_name': senderName,
    'sender_image': senderImage,
    'is_me': isMe,
    'question': question,
  };
}
