// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  return _ChatMessage.fromJson(json);
}

/// @nodoc
mixin _$ChatMessage {
  int get id => throw _privateConstructorUsedError;
  int get matchId => throw _privateConstructorUsedError;
  int get senderId => throw _privateConstructorUsedError;
  int get receiverId => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  int get msgType => throw _privateConstructorUsedError; // 1-文本 2-Emoji
  String get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ChatMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatMessageCopyWith<ChatMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageCopyWith<$Res> {
  factory $ChatMessageCopyWith(
          ChatMessage value, $Res Function(ChatMessage) then) =
      _$ChatMessageCopyWithImpl<$Res, ChatMessage>;
  @useResult
  $Res call(
      {int id,
      int matchId,
      int senderId,
      int receiverId,
      String content,
      int msgType,
      String createdAt});
}

/// @nodoc
class _$ChatMessageCopyWithImpl<$Res, $Val extends ChatMessage>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? matchId = null,
    Object? senderId = null,
    Object? receiverId = null,
    Object? content = null,
    Object? msgType = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      matchId: null == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as int,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as int,
      receiverId: null == receiverId
          ? _value.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      msgType: null == msgType
          ? _value.msgType
          : msgType // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatMessageImplCopyWith<$Res>
    implements $ChatMessageCopyWith<$Res> {
  factory _$$ChatMessageImplCopyWith(
          _$ChatMessageImpl value, $Res Function(_$ChatMessageImpl) then) =
      __$$ChatMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int matchId,
      int senderId,
      int receiverId,
      String content,
      int msgType,
      String createdAt});
}

/// @nodoc
class __$$ChatMessageImplCopyWithImpl<$Res>
    extends _$ChatMessageCopyWithImpl<$Res, _$ChatMessageImpl>
    implements _$$ChatMessageImplCopyWith<$Res> {
  __$$ChatMessageImplCopyWithImpl(
      _$ChatMessageImpl _value, $Res Function(_$ChatMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? matchId = null,
    Object? senderId = null,
    Object? receiverId = null,
    Object? content = null,
    Object? msgType = null,
    Object? createdAt = null,
  }) {
    return _then(_$ChatMessageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      matchId: null == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as int,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as int,
      receiverId: null == receiverId
          ? _value.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      msgType: null == msgType
          ? _value.msgType
          : msgType // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageImpl extends _ChatMessage {
  const _$ChatMessageImpl(
      {required this.id,
      required this.matchId,
      required this.senderId,
      required this.receiverId,
      required this.content,
      this.msgType = 1,
      required this.createdAt})
      : super._();

  factory _$ChatMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageImplFromJson(json);

  @override
  final int id;
  @override
  final int matchId;
  @override
  final int senderId;
  @override
  final int receiverId;
  @override
  final String content;
  @override
  @JsonKey()
  final int msgType;
// 1-文本 2-Emoji
  @override
  final String createdAt;

  @override
  String toString() {
    return 'ChatMessage(id: $id, matchId: $matchId, senderId: $senderId, receiverId: $receiverId, content: $content, msgType: $msgType, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.matchId, matchId) || other.matchId == matchId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.receiverId, receiverId) ||
                other.receiverId == receiverId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.msgType, msgType) || other.msgType == msgType) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, matchId, senderId,
      receiverId, content, msgType, createdAt);

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      __$$ChatMessageImplCopyWithImpl<_$ChatMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageImplToJson(
      this,
    );
  }
}

abstract class _ChatMessage extends ChatMessage {
  const factory _ChatMessage(
      {required final int id,
      required final int matchId,
      required final int senderId,
      required final int receiverId,
      required final String content,
      final int msgType,
      required final String createdAt}) = _$ChatMessageImpl;
  const _ChatMessage._() : super._();

  factory _ChatMessage.fromJson(Map<String, dynamic> json) =
      _$ChatMessageImpl.fromJson;

  @override
  int get id;
  @override
  int get matchId;
  @override
  int get senderId;
  @override
  int get receiverId;
  @override
  String get content;
  @override
  int get msgType; // 1-文本 2-Emoji
  @override
  String get createdAt;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
