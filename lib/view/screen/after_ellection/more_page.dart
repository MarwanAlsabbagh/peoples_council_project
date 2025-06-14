import 'package:final_senior_project/view/screen/after_ellection/parliamentary_systems_page.dart';
import 'package:final_senior_project/view/screen/after_ellection/syrian_constitution.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as easy;

import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_container.dart';
import 'articles_and_research.dart';
import 'book_page.dart';

class MorePage extends StatelessWidget {
   MorePage({super.key});

  final List<Map<String, String>> items = [
    {
      'image': 'assets/Layer_1 (1).png',
      'text': ' الأنظمة البرلمانية',
      'page': 'ParliamentarySystemsPage'
    },
    {
      'image': 'assets/Layer_1.png',
      'text': 'الكتب',
      'page': 'BookPage'
    },
    {
      'image': 'assets/Isolation_Mode.png',
      'text': 'المقالات والابحاث',
      'page': 'ArticlesAndResearchPage'
    },
    {
      'image': 'assets/Isolation_Mode (1).png',
      'text': 'الدستور السوري',
      'page': 'SyrianConstitutionPage'
    }
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0,right: 12.0,top: 16,bottom: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Container(
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: AssetImage('assets/images/Rectangle 37.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/syria-logo-png_seeklogo-613100 1.png',
                    width: 80,
                    height: 80,
                  ),
                  const SizedBox(height: 10),
                   Text(
                    easy.tr('syria_towards_better_future'),
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
          ),
              SizedBox(height: 5,),
              Text(easy.tr("everything_you_need_to_know"),
                style:TextStyle(
                  color: Color(0xff2E8F5A),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ) ,),
              SizedBox(height: 5,),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return CustomContainer(
                      imagePath: items[index]['image']!,
                      text: items[index]['text']!,
                      onTap: () {
                        if (items[index]['page'] == 'ParliamentarySystemsPage') {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => ParliamentarySystemsPage()));
                        } else if (items[index]['page'] == 'BookPage') {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => BookPage()));
                        } else if (items[index]['page'] == 'ArticlesAndResearchPage') {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => ArticlesAndResearchPage()));
                        } else if (items[index]['page'] == 'SyrianConstitutionPage') {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => SyrianConstitutionPage()));
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}