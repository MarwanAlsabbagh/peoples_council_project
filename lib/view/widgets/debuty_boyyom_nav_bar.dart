import 'package:flutter/material.dart';

import '../screen/after_ellection/chat_bot.dart';
import '../screen/after_ellection/more_page.dart';
import '../screen/classification_page/classification_view.dart';
import '../screen/deputy_pages/deputy_home_page.dart';
import '../screen/deputy_pages/deputy_profile_page.dart';
import '../screen/settings/setting_page.dart';
import 'bottom-navigation_bar.dart';


class DebutyBottomNavigationBar extends StatefulWidget {
  const DebutyBottomNavigationBar({super.key});

  @override
  State<DebutyBottomNavigationBar> createState() => _DebutyBottomNavigationBarState();
}

class _DebutyBottomNavigationBarState extends State<DebutyBottomNavigationBar> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    DeputyHomePage(),
    ClassificationPage(),
    ChatPage(),
    DeputyProfilePage(),
    SettingPage(),
    MorePage(),
  ];

  final List<String> titles = [
    'الرئيسية',
    'القضايا',
    'شات بوت',
    'البروفايل',
    'الإعدادات',
    'المزيد'
  ];

  final List<String> icons = [
    "assets/icons/Vector (5).png",
    "assets/equality 1.png",
    "assets/icons/Layer_1.png",
    "assets/icons/question-square 1.png",
    "assets/icons/settings (4) 1.png",
    "assets/icons/circle-ellipsis 1.png"
  ];

  void onTabTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: IndexedStack(
          index: selectedIndex,
          children: pages,
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(titles.length, (index) {
              bool isSelected = selectedIndex == index;
              return GestureDetector(
                onTap: () => onTabTapped(index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40,
                      height: 3,
                      margin: EdgeInsets.only(bottom: 8),
                      color: isSelected ? Color(0xFF2E8F5A) : Colors.transparent,
                    ),
                    Image.asset(
                      icons[index],
                      color: isSelected ? Color(0xFF2E8F5A) : Colors.black,
                    ),
                    Text(
                      titles[index],
                      style: TextStyle(
                        color: isSelected ? Color(0xFF2E8F5A) : Colors.black,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}



class MajlisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("صفحة المجلس", style: TextStyle(fontSize: 24)));
  }
}








