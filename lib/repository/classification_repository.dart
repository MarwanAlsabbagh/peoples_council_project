import 'package:dio/dio.dart';

class ClassificationRepository {
  final Dio _dio = Dio();
  static const _baseUrl = 'https://aea6-34-19-113-112.ngrok-free.app/classify';
  static const _apiKey = '2hmrHVylhqTORRlbpETeczeiNH6_4hVi5MX6yxkgUpfmipZTp';

  Future<String> classifyText(String text) async {
    final response = await _dio.post(
      _baseUrl,
      options: Options(headers: {
        'X-API-KEY': _apiKey,
        'Content-Type': 'application/json',
      }),
      data: {
        'text': text,
        'threshold': 0.5,
        'is_arabic': true,
      },
    );

    return response.data['predictions'][0]['arabic_translation'];
  }
}
