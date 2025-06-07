import 'package:flutter/material.dart';

import '../screen/after_ellection/more_page.dart';
import '../screen/ellection_view/home_page.dart';
import '../screen/ellection_view/members_page.dart';
import '../screen/ellection_view/parties_page.dart';
import '../screen/ellection_view/voting_page.dart';


class BottomEllectionNavBar
 extends StatefulWidget {
  const BottomEllectionNavBar({super.key});

  @override
  State<BottomEllectionNavBar> createState() => _BottomEllectionNavBarState();
}

class _BottomEllectionNavBarState extends State<BottomEllectionNavBar> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    ElectionHomePage(),
    VotingPage(),
    MembersPage(),
    PartiesPage(),
    SettingsPage(),
  ];

  final List<String> titles = [
    'الرئيسية',
    'تصويت',
    'المرشحين',
    'الأحزاب',
    'الإعدادات',
  ];

  final List<String> icons = [
    "assets/icons/Vector (5).png",
    "assets/vote-yea 1.png",
    "assets/member-list 1.png",
    "assets/icons/question-square 1.png",
    "assets/icons/settings (4) 1.png",
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

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("صفحة الإعدادات", style: TextStyle(fontSize: 24)));
  }
}


