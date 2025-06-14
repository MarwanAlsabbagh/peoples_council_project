import 'package:final_senior_project/view/widgets/comment_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart' as easy;

import '../../../controller/deputy_controller/comment_controller.dart';
import '../../../repository/deputy_repository/comment_repository.dart';
import '../../../service/api_service.dart';
import '../../widgets/message_input_widget.dart'; // تأكد من المسار الصحيح

class CommentScreen extends StatelessWidget {
  final int postId;

  const CommentScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommentController>(
      init: CommentController(
        repository: CommentRepository(apiService: ApiService()),
        postId: postId,
      ),
      builder: (controller) {
        final TextEditingController _textController = TextEditingController();

        return Scaffold(
          appBar: AppBar(
            title: Text(easy.tr('comments_title')),
          ),
          body: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                Expanded(
                  child: controller.comments.isEmpty
                      ? Center(
                    child: Text(
                      easy.tr("no_comments"),
                      style: const TextStyle(fontSize: 16),
                    ),
                  )
                      : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: controller.comments.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final comment = controller.comments[index];
                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Text(
                          comment.content ?? '',
                          style: const TextStyle(fontSize: 15),
                        ),
                      );
                    },
                  ),
                ),

                CommentInputWidget(
                  controller: _textController,
                  onSend: () async {
                    final text = _textController.text.trim();
                    if (text.isNotEmpty) {
                      await controller.addComment(text);
                      _textController.clear();
                    }
                  },
                ),
              ],
            );
          }),
        );
      },
    );
  }
}
