// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MatchState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() trying,
    required TResult Function(MatchRecord record) matched,
    required TResult Function(String message) pending,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? trying,
    TResult? Function(MatchRecord record)? matched,
    TResult? Function(String message)? pending,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? trying,
    TResult Function(MatchRecord record)? matched,
    TResult Function(String message)? pending,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MatchIdle value) idle,
    required TResult Function(MatchTrying value) trying,
    required TResult Function(MatchMatched value) matched,
    required TResult Function(MatchPending value) pending,
    required TResult Function(MatchError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MatchIdle value)? idle,
    TResult? Function(MatchTrying value)? trying,
    TResult? Function(MatchMatched value)? matched,
    TResult? Function(MatchPending value)? pending,
    TResult? Function(MatchError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MatchIdle value)? idle,
    TResult Function(MatchTrying value)? trying,
    TResult Function(MatchMatched value)? matched,
    TResult Function(MatchPending value)? pending,
    TResult Function(MatchError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchStateCopyWith<$Res> {
  factory $MatchStateCopyWith(
          MatchState value, $Res Function(MatchState) then) =
      _$MatchStateCopyWithImpl<$Res, MatchState>;
}

/// @nodoc
class _$MatchStateCopyWithImpl<$Res, $Val extends MatchState>
    implements $MatchStateCopyWith<$Res> {
  _$MatchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MatchState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$MatchIdleImplCopyWith<$Res> {
  factory _$$MatchIdleImplCopyWith(
          _$MatchIdleImpl value, $Res Function(_$MatchIdleImpl) then) =
      __$$MatchIdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MatchIdleImplCopyWithImpl<$Res>
    extends _$MatchStateCopyWithImpl<$Res, _$MatchIdleImpl>
    implements _$$MatchIdleImplCopyWith<$Res> {
  __$$MatchIdleImplCopyWithImpl(
      _$MatchIdleImpl _value, $Res Function(_$MatchIdleImpl) _then)
      : super(_value, _then);

  /// Create a copy of MatchState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$MatchIdleImpl implements MatchIdle {
  const _$MatchIdleImpl();

  @override
  String toString() {
    return 'MatchState.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MatchIdleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() trying,
    required TResult Function(MatchRecord record) matched,
    required TResult Function(String message) pending,
    required TResult Function(String message) error,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? trying,
    TResult? Function(MatchRecord record)? matched,
    TResult? Function(String message)? pending,
    TResult? Function(String message)? error,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? trying,
    TResult Function(MatchRecord record)? matched,
    TResult Function(String message)? pending,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MatchIdle value) idle,
    required TResult Function(MatchTrying value) trying,
    required TResult Function(MatchMatched value) matched,
    required TResult Function(MatchPending value) pending,
    required TResult Function(MatchError value) error,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MatchIdle value)? idle,
    TResult? Function(MatchTrying value)? trying,
    TResult? Function(MatchMatched value)? matched,
    TResult? Function(MatchPending value)? pending,
    TResult? Function(MatchError value)? error,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MatchIdle value)? idle,
    TResult Function(MatchTrying value)? trying,
    TResult Function(MatchMatched value)? matched,
    TResult Function(MatchPending value)? pending,
    TResult Function(MatchError value)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class MatchIdle implements MatchState {
  const factory MatchIdle() = _$MatchIdleImpl;
}

/// @nodoc
abstract class _$$MatchTryingImplCopyWith<$Res> {
  factory _$$MatchTryingImplCopyWith(
          _$MatchTryingImpl value, $Res Function(_$MatchTryingImpl) then) =
      __$$MatchTryingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MatchTryingImplCopyWithImpl<$Res>
    extends _$MatchStateCopyWithImpl<$Res, _$MatchTryingImpl>
    implements _$$MatchTryingImplCopyWith<$Res> {
  __$$MatchTryingImplCopyWithImpl(
      _$MatchTryingImpl _value, $Res Function(_$MatchTryingImpl) _then)
      : super(_value, _then);

  /// Create a copy of MatchState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$MatchTryingImpl implements MatchTrying {
  const _$MatchTryingImpl();

  @override
  String toString() {
    return 'MatchState.trying()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MatchTryingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() trying,
    required TResult Function(MatchRecord record) matched,
    required TResult Function(String message) pending,
    required TResult Function(String message) error,
  }) {
    return trying();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? trying,
    TResult? Function(MatchRecord record)? matched,
    TResult? Function(String message)? pending,
    TResult? Function(String message)? error,
  }) {
    return trying?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? trying,
    TResult Function(MatchRecord record)? matched,
    TResult Function(String message)? pending,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (trying != null) {
      return trying();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MatchIdle value) idle,
    required TResult Function(MatchTrying value) trying,
    required TResult Function(MatchMatched value) matched,
    required TResult Function(MatchPending value) pending,
    required TResult Function(MatchError value) error,
  }) {
    return trying(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MatchIdle value)? idle,
    TResult? Function(MatchTrying value)? trying,
    TResult? Function(MatchMatched value)? matched,
    TResult? Function(MatchPending value)? pending,
    TResult? Function(MatchError value)? error,
  }) {
    return trying?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MatchIdle value)? idle,
    TResult Function(MatchTrying value)? trying,
    TResult Function(MatchMatched value)? matched,
    TResult Function(MatchPending value)? pending,
    TResult Function(MatchError value)? error,
    required TResult orElse(),
  }) {
    if (trying != null) {
      return trying(this);
    }
    return orElse();
  }
}

