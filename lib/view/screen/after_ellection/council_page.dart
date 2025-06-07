/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../controller/after_ellection/council_controller.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/member_card.dart';

class CouncilPage extends StatelessWidget {
   CouncilPage({super.key});

  @override
  TextEditingController searchController=TextEditingController();
   final CouncilController CoucilController = Get.put(CouncilController());

   Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller:searchController ,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      hintText: "ابحث عن ما تريد...",
                      prefixIcon: const Icon(Icons.search, color: Colors.green),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Text(
                  "رئيس مجلس الشعب :",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff2E8F5A),
                  ),
                ),
                const SizedBox(height: 10),
                MemberCard(
                  name: 'يوسف بيرقدار',
                  imagePath: 'https://img.youm7.com/ArticleImgs/2022/2/20/43114-%D8%B5%D9%88%D8%B1%D8%A9-%D8%B4%D8%AE%D8%B5%D9%8A%D8%A9.jpeg',
                  category: ' أ',
                  governorate: "دمشق",
                  party: 'حزب العمال الديمقراطي',
                ),

                const SizedBox(height: 20),
                Text(
                  "نائب رئيس مجلس الشعب:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff2E8F5A),
                  ),
                ),
                MemberCard(
                  name: 'يوسف بيرقدار',
                  imagePath: 'https://img.youm7.com/ArticleImgs/2022/2/20/43114-%D8%B5%D9%88%D8%B1%D8%A9-%D8%B4%D8%AE%D8%B5%D9%8A%D8%A9.jpeg',
                  category: ' أ',
                  governorate: "دمشق",
                  party: 'حزب العمال الديمقراطي',
                ),

                const SizedBox(height: 20),
                Text(
                  "أعضاء الحزب :",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff2E8F5A),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: CoucilController.members.length,
                  itemBuilder: (context, index) {
                    final member = CoucilController.members[index];
                    return MemberCard(
                      name: member["name"]!,
                      governorate: member["governorate"],
                      category: member["category"],
                      party: member["party"],
                      imagePath: member["imagePath"]!,
                      partyLogoPath: member["partyLogoPath"],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/
