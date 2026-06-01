import 'package:dio/dio.dart';
import 'dio_helper.dart';
import 'api_response.dart';
import '../error/app_exception.dart';
import '../utils/result.dart';

class ApiClient {
  final Dio _dio = DioHelper.createDio();

  // ─── Error Handler ───────────────────────────
  AppException _handleError(DioException error) {
    if (error.response != null) {
      final data = error.response!.data;
      final message = data['message'] ?? 'حدث خطأ غير متوقع';
      final statusCode = error.response!.statusCode ?? 0;
      return AppException(message: message, statusCode: statusCode);
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return const AppException(
          message: 'انتهت مهلة الاتصال، تحقق من الإنترنت',
        );
      case DioExceptionType.connectionError:
        return const AppException(
          message: 'لا يوجد اتصال بالإنترنت',
        );
      default:
        return const AppException(message: 'حدث خطأ غير متوقع');
    }
  }

  // ─── GET ─────────────────────────────────────
  Future<Result<T, AppException>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
      );
      final apiResponse = ApiResponse.fromJson(
        response.data,
        fromJson,
      );
      return Success(apiResponse.data as T);
    } on DioException catch (e) {
      return Failure(_handleError(e));
    } catch (e) {
      return Failure(
        const AppException(message: 'حدث خطأ غير متوقع'),
      );
    }
  }

  // ─── POST ────────────────────────────────────
  Future<Result<T, AppException>> post<T>(
    String path, {
    dynamic data,
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final response = await _dio.post(path, data: data);
      final apiResponse = ApiResponse.fromJson(
        response.data,
        fromJson,
      );
      return Success(apiResponse.data as T);
    } on DioException catch (e) {
      return Failure(_handleError(e));
    } catch (e) {
      return Failure(
        const AppException(message: 'حدث خطأ غير متوقع'),
      );
    }
  }

  // ─── PUT ─────────────────────────────────────
  Future<Result<T, AppException>> put<T>(
    String path, {
    dynamic data,
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final response = await _dio.put(path, data: data);
      final apiResponse = ApiResponse.fromJson(
        response.data,
        fromJson,
      );
      return Success(apiResponse.data as T);
    } on DioException catch (e) {
      return Failure(_handleError(e));
    } catch (e) {
      return Failure(
        const AppException(message: 'حدث خطأ غير متوقع'),
      );
    }
  }

  // ─── PATCH ───────────────────────────────────
  Future<Result<T, AppException>> patch<T>(
    String path, {
    dynamic data,
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final response = await _dio.patch(path, data: data);
      final apiResponse = ApiResponse.fromJson(
        response.data,
        fromJson,
      );
      return Success(apiResponse.data as T);
    } on DioException catch (e) {
      return Failure(_handleError(e));
    } catch (e) {
      return Failure(
        const AppException(message: 'حدث خطأ غير متوقع'),
      );
    }
  }

  // ─── DELETE ──────────────────────────────────
  Future<Result<T, AppException>> delete<T>(
    String path, {
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final response = await _dio.delete(path);
      final apiResponse = ApiResponse.fromJson(
        response.data,
        fromJson,
      );
      return Success(apiResponse.data as T);
    } on DioException catch (e) {
      return Failure(_handleError(e));
    } catch (e) {
      return Failure(
        const AppException(message: 'حدث خطأ غير متوقع'),
      );
    }
  }
}