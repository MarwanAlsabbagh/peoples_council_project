import 'dart:io';
import 'package:dio/dio.dart';
import '../../models/aftter_ellection/chat_message_model.dart';

class ChatRepository {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://9a85-34-125-146-33.ngrok-free.app',
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
      'audio': await MultipartFile.fromFile(audioFile.path, filename: 'voice.mp3'),
    });

    final response = await _dio.post('/transcribe_and_ask', data: formData);

    return ChatMessageModel(
      message: response.data['legal_answer'],
      question: response.data['transcription'],
      senderName: 'المساعد',
      senderImage: 'https://i.imgur.com/assistant-avatar.png',
      isMe: false,
    );
  }
}
