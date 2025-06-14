import 'package:dio/dio.dart' as dio;
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class ApiService extends GetxService {
  final dio.Dio dioClient = dio.Dio(
    dio.BaseOptions(
      baseUrl: 'http://192.168.130.213:8000/api',
      connectTimeout: Duration(milliseconds: 10000),
      receiveTimeout: Duration(milliseconds: 10000),
    ),
  );

  final box = GetStorage();

  ApiService() {
    dioClient.interceptors.add(dio.InterceptorsWrapper(
      onRequest: (options, handler) {
        print('Request: ${options.method} ${options.uri}');
        print('Headers: ${options.headers}');
        print('Data: ${options.data}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print('Response: ${response.statusCode} ${response.data}');
        return handler.next(response);
      },
      onError: (dio.DioException error, handler) {
        print('Error: ${error.message}');
        return handler.next(error);
      },
    ));
  }

  Map<String, String> _buildHeaders({bool withToken = true}) {
    final headers = <String, String>{};
    if (withToken) {
      final token = box.read('token');
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    return headers;
  }

  Future<dio.Response> get(String path,
      {Map<String, dynamic>? queryParameters, bool withToken = true}) async {
    try {
      final response = await dioClient.get(
        path,
        queryParameters: queryParameters,
        options: dio.Options(headers: _buildHeaders(withToken: withToken)),
      );
      return response;
    } catch (e) {
      throw handleError(e);
    }
  }

  Future<dio.Response> post(String path,
      {dynamic data, bool withToken = true}) async {
    try {
      final response = await dioClient.post(
        path,
        data: data,
        options: dio.Options(headers: _buildHeaders(withToken: withToken)),
      );
      return response;
    } catch (e) {
      throw handleError(e);
    }
  }

  Future<dio.Response> put(String path,
      {dynamic data, bool withToken = true}) async {
    try {
      final response = await dioClient.put(
        path,
        data: data,
        options: dio.Options(headers: _buildHeaders(withToken: withToken)),
      );
      return response;
    } catch (e) {
      throw handleError(e);
    }
  }

  Future<dio.Response> delete(String path, {bool withToken = true}) async {
    try {
      final response = await dioClient.delete(
        path,
        options: dio.Options(headers: _buildHeaders(withToken: withToken)),
      );
      return response;
    } catch (e) {
      throw handleError(e);
    }
  }

  Future<dio.Response> postMultipart(String path, dio.FormData formData,
      {bool withToken = true}) async {
    try {
      final headers = _buildHeaders(withToken: withToken);
      // لا تضيف Content-Type يدويًا هنا، ديو يقوم بذلك تلقائيًا

      final response = await dioClient.post(
        path,
        data: formData,
        options: dio.Options(headers: headers),
      );
      return response;
    } catch (e) {
      print("Dio error in postMultipart: $e");
      throw handleError(e);
    }
  }
  dynamic handleError(dynamic error) {
    if (error is dio.DioException) {
      switch (error.response?.statusCode) {
        case 400:
          throw Exception('Bad Request');
        case 401:
          throw Exception('Unauthorized');
        case 403:
          throw Exception('Forbidden');
        case 404:
          throw Exception('Not Found');
        case 500:
          throw Exception('Internal Server Error');
        default:
          throw Exception('Unexpected Error: ${error.message}');
      }
    } else {
      throw Exception('Unexpected error occurred');
    }
  }
}
