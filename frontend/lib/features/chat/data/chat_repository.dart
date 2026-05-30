import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/constants/api_config.dart';
import '../../auth/data/auth_repository.dart';
import '../domain/chat_message.dart';

/// Chat 数据层
///
/// 管理 REST API 调用 + WebSocket 连接
final class ChatRepository {
  final _dio = DioClient.instance;
  WebSocketChannel? _channel;

  /// 获取聊天历史
  Future<List<ChatMessage>> fetchHistory(int matchId) async {
    final response = await _dio.get('/chat/history/$matchId');
    final list = response.data['data'] as List<dynamic>;
    return list
        .map((j) => ChatMessage.fromJson(j as Map<String, dynamic>))
        .toList();
  }

  /// 建立 WebSocket 连接
  ///
  /// [onMessage] 收到新消息时的回调
  Future<WebSocketChannel> connect({
    required void Function(ChatMessage) onMessage,
  }) async {
    final userId = await AuthRepository.getUserId();
    if (userId == null) throw Exception('未登录');

    final wsUrl = '${ApiConfig.wsUrl}?userId=$userId';
    _channel = WebSocketChannel.connect(Uri.parse(wsUrl));

    _channel!.stream.listen(
      (data) {
        final json = jsonDecode(data as String) as Map<String, dynamic>;
        if (json['message'] != null) {
          onMessage(ChatMessage.fromJson(json['message'] as Map<String, dynamic>));
        }
      },
      onError: (error) {
        // 连接错误由 ViewModel 处理
      },
    );

    return _channel!;
  }

  /// 通过 WebSocket 发送消息
  void sendMessage(int matchId, int senderId, String content) {
    if (_channel == null) return;
    _channel!.sink.add(jsonEncode({
      'matchId': matchId,
      'content': content,
      'msgType': 1,
    }));
  }

  /// 断开连接
  void disconnect() {
    _channel?.sink.close();
    _channel = null;
  }
}
