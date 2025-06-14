
import 'package:easy_localization/easy_localization.dart';
import 'package:final_senior_project/service/notification_service.dart';
import 'package:final_senior_project/view/screen/after_ellection/chat_bot.dart';
import 'package:final_senior_project/view/screen/after_ellection/council_page.dart';
import 'package:final_senior_project/view/screen/after_ellection/more_page.dart';
import 'package:final_senior_project/view/screen/classification_page/classification_view.dart';
import 'package:final_senior_project/view/screen/create_new_password_page.dart';
import 'package:final_senior_project/view/screen/deputy_pages/add_post_screen.dart';
import 'package:final_senior_project/view/screen/deputy_pages/deputy_home_page.dart';
import 'package:final_senior_project/view/screen/deputy_pages/deputy_profile_page.dart';
import 'package:final_senior_project/view/screen/ellection_view/candidates_personal_page.dart';
import 'package:final_senior_project/view/screen/ellection_view/home_page.dart';
import 'package:final_senior_project/view/screen/ellection_view/members_page.dart';
import 'package:final_senior_project/view/screen/ellection_view/parties_page.dart';
import 'package:final_senior_project/view/screen/ellection_view/voting_page.dart';
import 'package:final_senior_project/view/screen/login_page.dart';
import 'package:final_senior_project/view/screen/notification_page.dart';
import 'package:final_senior_project/view/screen/regester_page.dart';
import 'package:final_senior_project/view/screen/settings/privacy_policy_page.dart';
import 'package:final_senior_project/view/screen/settings/setting_page.dart';
import 'package:final_senior_project/view/widgets/bottom-navigation_bar.dart';
import 'package:final_senior_project/view/widgets/buttom_ellection_nav_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'binding/intial_binding.dart';
import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.initialize();
  await GetStorage.init();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      path: 'assets/lang',
      fallbackLocale: const Locale('ar'),
      startLocale: const Locale('ar'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBinding(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      getPages: [
        GetPage(
          name: '/login',
          page: () => LoginPage(),
        ),
      ],
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
    );
  }
}