import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../controller/deputy_controller/comment_controller.dart';
import '../../../repository/deputy_repository/comment_repository.dart';
import '../../../service/api_service.dart';

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
            title: const Text('التعليقات'),
          ),
          body: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                Expanded(
                  child: controller.comments.isEmpty
                      ? const Center(child: Text("لا توجد تعليقات بعد"))
                      : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: controller.comments.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      return Text(controller.comments[index].content ?? '');
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          decoration: const InputDecoration(
                            hintText: "أضف تعليقًا...",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () async {
                          final text = _textController.text.trim();
                          if (text.isNotEmpty) {
                            await controller.addComment(text);
                            _textController.clear();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }
}
