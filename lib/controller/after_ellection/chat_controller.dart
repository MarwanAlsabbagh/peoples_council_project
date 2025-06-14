import 'dart:io';
import 'package:get/get.dart';
import '../../models/aftter_ellection/chat_message_model.dart';
import '../../repository/aftter_ellection/chat_repository.dart';

class ChatController extends GetxController {
  ChatRepository repository = Get.find<ChatRepository>();

  var messages = <ChatMessageModel>[].obs;
  var isLoading = false.obs;

  void sendMessage(String text) async {
    final myMessage = ChatMessageModel(
      message: text,
      senderName: 'أنا',
      senderImage: 'https://i.imgur.com/my-avatar.png',
      isMe: true,
    );
    messages.insert(0, myMessage);

    try {
      final newMessage = await repository.sendMessage(text);
      messages.insert(0, newMessage);
    } catch (e) {
      Get.snackbar("خطأ", "فشل إرسال الرسالة");
    }
  }

  void sendAudioMessage(File audioFile) async {
    try {
      final newMessage = await repository.sendAudio(audioFile);

      messages.insert(0, ChatMessageModel(
        message: newMessage.question ?? 'صوت بدون تفريغ',
        senderName: 'أنا',
        senderImage: 'https://i.imgur.com/my-avatar.png',
        isMe: true,
      ));

      messages.insert(0, newMessage);
    } catch (e) {
      Get.snackbar("خطأ", "فشل إرسال الصوت");
    }
  }

}