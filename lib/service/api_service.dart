import 'package:dio/dio.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get_storage/get_storage.dart';

class ApiService extends GetxService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.1.108:8000/api',
      connectTimeout: Duration(milliseconds: 10000),
      receiveTimeout: Duration(milliseconds: 10000),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  final box = GetStorage();

  ApiService() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print('Request: ${options.method} ${options.uri}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print('Response: ${response.statusCode} ${response.data}');
        return handler.next(response);
      },
      onError: (DioException error, handler) {
        print('Error: ${error.message}');
        return handler.next(error);
      },
    ));
  }

  Map<String, String> _buildHeaders({bool withToken = true}) {
    final headers = {'Content-Type': 'application/json'};
    if (withToken) {
      final token = box.read('token');
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    return headers;
  }

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters, bool withToken = true}) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: _buildHeaders(withToken: withToken)),
      );
      return response;
    } catch (e) {
      throw handleError(e);
    }
  }

  Future<Response> post(String path,
      {dynamic data, bool withToken = true}) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        options: Options(headers: _buildHeaders(withToken: withToken)),
      );
      return response;
    } catch (e) {
      throw handleError(e);
    }
  }

  Future<Response> put(String path,
      {dynamic data, bool withToken = true}) async {
    try {
      final response = await dio.put(
        path,
        data: data,
        options: Options(headers: _buildHeaders(withToken: withToken)),
      );
      return response;
    } catch (e) {
      throw handleError(e);
    }
  }

  Future<Response> delete(String path, {bool withToken = true}) async {
    try {
      final response = await dio.delete(
        path,
        options: Options(headers: _buildHeaders(withToken: withToken)),
      );
      return response;
    } catch (e) {
      throw handleError(e);
    }
  }

  Future<Response> postMultipart(String path, FormData formData,
      {bool withToken = true}) async {
    try {
      final headers = _buildHeaders(withToken: withToken);
      headers['Content-Type'] = 'multipart/form-data';

      final response = await dio.post(
        path,
        data: formData,
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      throw handleError(e);
    }
  }

  dynamic handleError(dynamic error) {
    if (error is DioException) {
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
