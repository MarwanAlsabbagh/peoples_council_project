import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddStoryCircle extends StatelessWidget {
  final VoidCallback onTap;

  const AddStoryCircle({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              const CircleAvatar(
                radius: 32,
                backgroundImage: AssetImage('assets/images/default_profile.jpg'),
              ),
              CircleAvatar(
                radius: 12,
                backgroundColor: Colors.white,
                child: Icon(Icons.add, color: Colors.green, size: 18),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        const Text("قصتي", style: TextStyle(fontSize: 12)),
      ],
    );
  }
}
