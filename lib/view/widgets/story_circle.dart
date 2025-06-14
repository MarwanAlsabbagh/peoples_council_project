import 'package:final_senior_project/utils/media_utils.dart';
import 'package:flutter/material.dart';

class StoryCircle extends StatelessWidget {
  final String imagePath;
  final String userName;
  final bool isViewed;

  const StoryCircle({
    Key? key,
    required this.imagePath,
    required this.userName,
    this.isViewed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: isViewed
                  ? null
                  : const LinearGradient(
                colors: [Color(0xFF2E8F5A), Color(0xFF175D37)],
              ),
              color: isViewed ? Colors.grey : null,
            ),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: CircleAvatar(
                radius: 32,
                backgroundImage: NetworkImage(getFullMediaUrl(imagePath)),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            userName,
            style: const TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
