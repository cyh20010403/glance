/// API 与 WebSocket 地址配置
///
/// Android 模拟器使用 10.0.2.2 访问宿主机，
/// iOS 模拟器使用 localhost。
class ApiConfig {
  ApiConfig._();

  /// 后端基地址（Web/桌面用 localhost，Android 模拟器用 10.0.2.2）
  static const String baseUrl = 'http://localhost:8080/api';

  /// WebSocket 地址
  static const String wsUrl = 'ws://localhost:8080/ws/chat';

  /// 请求超时（毫秒）
  static const int connectTimeout = 10000;
  static const int receiveTimeout = 15000;
}
