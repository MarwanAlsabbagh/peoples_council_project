import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleCard extends StatelessWidget {
  final String title;
  final String author;
  final String description;
  final String date;
  final List<String> tags;
  final String url;
  final VoidCallback onTap;

  const ArticleCard({
    required this.title,
    required this.author,
    required this.description,
    required this.date,
    required this.tags,
    required this.url,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      "assets/images/49544e9ed0c48e2849a7f1f3b059d78dc8b2abe8.jpg",
                      height: 140,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(child: Text("حدث خطأ في تحميل الصورة"));
                      },
                    ),
                  ),
                  Positioned(
                    bottom: -30,
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
                          "assets/syria-logo-png_seeklogo-613100 1.png",
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
              SizedBox(height: 30),
              Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xff000401))),
              SizedBox(height: 5),
              Text("الكاتب: $author", style: TextStyle(fontSize: 16, color: Color(0xff2E8F5A))),
              SizedBox(height: 4),
              Text(description, style: TextStyle(fontSize: 14, color: Color(0xff000401))),
              SizedBox(height: 10),
              Text(date, style: TextStyle(fontSize: 14, color: Color.fromRGBO(0, 4, 1, 0.5))),
              SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: tags.map((tag) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff2E8F5A)),
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xffDFF3EB),
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(color: Color(0xff2E8F5A), fontSize: 14),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
