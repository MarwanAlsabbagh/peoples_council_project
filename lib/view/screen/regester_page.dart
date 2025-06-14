import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart' as easy;

import '../../controller/register_controller.dart';
import '../../utils/globall_color.dart';
import '../widgets/dropdown_widget.dart';
import '../widgets/eleveted_button.dart';
import '../widgets/image_generic_widget.dart';
import '../widgets/image_widget.dart';
import '../widgets/text_form_wegit.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final RegisterController controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: 0.5,
                  child:
                  Image.asset("assets/Vector (1).png", fit: BoxFit.cover),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding:
                  const EdgeInsets.only(bottom: 30, left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 25),
                      Column(
                        children: [
                          Image.asset(
                            "assets/syria-logo-png_seeklogo-613100 1.png",
                            width: 120,
                            height: 120,
                          ),
                          Text(
                            "مجلس الشعب العربي السوري",
                            style: TextStyle(
                              color: GlobalColors.textColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Syrian People's Assembly",
                            style: TextStyle(
                              color: GlobalColors.secondTextColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          easy.tr('register_title'),
                          style: TextStyle(
                            fontSize: 18,
                            color: GlobalColors.secondTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      Obx(() => ImageGenericWidget(
                        label:  easy.tr("register_avatar_label"),
                        image: controller.avatar.value,
                        onPick: (xfile) => controller.avatar.value = xfile,
                      )),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          easy.tr("register_firstname_hint"),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: GlobalColors.secondTextColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      TextFieldWidget(
                        controller: controller.firstNameController,
                        hintText:  easy.tr('register_firstname_hint'),
                        prefixIcon: Icons.perm_identity,
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(height: 15),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          easy.tr("register_email_hint1"),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: GlobalColors.secondTextColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      TextFieldWidget(
                        controller: controller.emailController,
                        hintText: easy.tr('register_email_hint'),
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          easy.tr("register_national_id_hint1"),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: GlobalColors.secondTextColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      TextFieldWidget(
                        controller: controller.nationalIDController,
                        hintText:  easy.tr('register_national_id_hint'),
                        prefixIcon: Icons.perm_identity,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          easy.tr("register_phone_hint1"),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: GlobalColors.secondTextColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      TextFieldWidget(
                        controller: controller.phoneController,
                        hintText:  easy.tr('register_phone_hint'),
                        prefixIcon: Icons.phone_android,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          easy.tr("register_password_hint1"),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: GlobalColors.secondTextColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      TextFieldWidget(
                        controller: controller.passwordController,
                        hintText:  easy.tr('register_password_hint'),
                        prefixIcon: Icons.lock_clock_outlined,
                        obscureText: true,
                      ),
                      SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          easy.tr("register_password_hint1"),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: GlobalColors.secondTextColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      TextFieldWidget(
                        controller: controller.confirmPasswordController,
                        hintText:  easy.tr('register_password_hint'),
                        prefixIcon: Icons.lock_clock_outlined,
                        obscureText: true,
                      ),
                      SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          easy.tr('register_city_hint1'),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: GlobalColors.secondTextColor,
                          ),
                        ),
                      ),

                      SizedBox(height: 5),
                      Obx(() => DropdownWidget(
                        hintText:  easy.tr("register_city_hint"),
                        items: [
                          "دمشق",
                          "حلب",
                          "حمص",
                          "حماة",
                          "اللاذقية",
                          "طرطوس",
                          "دير الزور",
                          "الرقة",
                          "الحسكة",
                          "درعا",
                          "السويداء",
                          "القنيطرة"
                        ],
                        selectedValue: controller.selectedCity.value,
                        onChanged: (newValue) {
                          controller.selectedCity.value = newValue!;
                        },
                        prefixIcon: Icons.location_city,
                      )),
                      SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          easy.tr("register_location_hint1"),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: GlobalColors.secondTextColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      TextFieldWidget(
                        controller: controller.locationCityController,
                        hintText:  easy.tr('register_location_hint'),
                        prefixIcon: Icons.location_city,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                            easy.tr("register_gender_hint1"),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: GlobalColors.secondTextColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Obx(() => DropdownWidget(
                        hintText:  easy.tr("register_gender_hint"),
                        items: ["ذكر", "أنثى"],
                        selectedValue: controller.selectedGender.value,
                        onChanged: (newValue) {
                          controller.selectedGender.value = newValue!;
                        },
                        prefixIcon: Icons.male,
                      )),

                      SizedBox(height: 20),
                      /*Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          easy.tr("register_front_id_label"),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: GlobalColors.secondTextColor,
                          ),
                        ),
                      ),*/
                      SizedBox(height: 10),

                      Obx(() => ImageGenericWidget(
                        label:  easy.tr("register_front_id_label"),
                        image: controller.frontId.value,
                        onPick: (xfile) => controller.frontId.value = xfile,
                      )),
                      SizedBox(height: 15),

                      Obx(() => ImageGenericWidget(
                        label:  easy.tr("register_back_id_label"),
                        image: controller.backId.value,
                        onPick: (xfile) => controller.backId.value = xfile,
                      )),
                      SizedBox(height: 20),

                      Obx(() {
                        return controller.isLoading.value
                            ? CircularProgressIndicator()
                            : ButtonWidget(
                          text: easy.tr('register_button'),
                          onPressed: () {
                            controller.register();
                          },
                        );
                      }),
                    ],
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
