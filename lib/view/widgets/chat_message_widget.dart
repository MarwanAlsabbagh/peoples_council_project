import 'package:flutter/material.dart';

class ChatMessageWidget extends StatelessWidget {
  final bool isMe;
  final String messageText;
  final String name;
  final String imageUrl;
  final bool showDivider;

  const ChatMessageWidget({
    Key? key,
    required this.isMe,
    required this.messageText,
    required this.name,
    required this.imageUrl,
    this.showDivider=true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              isMe
                  ? CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(imageUrl),
                backgroundColor: Colors.transparent,
              )
                  : Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xff2E8F5A),
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      "assets/syria-logo-png_seeklogo-613100 1.png",
                      width: 25,
                      height: 25,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 5),
              Text(
                isMe ? "أنا" : name,
                style: TextStyle(
                  color: Color(0xff2E8F5A),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            messageText,
            textAlign: TextAlign.right,
          ),
          if (showDivider)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            ),
        ],
      ),
    );
  }
}
