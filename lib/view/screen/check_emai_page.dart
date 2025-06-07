import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/globall_color.dart';
import '../widgets/eleveted_button.dart';

class CheckEmailView extends StatelessWidget {
  const CheckEmailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.mail_outline_rounded, size: 100, color: GlobalColors.mainColor),
            SizedBox(height: 32),
            Text(
              'Check your mail',
              style: TextStyle(color: GlobalColors.textColor, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                'We have sent password recovery instructions to your email.',
                style: TextStyle(color: GlobalColors.textColor, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 32),
            SizedBox(
              width: 200,
              child: ButtonWidget(
                text: 'Sign in',
                onPressed: () => Get.offAllNamed('/login'), // الانتقال إلى شاشة تسجيل الدخول
              ),
            ),
            SizedBox(height: 32),
            TextButton(
              onPressed: () => Get.offAllNamed('/home'), // يمكن تعديلها حسب الحاجة
              child: Text('Skip, I\'ll confirm later', style: TextStyle(fontSize: 20, color: Colors.grey.shade600)),
            ),
            Spacer(),
            Text('Did not receive the email? Check your spam filter,'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('or'),
                TextButton(
                  onPressed: () => Get.toNamed('/resendEmail'),
                  child: Text('try another email address'),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}