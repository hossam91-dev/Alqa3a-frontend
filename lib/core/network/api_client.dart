import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../error/error_handler.dart';
import '../error/result.dart';

class ApiClient {
  late final Dio _dio;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const String _baseUrl = 'http://10.0.2.2:3000/api/v1';

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storage.read(key: 'access_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) {
          handler.next(error);
        },
      ),
    );
  }

  Future<Result<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic data) fromJson,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
      );
      return Success(fromJson(response.data['data']));
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }

  Future<Result<T>> post<T>(
    String path, {
    dynamic data,
    required T Function(dynamic data) fromJson,
  }) async {
    try {
      final response = await _dio.post(path, data: data);
      return Success(fromJson(response.data['data']));
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }

  Future<Result<T>> put<T>(
    String path, {
    dynamic data,
    required T Function(dynamic data) fromJson,
  }) async {
    try {
      final response = await _dio.put(path, data: data);
      return Success(fromJson(response.data['data']));
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }

  Future<Result<T>> patch<T>(
    String path, {
    dynamic data,
    required T Function(dynamic data) fromJson,
  }) async {
    try {
      final response = await _dio.patch(path, data: data);
      return Success(fromJson(response.data['data']));
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }

  Future<Result<T>> delete<T>(
    String path, {
    required T Function(dynamic data) fromJson,
  }) async {
    try {
      final response = await _dio.delete(path);
      return Success(fromJson(response.data['data']));
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }
}