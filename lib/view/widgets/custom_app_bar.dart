import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(120.0),
      child: Stack(
        children: [
          Container(
            height: 120,
            decoration: const BoxDecoration(
              color: Color(0xFF2E8F5A),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/Vector (5).png',
              fit: BoxFit.cover,
              height: 120,
            ),
          ),

          Positioned(
            top: 40,
            left: 16,
            right: 16,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    "assets/icons/bell (2) 1.png",
                    height: 30,
                    width: 30,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/images/1627f3a870e9b56d751d07f53392d7a84aa55817.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Spacer(),
                const Text(
                  "مجلس الشعب السوري",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'IBMPlexSansArabic-Bold',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120.0);
}
