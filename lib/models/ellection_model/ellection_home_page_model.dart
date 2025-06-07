class ElectionHomeModel {
  final String name;
  final String email;
  final String avatar;
  final int candidateCount;
  final int totalVotes;

  ElectionHomeModel({
    required this.name,
    required this.email,
    required this.avatar,
    required this.candidateCount,
    required this.totalVotes,
  });

  factory ElectionHomeModel.fromJson(Map<String, dynamic> json) {
    return ElectionHomeModel(
      name: json['user']['name'],
      email: json['user']['email'],
      avatar: json['user']['avatar'],
      candidateCount: json['candidate_count'],
      totalVotes: json['total_votes'],
    );
  }
}