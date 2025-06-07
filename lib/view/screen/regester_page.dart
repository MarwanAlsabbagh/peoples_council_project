import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          "ابدأ بانشاء حسابك الآن",
                          style: TextStyle(
                            fontSize: 18,
                            color: GlobalColors.secondTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      Obx(() => ImageGenericWidget(
                        label: "الصورة الشخصية",
                        image: controller.avatar.value,
                        onPick: (xfile) => controller.avatar.value = xfile,
                      )),
                      SizedBox(height: 20),

                      TextFieldWidget(
                        controller: controller.firstNameController,
                        hintText: 'مروان الصباغ',
                        prefixIcon: Icons.perm_identity,
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(height: 15),

                      TextFieldWidget(
                        controller: controller.emailController,
                        hintText: 'marwan@gmail.com',
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 15),

                      TextFieldWidget(
                        controller: controller.nationalIDController,
                        hintText: '303011111',
                        prefixIcon: Icons.perm_identity,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 15),

                      TextFieldWidget(
                        controller: controller.phoneController,
                        hintText: '0943971457',
                        prefixIcon: Icons.phone_android,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 15),

                      TextFieldWidget(
                        controller: controller.passwordController,
                        hintText: '******',
                        prefixIcon: Icons.lock_clock_outlined,
                        obscureText: true,
                      ),
                      SizedBox(height: 15),

                      TextFieldWidget(
                        controller: controller.confirmPasswordController,
                        hintText: '******',
                        prefixIcon: Icons.lock_clock_outlined,
                        obscureText: true,
                      ),
                      SizedBox(height: 15),

                      Obx(() => DropdownWidget(
                        hintText: "دمشق",
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

                      TextFieldWidget(
                        controller: controller.locationCityController,
                        hintText: 'المزرعة,ساحة الشهبندر',
                        prefixIcon: Icons.location_city,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 15),

                      Obx(() => DropdownWidget(
                        hintText: "ذكر",
                        items: ["ذكر", "أنثى"],
                        selectedValue: controller.selectedGender.value,
                        onChanged: (newValue) {
                          controller.selectedGender.value = newValue!;
                        },
                        prefixIcon: Icons.male,
                      )),

                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "حمل صور الهوية الشخصية :",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: GlobalColors.secondTextColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),

                      Obx(() => ImageGenericWidget(
                        label: "الصورة الأمامية",
                        image: controller.frontId.value,
                        onPick: (xfile) => controller.frontId.value = xfile,
                      )),
                      SizedBox(height: 15),

                      Obx(() => ImageGenericWidget(
                        label: "الصورة الخلفية",
                        image: controller.backId.value,
                        onPick: (xfile) => controller.backId.value = xfile,
                      )),
                      SizedBox(height: 20),

                      ButtonWidget(
                        text: 'تسجيل',
                        onPressed: () {
                          controller.register();
                        },
                      ),
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
