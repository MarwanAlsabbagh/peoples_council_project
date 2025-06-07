import 'dart:io';
import 'package:dio/dio.dart';
import '../../models/aftter_ellection/chat_message_model.dart';

class ChatRepository {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://3046-34-60-185-142.ngrok-free.app',
    headers: {'Content-Type': 'application/json'},
  ));

  Future<ChatMessageModel> sendMessage(String message) async {
    final response = await _dio.post('/ask', data: {
      'question': message,
    });

    return ChatMessageModel(
      message: response.data['response'],
      senderName: 'المساعد',
      senderImage: 'https://i.imgur.com/assistant-avatar.png',
      isMe: false,
    );
  }

  Future<ChatMessageModel> sendAudio(File audioFile) async {
    final formData = FormData.fromMap({
      'audio': await MultipartFile.fromFile(audioFile.path, filename: 'voice.wav'),
    });

    final response = await _dio.post('/api/ask-with-audio', data: formData);

    return ChatMessageModel(
      message: response.data['answer'],
      question: response.data['question'],
      senderName: 'المساعد',
      senderImage: 'https://i.imgur.com/assistant-avatar.png',
      isMe: false,
    );
  }
}