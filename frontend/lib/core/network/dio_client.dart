import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_config.dart';
import 'api_exception.dart';

/// Dio HTTP 客户端单例
final class DioClient {
  DioClient._();

  static Dio? _instance;

  static Dio get instance {
    _instance ??= _createDio();
    return _instance!;
  }

  static Dio _createDio() {
    final dio = Dio(BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: const Duration(milliseconds: ApiConfig.connectTimeout),
      receiveTimeout: const Duration(milliseconds: ApiConfig.receiveTimeout),
      headers: {'Content-Type': 'application/json'},
    ));

    dio.interceptors.add(_AuthInterceptor());
    dio.interceptors.add(_ErrorInterceptor());
    return dio;
  }

  static void clearTokenCache() {
    _tokenCache = null;
  }

  static String? _tokenCache;
}

/// 从异常中提取用户可读的错误消息
String dioErrorMsg(Object e) {
  if (e is ApiException) return e.message;
  if (e is DioException) {
    if (e.error is ApiException) return (e.error as ApiException).message;
    return '网络异常，请稍后重试';
  }
  return '未知错误';
}

/// 自动注入 Bearer Token
final class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.path.contains('/auth/')) {
      return handler.next(options);
    }

    DioClient._tokenCache ??= await _loadToken();
    final token = DioClient._tokenCache;

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  Future<String?> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}

/// 统一错误处理
final class _ErrorInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final data = response.data;
    if (data is Map<String, dynamic>) {
      final code = data['code'] as int?;
      if (code != null && code != 200) {
        return handler.reject(DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: BusinessException(
            data['message'] as String? ?? '未知错误',
            code: code,
            statusCode: response.statusCode,
          ),
        ));
      }
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 如果 error 已经是 ApiException，直接传递
    if (err.error is ApiException) {
      return handler.next(err);
    }

    ApiException exception;
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        exception = TimeoutException();
        break;
      case DioExceptionType.connectionError:
        exception = NetworkException();
        break;
      case DioExceptionType.badResponse:
        if (err.response?.statusCode == 401) {
          exception = UnauthorizedException();
        } else if (err.response != null && err.response!.statusCode! >= 500) {
          exception = ServerException();
        } else {
          exception = BusinessException('请求失败', code: err.response?.statusCode ?? -1);
        }
        break;
      default:
        exception = NetworkException(err.message ?? '未知错误');
    }

    handler.next(DioException(
      requestOptions: err.requestOptions,
      error: exception,
    ));
  }
}
