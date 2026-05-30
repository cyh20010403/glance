// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatMessageImpl _$$ChatMessageImplFromJson(Map<String, dynamic> json) =>
    _$ChatMessageImpl(
      id: (json['id'] as num).toInt(),
      matchId: (json['matchId'] as num).toInt(),
      senderId: (json['senderId'] as num).toInt(),
      receiverId: (json['receiverId'] as num).toInt(),
      content: json['content'] as String,
      msgType: (json['msgType'] as num?)?.toInt() ?? 1,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$$ChatMessageImplToJson(_$ChatMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'matchId': instance.matchId,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'content': instance.content,
      'msgType': instance.msgType,
      'createdAt': instance.createdAt,
    };
