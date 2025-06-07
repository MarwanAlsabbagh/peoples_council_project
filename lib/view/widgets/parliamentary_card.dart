import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ParliamentaryCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final VoidCallback onTap;

  const ParliamentaryCard({
    required this.title,
    required this.description,
    required this.date,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Color(0xffE4E7EC),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    "assets/images/05435674ef294bda44ebe3bda02e9332dff76aab.jpg",
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(child: Text("حدث خطأ في تحميل الصورة"));
                    },
                  ),
                ),
                Positioned(
                  bottom: -15,
                  right: 0,
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF2E8F5A),
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/syria-logo-png_seeklogo-613100 1.png", // الصورة الثابتة للوغو
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(child: Icon(Icons.error));
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xff000401))),
            ),
            SizedBox(height: 5),
            Text(description, style: TextStyle(fontSize: 16, color: Color(0xff000401))),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(date, style: TextStyle(fontSize: 14, color: Color.fromRGBO(0, 4, 1, 0.5))),
            ),
          ],
        ),
      ),
    );
  }
}
