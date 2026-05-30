// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mood_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MoodState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String? mood) loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String? mood)? loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String? mood)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MoodInitial value) initial,
    required TResult Function(MoodLoading value) loading,
    required TResult Function(MoodLoaded value) loaded,
    required TResult Function(MoodError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MoodInitial value)? initial,
    TResult? Function(MoodLoading value)? loading,
    TResult? Function(MoodLoaded value)? loaded,
    TResult? Function(MoodError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MoodInitial value)? initial,
    TResult Function(MoodLoading value)? loading,
    TResult Function(MoodLoaded value)? loaded,
    TResult Function(MoodError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoodStateCopyWith<$Res> {
  factory $MoodStateCopyWith(MoodState value, $Res Function(MoodState) then) =
      _$MoodStateCopyWithImpl<$Res, MoodState>;
}

/// @nodoc
class _$MoodStateCopyWithImpl<$Res, $Val extends MoodState>
    implements $MoodStateCopyWith<$Res> {
  _$MoodStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MoodState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$MoodInitialImplCopyWith<$Res> {
  factory _$$MoodInitialImplCopyWith(
          _$MoodInitialImpl value, $Res Function(_$MoodInitialImpl) then) =
      __$$MoodInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MoodInitialImplCopyWithImpl<$Res>
    extends _$MoodStateCopyWithImpl<$Res, _$MoodInitialImpl>
    implements _$$MoodInitialImplCopyWith<$Res> {
  __$$MoodInitialImplCopyWithImpl(
      _$MoodInitialImpl _value, $Res Function(_$MoodInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of MoodState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$MoodInitialImpl implements MoodInitial {
  const _$MoodInitialImpl();

  @override
  String toString() {
    return 'MoodState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MoodInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String? mood) loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String? mood)? loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String? mood)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MoodInitial value) initial,
    required TResult Function(MoodLoading value) loading,
    required TResult Function(MoodLoaded value) loaded,
    required TResult Function(MoodError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MoodInitial value)? initial,
    TResult? Function(MoodLoading value)? loading,
    TResult? Function(MoodLoaded value)? loaded,
    TResult? Function(MoodError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MoodInitial value)? initial,
    TResult Function(MoodLoading value)? loading,
    TResult Function(MoodLoaded value)? loaded,
    TResult Function(MoodError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class MoodInitial implements MoodState {
  const factory MoodInitial() = _$MoodInitialImpl;
}

/// @nodoc
abstract class _$$MoodLoadingImplCopyWith<$Res> {
  factory _$$MoodLoadingImplCopyWith(
          _$MoodLoadingImpl value, $Res Function(_$MoodLoadingImpl) then) =
      __$$MoodLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MoodLoadingImplCopyWithImpl<$Res>
    extends _$MoodStateCopyWithImpl<$Res, _$MoodLoadingImpl>
    implements _$$MoodLoadingImplCopyWith<$Res> {
  __$$MoodLoadingImplCopyWithImpl(
      _$MoodLoadingImpl _value, $Res Function(_$MoodLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of MoodState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$MoodLoadingImpl implements MoodLoading {
  const _$MoodLoadingImpl();

  @override
  String toString() {
    return 'MoodState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MoodLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String? mood) loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String? mood)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String? mood)? loaded,
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
    required TResult Function(MoodInitial value) initial,
    required TResult Function(MoodLoading value) loading,
    required TResult Function(MoodLoaded value) loaded,
    required TResult Function(MoodError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MoodInitial value)? initial,
    TResult? Function(MoodLoading value)? loading,
    TResult? Function(MoodLoaded value)? loaded,
    TResult? Function(MoodError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MoodInitial value)? initial,
    TResult Function(MoodLoading value)? loading,
    TResult Function(MoodLoaded value)? loaded,
    TResult Function(MoodError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class MoodLoading implements MoodState {
  const factory MoodLoading() = _$MoodLoadingImpl;
}

/// @nodoc
abstract class _$$MoodLoadedImplCopyWith<$Res> {
  factory _$$MoodLoadedImplCopyWith(
          _$MoodLoadedImpl value, $Res Function(_$MoodLoadedImpl) then) =
      __$$MoodLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? mood});
}

/// @nodoc
class __$$MoodLoadedImplCopyWithImpl<$Res>
    extends _$MoodStateCopyWithImpl<$Res, _$MoodLoadedImpl>
    implements _$$MoodLoadedImplCopyWith<$Res> {
  __$$MoodLoadedImplCopyWithImpl(
      _$MoodLoadedImpl _value, $Res Function(_$MoodLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of MoodState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mood = freezed,
  }) {
    return _then(_$MoodLoadedImpl(
      mood: freezed == mood
          ? _value.mood
          : mood // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$MoodLoadedImpl implements MoodLoaded {
  const _$MoodLoadedImpl({this.mood});

  @override
  final String? mood;

  @override
  String toString() {
    return 'MoodState.loaded(mood: $mood)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MoodLoadedImpl &&
            (identical(other.mood, mood) || other.mood == mood));
  }

  @override
  int get hashCode => Object.hash(runtimeType, mood);

  /// Create a copy of MoodState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MoodLoadedImplCopyWith<_$MoodLoadedImpl> get copyWith =>
      __$$MoodLoadedImplCopyWithImpl<_$MoodLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String? mood) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(mood);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String? mood)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(mood);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String? mood)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(mood);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MoodInitial value) initial,
    required TResult Function(MoodLoading value) loading,
    required TResult Function(MoodLoaded value) loaded,
    required TResult Function(MoodError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MoodInitial value)? initial,
    TResult? Function(MoodLoading value)? loading,
    TResult? Function(MoodLoaded value)? loaded,
    TResult? Function(MoodError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MoodInitial value)? initial,
    TResult Function(MoodLoading value)? loading,
    TResult Function(MoodLoaded value)? loaded,
    TResult Function(MoodError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class MoodLoaded implements MoodState {
  const factory MoodLoaded({final String? mood}) = _$MoodLoadedImpl;

  String? get mood;

  /// Create a copy of MoodState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MoodLoadedImplCopyWith<_$MoodLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MoodErrorImplCopyWith<$Res> {
  factory _$$MoodErrorImplCopyWith(
          _$MoodErrorImpl value, $Res Function(_$MoodErrorImpl) then) =
      __$$MoodErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$MoodErrorImplCopyWithImpl<$Res>
    extends _$MoodStateCopyWithImpl<$Res, _$MoodErrorImpl>
    implements _$$MoodErrorImplCopyWith<$Res> {
  __$$MoodErrorImplCopyWithImpl(
      _$MoodErrorImpl _value, $Res Function(_$MoodErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of MoodState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$MoodErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MoodErrorImpl implements MoodError {
  const _$MoodErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'MoodState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MoodErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of MoodState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MoodErrorImplCopyWith<_$MoodErrorImpl> get copyWith =>
      __$$MoodErrorImplCopyWithImpl<_$MoodErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String? mood) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String? mood)? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String? mood)? loaded,
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
    required TResult Function(MoodInitial value) initial,
    required TResult Function(MoodLoading value) loading,
    required TResult Function(MoodLoaded value) loaded,
    required TResult Function(MoodError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MoodInitial value)? initial,
    TResult? Function(MoodLoading value)? loading,
    TResult? Function(MoodLoaded value)? loaded,
    TResult? Function(MoodError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MoodInitial value)? initial,
    TResult Function(MoodLoading value)? loading,
    TResult Function(MoodLoaded value)? loaded,
    TResult Function(MoodError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class MoodError implements MoodState {
  const factory MoodError({required final String message}) = _$MoodErrorImpl;

  String get message;

  /// Create a copy of MoodState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MoodErrorImplCopyWith<_$MoodErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
