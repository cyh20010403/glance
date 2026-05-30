/// 统一 API 异常类型
sealed class ApiException implements Exception {
  final String message;
  final int? statusCode;

  const ApiException(this.message, {this.statusCode});
}

/// 服务端返回的业务错误（code != 200）
final class BusinessException extends ApiException {
  final int code;
  const BusinessException(super.message, {required this.code, int? statusCode})
      : super(statusCode: statusCode);
}

/// 网络连接异常
final class NetworkException extends ApiException {
  const NetworkException([super.message = '网络连接失败，请检查网络']);
}

/// 请求超时
final class TimeoutException extends ApiException {
  const TimeoutException([super.message = '请求超时，请稍后重试']);
}

/// Token 过期（需重新登录）
final class UnauthorizedException extends ApiException {
  const UnauthorizedException([super.message = '登录已过期，请重新登录']);
}

/// 服务器内部错误
final class ServerException extends ApiException {
  const ServerException([super.message = '服务器繁忙，请稍后重试']);
}