abstract class MatchTrying implements MatchState {
  const factory MatchTrying() = _$MatchTryingImpl;
}

/// @nodoc
abstract class _$$MatchMatchedImplCopyWith<$Res> {
  factory _$$MatchMatchedImplCopyWith(
          _$MatchMatchedImpl value, $Res Function(_$MatchMatchedImpl) then) =
      __$$MatchMatchedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({MatchRecord record});

  $MatchRecordCopyWith<$Res> get record;
}

/// @nodoc
class __$$MatchMatchedImplCopyWithImpl<$Res>
    extends _$MatchStateCopyWithImpl<$Res, _$MatchMatchedImpl>
    implements _$$MatchMatchedImplCopyWith<$Res> {
  __$$MatchMatchedImplCopyWithImpl(
      _$MatchMatchedImpl _value, $Res Function(_$MatchMatchedImpl) _then)
      : super(_value, _then);

  /// Create a copy of MatchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? record = null,
  }) {
    return _then(_$MatchMatchedImpl(
      record: null == record
          ? _value.record
          : record // ignore: cast_nullable_to_non_nullable
              as MatchRecord,
    ));
  }

  /// Create a copy of MatchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MatchRecordCopyWith<$Res> get record {
    return $MatchRecordCopyWith<$Res>(_value.record, (value) {
      return _then(_value.copyWith(record: value));
    });
  }
}

/// @nodoc

class _$MatchMatchedImpl implements MatchMatched {
  const _$MatchMatchedImpl({required this.record});

  @override
  final MatchRecord record;

  @override
  String toString() {
    return 'MatchState.matched(record: $record)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchMatchedImpl &&
            (identical(other.record, record) || other.record == record));
  }

  @override
  int get hashCode => Object.hash(runtimeType, record);

  /// Create a copy of MatchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchMatchedImplCopyWith<_$MatchMatchedImpl> get copyWith =>
      __$$MatchMatchedImplCopyWithImpl<_$MatchMatchedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() trying,
    required TResult Function(MatchRecord record) matched,
    required TResult Function(String message) pending,
    required TResult Function(String message) error,
  }) {
    return matched(record);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? trying,
    TResult? Function(MatchRecord record)? matched,
    TResult? Function(String message)? pending,
    TResult? Function(String message)? error,
  }) {
    return matched?.call(record);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? trying,
    TResult Function(MatchRecord record)? matched,
    TResult Function(String message)? pending,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (matched != null) {
      return matched(record);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MatchIdle value) idle,
    required TResult Function(MatchTrying value) trying,
    required TResult Function(MatchMatched value) matched,
    required TResult Function(MatchPending value) pending,
    required TResult Function(MatchError value) error,
  }) {
    return matched(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MatchIdle value)? idle,
    TResult? Function(MatchTrying value)? trying,
    TResult? Function(MatchMatched value)? matched,
    TResult? Function(MatchPending value)? pending,
    TResult? Function(MatchError value)? error,
  }) {
    return matched?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MatchIdle value)? idle,
    TResult Function(MatchTrying value)? trying,
    TResult Function(MatchMatched value)? matched,
    TResult Function(MatchPending value)? pending,
    TResult Function(MatchError value)? error,
    required TResult orElse(),
  }) {
    if (matched != null) {
      return matched(this);
    }
    return orElse();
  }
}

abstract class MatchMatched implements MatchState {
  const factory MatchMatched({required final MatchRecord record}) =
      _$MatchMatchedImpl;

  MatchRecord get record;

