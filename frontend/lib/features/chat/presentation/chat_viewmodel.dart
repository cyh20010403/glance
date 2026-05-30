import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/api_exception.dart';
import '../domain/chat_state.dart';
import '../domain/chat_message.dart';

final class ChatViewModel extends Notifier<ChatState> {
  final _dio = DioClient.instance;
  Timer? _pollTimer;

  @override
  ChatState build() => const ChatState.loading();

  Future<void> init(int matchId) async {
    state = const ChatState.loading();
    try {
      final history = await _fetchHistory(matchId);
      state = ChatState.ready(messages: history, connected: true);
      _startPolling(matchId);
    } on ApiException catch (e) {
      state = ChatState.error(message: e.message);
    } on DioException catch (e) {
      state = ChatState.error(message: dioErrorMsg(e));
    } catch (e) {
      state = const ChatState.error(message: '连接失败');
    }
  }

  Future<void> send(int matchId, int senderId, String content) async {
    if (content.trim().isEmpty) return;
    try {
      await _dio.post('/chat/send', data: jsonEncode({
        'matchId': matchId, 'content': content.trim(), 'msgType': 1,
      }));
      // 立即刷新消息列表
      final messages = await _fetchHistory(matchId);
      state = ChatState.ready(messages: messages, connected: true);
    } catch (_) {}
  }

  Future<List<ChatMessage>> _fetchHistory(int matchId) async {
    final response = await _dio.get('/chat/history/$matchId');
    final list = response.data['data'] as List<dynamic>;
    return list
        .map((j) => ChatMessage.fromJson(j as Map<String, dynamic>))
        .toList();
  }

  void _startPolling(int matchId) {
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(const Duration(seconds: 5), (_) async {
      try {
        final messages = await _fetchHistory(matchId);
        final current = state;
        if (current is ChatReady && messages.length != current.messages.length) {
          state = current.copyWith(messages: messages);
        }
      } catch (_) {}
    });
  }

  void dispose() {
    _pollTimer?.cancel();
  }
}

final chatViewModelProvider =
    NotifierProvider<ChatViewModel, ChatState>(ChatViewModel.new);
