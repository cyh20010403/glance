import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../core/constants/api_config.dart';

/// 匹配通知 WebSocket 服务
class MatchNotificationService {
  WebSocketChannel? _channel;
  final _controller = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get notifications => _controller.stream;
  bool _disposed = false;

  void connect(int userId) {
    if (_disposed) return;
    // ApiConfig.wsUrl = ws://localhost:8080/ws/chat，替换为 /ws/match
    final matchWsUrl = ApiConfig.wsUrl.replaceAll('/chat', '/match');
    final uri = Uri.parse('$matchWsUrl?userId=$userId');
    _channel = WebSocketChannel.connect(uri);
    _channel!.stream.listen(
      (data) {
        if (_disposed) return;
        final msg = jsonDecode(data as String);
        if (msg['type'] == 'match_success') {
          _controller.add(msg['data']);
        }
      },
      onError: (_) {},
      onDone: () {},
    );
  }

  void disconnect() {
    _disposed = true;
    _channel?.sink.close();
    _controller.close();
  }
}