  /// Create a copy of MatchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MatchMatchedImplCopyWith<_$MatchMatchedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MatchPendingImplCopyWith<$Res> {
  factory _$$MatchPendingImplCopyWith(
          _$MatchPendingImpl value, $Res Function(_$MatchPendingImpl) then) =
      __$$MatchPendingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$MatchPendingImplCopyWithImpl<$Res>
    extends _$MatchStateCopyWithImpl<$Res, _$MatchPendingImpl>
    implements _$$MatchPendingImplCopyWith<$Res> {
  __$$MatchPendingImplCopyWithImpl(
      _$MatchPendingImpl _value, $Res Function(_$MatchPendingImpl) _then)
      : super(_value, _then);

  /// Create a copy of MatchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$MatchPendingImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MatchPendingImpl implements MatchPending {
  const _$MatchPendingImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'MatchState.pending(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchPendingImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of MatchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchPendingImplCopyWith<_$MatchPendingImpl> get copyWith =>
      __$$MatchPendingImplCopyWithImpl<_$MatchPendingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() trying,
    required TResult Function(MatchRecord record) matched,
    required TResult Function(String message) pending,
    required TResult Function(String message) error,
  }) {
    return pending(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? trying,
    TResult? Function(MatchRecord record)? matched,
    TResult? Function(String message)? pending,
    TResult? Function(String message)? error,
  }) {
    return pending?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? trying,
    TResult Function(MatchRecord record)? matched,
    TResult Function(String message)? pending,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (pending != null) {
      return pending(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MatchIdle value) idle,
    required TResult Function(MatchTrying value) trying,
    required TResult Function(MatchMatched value) matched,
    required TResult Function(MatchPending value) pending,
    required TResult Function(MatchError value) error,
  }) {
    return pending(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MatchIdle value)? idle,
    TResult? Function(MatchTrying value)? trying,
    TResult? Function(MatchMatched value)? matched,
    TResult? Function(MatchPending value)? pending,
    TResult? Function(MatchError value)? error,
  }) {
    return pending?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MatchIdle value)? idle,
    TResult Function(MatchTrying value)? trying,
    TResult Function(MatchMatched value)? matched,
    TResult Function(MatchPending value)? pending,
    TResult Function(MatchError value)? error,
    required TResult orElse(),
  }) {
    if (pending != null) {
      return pending(this);
    }
    return orElse();
  }
}

abstract class MatchPending implements MatchState {
  const factory MatchPending({required final String message}) =
      _$MatchPendingImpl;

  String get message;

  /// Create a copy of MatchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MatchPendingImplCopyWith<_$MatchPendingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MatchErrorImplCopyWith<$Res> {
  factory _$$MatchErrorImplCopyWith(
          _$MatchErrorImpl value, $Res Function(_$MatchErrorImpl) then) =
      __$$MatchErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$MatchErrorImplCopyWithImpl<$Res>
    extends _$MatchStateCopyWithImpl<$Res, _$MatchErrorImpl>
    implements _$$MatchErrorImplCopyWith<$Res> {
  __$$MatchErrorImplCopyWithImpl(
      _$MatchErrorImpl _value, $Res Function(_$MatchErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of MatchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$MatchErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MatchErrorImpl implements MatchError {
  const _$MatchErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'MatchState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of MatchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchErrorImplCopyWith<_$MatchErrorImpl> get copyWith =>
      __$$MatchErrorImplCopyWithImpl<_$MatchErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() trying,
    required TResult Function(MatchRecord record) matched,
    required TResult Function(String message) pending,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? trying,
    TResult? Function(MatchRecord record)? matched,
    TResult? Function(String message)? pending,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? trying,
    TResult Function(MatchRecord record)? matched,
    TResult Function(String message)? pending,
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
    required TResult Function(MatchIdle value) idle,
    required TResult Function(MatchTrying value) trying,
    required TResult Function(MatchMatched value) matched,
    required TResult Function(MatchPending value) pending,
    required TResult Function(MatchError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MatchIdle value)? idle,
    TResult? Function(MatchTrying value)? trying,
    TResult? Function(MatchMatched value)? matched,
    TResult? Function(MatchPending value)? pending,
    TResult? Function(MatchError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MatchIdle value)? idle,
    TResult Function(MatchTrying value)? trying,
    TResult Function(MatchMatched value)? matched,
    TResult Function(MatchPending value)? pending,
    TResult Function(MatchError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class MatchError implements MatchState {
  const factory MatchError({required final String message}) = _$MatchErrorImpl;

  String get message;

  /// Create a copy of MatchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MatchErrorImplCopyWith<_$MatchErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
