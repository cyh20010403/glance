import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

/// 聊天消息模型
@freezed
sealed class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required int id,
    required int matchId,
    required int senderId,
    required int receiverId,
    required String content,
    @Default(1) int msgType,    // 1-文本 2-Emoji
    required String createdAt,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  const ChatMessage._();
}
