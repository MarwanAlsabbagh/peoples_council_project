import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/create_new_password_controller.dart';
import '../../utils/globall_color.dart';
import '../widgets/eleveted_button.dart';
import '../widgets/text_form_wegit.dart';

class CreateNewPasswordView extends StatelessWidget {
  CreateNewPasswordView({Key? key}) : super(key: key);

  final CreateNewPasswordController controller = Get.put(CreateNewPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password', style: TextStyle(color: GlobalColors.textColor)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: GlobalColors.textColor),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 16),
            Text('Create new password', style: TextStyle(color: GlobalColors.textColor, fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text('Your new password must be different from previous used passwords.', style: TextStyle(color: GlobalColors.textColor, fontSize: 16)),
            SizedBox(height: 16),
            Text('Password', style: TextStyle(color: GlobalColors.textColor, fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            TextFieldWidget(
              controller: controller.passwordController,
              hintText: 'Password',
              prefixIcon: Icons.lock,
              obscureText: true,
            ),
            SizedBox(height: 15),
            Text('Confirm Password', style: TextStyle(color: GlobalColors.textColor, fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            TextFieldWidget(
              controller: controller.confirmPasswordController,
              hintText: 'Confirm Password',
              prefixIcon: Icons.lock,
              obscureText: true,
            ),
            SizedBox(height: 20),
            ButtonWidget(
              text: 'Reset Password',
              onPressed: controller.resetPassword,
            ),
          ],
        ),
      ),
    );
  }
}
