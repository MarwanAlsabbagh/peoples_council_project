import 'package:flutter/material.dart';

import '../screen/after_ellection/more_page.dart';


class UserBottomNavigationBar extends StatefulWidget {
  const UserBottomNavigationBar({super.key});

  @override
  State<UserBottomNavigationBar> createState() => _UserBottomNavigationBarState();
}

class _UserBottomNavigationBarState extends State<UserBottomNavigationBar> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    HomePage(),
    MajlisPage(),
    ChatBotPage(),
    AskYourMPPage(),
    SettingsPage(),
    MorePage(),
  ];

  final List<String> titles = [
    'الرئيسية',
    'المجلس',
    'شات بوت',
    'اسأل نائبك',
    'الإعدادات',
    'المزيد'
  ];

  final List<String> icons = [
    "assets/icons/Vector (5).png",
    "assets/icons/Vector (6).png",
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

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("صفحة الرئيسية", style: TextStyle(fontSize: 40)));
  }
}

class MajlisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("صفحة المجلس", style: TextStyle(fontSize: 24)));
  }
}

class ChatBotPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("صفحة شات بوت", style: TextStyle(fontSize: 24)));
  }
}

class AskYourMPPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("صفحة اسأل نائبك", style: TextStyle(fontSize: 24)));
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("صفحة الإعدادات", style: TextStyle(fontSize: 24)));
  }
}


