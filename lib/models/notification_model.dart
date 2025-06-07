class MyNotification {
  final String title;
  final String body;
  final DateTime date;
  bool isRead;

  MyNotification({
    required this.title,
    required this.body,
    required this.date,
    this.isRead = false,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'body': body,
    'date': date.toIso8601String(),
    'isRead': isRead,
  };

  factory MyNotification.fromJson(Map<String, dynamic> json) {
    return MyNotification(
      title: json['title'],
      body: json['body'],
      date: DateTime.parse(json['date']),
      isRead: json['isRead'] ?? false,
    );
  }
}
