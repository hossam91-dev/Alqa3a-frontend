import 'package:dio/dio.dart';
import 'app_exception.dart';

class ErrorHandler {
  static AppException handle(dynamic error) {
    if (error is AppException) return error;

    if (error is DioException) {
      return _handleDio(error);
    }

    return const UnknownException('حدث خطأ غير متوقع');
  }

  static AppException _handleDio(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return const NetworkException('انتهت مهلة الاتصال، تحقق من الإنترنت');

      case DioExceptionType.connectionError:
        return const NetworkException('لا يوجد اتصال بالإنترنت');

      case DioExceptionType.badResponse:
        return _handleStatusCode(
          error.response?.statusCode,
          error.response?.data,
        );

      default:
        return const UnknownException('حدث خطأ غير متوقع');
    }
  }

  static AppException _handleStatusCode(int? statusCode, dynamic data) {
    final message = data?['message'] ?? 'حدث خطأ';

    switch (statusCode) {
      case 400:
        return ValidationException(message);
      case 401:
        return const AuthException('انتهت الجلسة، يرجى تسجيل الدخول مجدداً');
      case 403:
        return const AuthException('غير مصرح لك بهذه العملية');
      case 404:
        return const ServerException('البيانات غير موجودة');
      case 409:
        return ValidationException(message);
      case 429:
        return const ServerException('طلبات كثيرة، يرجى الانتظار قليلاً');
      case 500:
        return const ServerException('خطأ في السيرفر');
      default:
        return ServerException(message);
    }
  }
}