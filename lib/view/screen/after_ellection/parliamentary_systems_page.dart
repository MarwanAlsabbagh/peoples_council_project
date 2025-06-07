import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/parliamentary_card.dart';

class ParliamentaryModel {
  final String title;
  final String description;
  final String date;
  final String pdfUrl;

  ParliamentaryModel({
    required this.title,
    required this.description,
    required this.date,
    required this.pdfUrl,
  });
}

class ParliamentarySystemsPage extends StatelessWidget {
  ParliamentarySystemsPage({super.key});

  final List<ParliamentaryModel> dummyData = [
    ParliamentaryModel(
      title: "النظام البرلماني البريطاني",
      description: "يعتمد هذا النظام على دور قوي للبرلمان في تشكيل الحكومة ومراقبة أعمالها...",
      date: "الجمعة، 1 يناير، 2021",
      pdfUrl: "https://example.com/british.pdf",
    ),
    ParliamentaryModel(
      title: "النظام البرلماني الألماني",
      description: "يمتاز النظام الألماني بالفيدرالية ودور البرلمان في تعيين المستشار...",
      date: "الثلاثاء، 15 يونيو، 2021",
      pdfUrl: "https://example.com/german.pdf",
    ),
    ParliamentaryModel(
      title: "النظام البرلماني الكندي",
      description: "يجمع بين النظام البريطاني والخصوصية الكندية مع تمثيل ملكي رمزي...",
      date: "الأحد، 3 أكتوبر، 2021",
      pdfUrl: "https://example.com/canadian.pdf",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "الأنظمة البرلمانية",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: dummyData.length,
            itemBuilder: (context, index) {
              final item = dummyData[index];
              return ParliamentaryCard(
                title: item.title,
                description: item.description,
                date: item.date,
                onTap: () {
                  launchUrl(Uri.parse(item.pdfUrl));
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
