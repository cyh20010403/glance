// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChatState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<ChatMessage> messages, bool connected) ready,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<ChatMessage> messages, bool connected)? ready,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<ChatMessage> messages, bool connected)? ready,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatLoading value) loading,
    required TResult Function(ChatReady value) ready,
    required TResult Function(ChatError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatLoading value)? loading,
    TResult? Function(ChatReady value)? ready,
    TResult? Function(ChatError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatLoading value)? loading,
    TResult Function(ChatReady value)? ready,
    TResult Function(ChatError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatStateCopyWith<$Res> {
  factory $ChatStateCopyWith(ChatState value, $Res Function(ChatState) then) =
      _$ChatStateCopyWithImpl<$Res, ChatState>;
}

/// @nodoc
class _$ChatStateCopyWithImpl<$Res, $Val extends ChatState>
    implements $ChatStateCopyWith<$Res> {
  _$ChatStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ChatLoadingImplCopyWith<$Res> {
  factory _$$ChatLoadingImplCopyWith(
          _$ChatLoadingImpl value, $Res Function(_$ChatLoadingImpl) then) =
      __$$ChatLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ChatLoadingImplCopyWithImpl<$Res>
    extends _$ChatStateCopyWithImpl<$Res, _$ChatLoadingImpl>
    implements _$$ChatLoadingImplCopyWith<$Res> {
  __$$ChatLoadingImplCopyWithImpl(
      _$ChatLoadingImpl _value, $Res Function(_$ChatLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ChatLoadingImpl implements ChatLoading {
  const _$ChatLoadingImpl();

  @override
  String toString() {
    return 'ChatState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ChatLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<ChatMessage> messages, bool connected) ready,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<ChatMessage> messages, bool connected)? ready,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<ChatMessage> messages, bool connected)? ready,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatLoading value) loading,
    required TResult Function(ChatReady value) ready,
    required TResult Function(ChatError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatLoading value)? loading,
    TResult? Function(ChatReady value)? ready,
    TResult? Function(ChatError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatLoading value)? loading,
    TResult Function(ChatReady value)? ready,
    TResult Function(ChatError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ChatLoading implements ChatState {
  const factory ChatLoading() = _$ChatLoadingImpl;
}

/// @nodoc
abstract class _$$ChatReadyImplCopyWith<$Res> {
  factory _$$ChatReadyImplCopyWith(
          _$ChatReadyImpl value, $Res Function(_$ChatReadyImpl) then) =
      __$$ChatReadyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<ChatMessage> messages, bool connected});
}

/// @nodoc
class __$$ChatReadyImplCopyWithImpl<$Res>
    extends _$ChatStateCopyWithImpl<$Res, _$ChatReadyImpl>
    implements _$$ChatReadyImplCopyWith<$Res> {
  __$$ChatReadyImplCopyWithImpl(
      _$ChatReadyImpl _value, $Res Function(_$ChatReadyImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? connected = null,
  }) {
    return _then(_$ChatReadyImpl(
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<ChatMessage>,
      connected: null == connected
          ? _value.connected
          : connected // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ChatReadyImpl implements ChatReady {
  const _$ChatReadyImpl(
      {required final List<ChatMessage> messages, this.connected = false})
      : _messages = messages;

  final List<ChatMessage> _messages;
  @override
  List<ChatMessage> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  @JsonKey()
  final bool connected;

  @override
  String toString() {
    return 'ChatState.ready(messages: $messages, connected: $connected)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatReadyImpl &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.connected, connected) ||
                other.connected == connected));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_messages), connected);

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatReadyImplCopyWith<_$ChatReadyImpl> get copyWith =>
      __$$ChatReadyImplCopyWithImpl<_$ChatReadyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<ChatMessage> messages, bool connected) ready,
    required TResult Function(String message) error,
  }) {
    return ready(messages, connected);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<ChatMessage> messages, bool connected)? ready,
    TResult? Function(String message)? error,
  }) {
    return ready?.call(messages, connected);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<ChatMessage> messages, bool connected)? ready,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(messages, connected);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatLoading value) loading,
    required TResult Function(ChatReady value) ready,
    required TResult Function(ChatError value) error,
  }) {
    return ready(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatLoading value)? loading,
    TResult? Function(ChatReady value)? ready,
    TResult? Function(ChatError value)? error,
  }) {
    return ready?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatLoading value)? loading,
    TResult Function(ChatReady value)? ready,
    TResult Function(ChatError value)? error,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(this);
    }
    return orElse();
  }
}

abstract class ChatReady implements ChatState {
  const factory ChatReady(
      {required final List<ChatMessage> messages,
      final bool connected}) = _$ChatReadyImpl;

  List<ChatMessage> get messages;
  bool get connected;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatReadyImplCopyWith<_$ChatReadyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChatErrorImplCopyWith<$Res> {
  factory _$$ChatErrorImplCopyWith(
          _$ChatErrorImpl value, $Res Function(_$ChatErrorImpl) then) =
      __$$ChatErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ChatErrorImplCopyWithImpl<$Res>
    extends _$ChatStateCopyWithImpl<$Res, _$ChatErrorImpl>
    implements _$$ChatErrorImplCopyWith<$Res> {
  __$$ChatErrorImplCopyWithImpl(
      _$ChatErrorImpl _value, $Res Function(_$ChatErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ChatErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ChatErrorImpl implements ChatError {
  const _$ChatErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'ChatState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatErrorImplCopyWith<_$ChatErrorImpl> get copyWith =>
      __$$ChatErrorImplCopyWithImpl<_$ChatErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<ChatMessage> messages, bool connected) ready,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<ChatMessage> messages, bool connected)? ready,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<ChatMessage> messages, bool connected)? ready,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatLoading value) loading,
    required TResult Function(ChatReady value) ready,
    required TResult Function(ChatError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatLoading value)? loading,
    TResult? Function(ChatReady value)? ready,
    TResult? Function(ChatError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatLoading value)? loading,
    TResult Function(ChatReady value)? ready,
    TResult Function(ChatError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ChatError implements ChatState {
  const factory ChatError({required final String message}) = _$ChatErrorImpl;

  String get message;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatErrorImplCopyWith<_$ChatErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
