
import 'package:final_senior_project/view/screen/regester_page.dart';
import 'package:final_senior_project/view/screen/send_instructions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart' as easy;

import '../../controller/login_controller.dart';
import '../../utils/globall_color.dart';

import '../widgets/eleveted_button.dart';
import '../widgets/text_form_wegit.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final LoginController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned.fill(
                child: Opacity(
                    opacity: 0.5,
                    child:
                    Image.asset("assets/Vector (1).png", fit: BoxFit.cover)),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 25),
                            Container(
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/syria-logo-png_seeklogo-613100 1.png",
                                      width: 120,
                                      height: 120,
                                    ),
                                    Text(easy.tr("custom_appbar_title"),
                                      style: TextStyle(
                                        color: GlobalColors.textColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),),
                                    Text("Syrian People's Assembly",
                                      style: TextStyle(
                                        color: GlobalColors.secondTextColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),),

                                  ],
                                )),
                            SizedBox(height: 50),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                easy.tr("login_button"),
                                style: TextStyle(
                                  color: GlobalColors.secondTextColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            TextFieldWidget(
                              controller: controller.emailController,
                              hintText: easy.tr('login_email_hint'),
                              prefixIcon: Icons.email_outlined,
                              onTap: () {},
                              readOnly: false,
                            ),
                            SizedBox(height: 20),
                            TextFieldWidget(
                              controller: controller.passwordController,
                              hintText: easy.tr('login_password_hint'),
                              prefixIcon: Icons.lock_clock_outlined,
                              obscureText: true,
                              onTap: () {},
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(SendInstructionsView());
                                },
                                child: Text(
                                  easy.tr('login_forgot_password'),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: GlobalColors.secondTextColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                        Column(
                          children: [
                            Obx(() => controller.isLoading.value
                                ? CircularProgressIndicator()
                                : ButtonWidget(
                              text: easy.tr('login_button'),
                              onPressed: controller.login,
                            )),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(RegisterPage());
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      easy.tr("login_no_account"),
                                      style: TextStyle(
                                          color: GlobalColors.textColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16
                                      ),
                                    ),
                                    Text(
                                      easy.tr("login_create_account"),
                                      style: TextStyle(
                                          color: GlobalColors.secondTextColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
