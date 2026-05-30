import 'package:freezed_annotation/freezed_annotation.dart';
import 'chat_message.dart';

part 'chat_state.freezed.dart';

/// 聊天页面状态
@freezed
sealed class ChatState with _$ChatState {
  /// 初始加载中
  const factory ChatState.loading() = ChatLoading;

  /// 聊天就绪
  const factory ChatState.ready({
    required List<ChatMessage> messages,
    @Default(false) bool connected,
  }) = ChatReady;

  /// 加载失败
  const factory ChatState.error({required String message}) = ChatError;
}
