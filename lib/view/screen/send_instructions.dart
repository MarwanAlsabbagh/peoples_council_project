import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/send_instructions_controller.dart';
import '../../utils/globall_color.dart';
import '../widgets/eleveted_button.dart';
import '../widgets/text_form_wegit.dart';

class SendInstructionsView extends StatelessWidget {
  SendInstructionsView({Key? key}) : super(key: key);

  final SendInstructionsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password', style: TextStyle(color: GlobalColors.textColor)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: GlobalColors.textColor),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline, color: GlobalColors.textColor),
            onPressed: () {
              Get.snackbar("Help", "Enter your email to receive reset instructions");
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter the email associated with your account and we\'ll send an email with instructions to reset your password',
              style: TextStyle(fontSize: 16, color: GlobalColors.textColor),
            ),
            SizedBox(height: 20),

            Text(
              'Email address',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: GlobalColors.textColor),
            ),
            SizedBox(height: 10),

            TextFieldWidget(
              controller: controller.emailController,
              hintText: 'Email',
              prefixIcon: Icons.email,
            ),
            SizedBox(height: 20),

            ButtonWidget(
              text: 'Send Instructions',
              onPressed: controller.sendInstructions,
            ),
          ],
        ),
      ),
    );
  }
}