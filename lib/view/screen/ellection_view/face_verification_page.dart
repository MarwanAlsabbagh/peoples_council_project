import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../controller/ellection_controller/votting_controller.dart';
import '../../widgets/eleveted_button.dart';
import '../../widgets/image_widget.dart';

class FaceVerificationPage extends StatefulWidget {
  const FaceVerificationPage({Key? key}) : super(key: key);

  @override
  State<FaceVerificationPage> createState() => _FaceVerificationPageState();
}

class _FaceVerificationPageState extends State<FaceVerificationPage> {
  XFile? faceImage;
  bool isLoading = false;
  final controller = Get.find<VotingController>();

  Future<void> _submit() async {
    if (faceImage == null) {
      _showDialog('التحقق مطلوب', 'يرجى التقاط صورة وجهك.', false);
      return;
    }

    setState(() => isLoading = true);

    final verified = await controller.verifyFace(File(faceImage!.path));
    if (!verified) {
      _showDialog('فشل التحقق', 'تعذر التعرف على الوجه.', false);
      setState(() => isLoading = false);
      return;
    }

    final success = await controller.submitVote();
    _showDialog(
      success ? 'تم التصويت' : 'فشل التصويت',
      success ? 'تم تسجيل صوتك بنجاح ✅' : 'حدث خطأ أثناء التصويت ❌',
      success,
    );

    setState(() => isLoading = false);
  }

  void _showDialog(String title, String message, bool isSuccess) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('حسنًا'),
            onPressed: () {
              Navigator.pop(context);
              if (isSuccess) Navigator.pop(context); // ترجع إلى صفحة التصويت
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final candidate = controller.selectedCandidate.value;
    return Scaffold(
      appBar: AppBar(title: const Text('التحقق من الوجه')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text('المرشح: ${candidate?.name ?? 'غير معروف'}'),
            const SizedBox(height: 20),
            ImageGenericWidget(
              label: 'التقط صورة وجهك',
              image: faceImage,
              onPick: (pickedImage) => setState(() => faceImage = pickedImage),
            ),
            const SizedBox(height: 30),
            isLoading
                ? const CircularProgressIndicator()
                : ButtonWidget(
              text: 'تحقق وصوّت',
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
