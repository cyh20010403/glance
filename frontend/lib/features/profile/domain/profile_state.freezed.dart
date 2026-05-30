// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProfileState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(String nickname, String signature, int matchCount)
        loaded,
    required TResult Function(String message) actionSuccess,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(String nickname, String signature, int matchCount)?
        loaded,
    TResult? Function(String message)? actionSuccess,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(String nickname, String signature, int matchCount)? loaded,
    TResult Function(String message)? actionSuccess,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProfileIdle value) idle,
    required TResult Function(ProfileLoading value) loading,
    required TResult Function(ProfileLoaded value) loaded,
    required TResult Function(ProfileActionSuccess value) actionSuccess,
    required TResult Function(ProfileError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProfileIdle value)? idle,
    TResult? Function(ProfileLoading value)? loading,
    TResult? Function(ProfileLoaded value)? loaded,
    TResult? Function(ProfileActionSuccess value)? actionSuccess,
    TResult? Function(ProfileError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileIdle value)? idle,
    TResult Function(ProfileLoading value)? loading,
    TResult Function(ProfileLoaded value)? loaded,
    TResult Function(ProfileActionSuccess value)? actionSuccess,
    TResult Function(ProfileError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileStateCopyWith<$Res> {
  factory $ProfileStateCopyWith(
          ProfileState value, $Res Function(ProfileState) then) =
      _$ProfileStateCopyWithImpl<$Res, ProfileState>;
}

/// @nodoc
class _$ProfileStateCopyWithImpl<$Res, $Val extends ProfileState>
    implements $ProfileStateCopyWith<$Res> {
  _$ProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ProfileIdleImplCopyWith<$Res> {
  factory _$$ProfileIdleImplCopyWith(
          _$ProfileIdleImpl value, $Res Function(_$ProfileIdleImpl) then) =
      __$$ProfileIdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ProfileIdleImplCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res, _$ProfileIdleImpl>
    implements _$$ProfileIdleImplCopyWith<$Res> {
  __$$ProfileIdleImplCopyWithImpl(
      _$ProfileIdleImpl _value, $Res Function(_$ProfileIdleImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ProfileIdleImpl implements ProfileIdle {
  const _$ProfileIdleImpl();

  @override
  String toString() {
    return 'ProfileState.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ProfileIdleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(String nickname, String signature, int matchCount)
        loaded,
    required TResult Function(String message) actionSuccess,
    required TResult Function(String message) error,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(String nickname, String signature, int matchCount)?
        loaded,
    TResult? Function(String message)? actionSuccess,
    TResult? Function(String message)? error,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(String nickname, String signature, int matchCount)? loaded,
    TResult Function(String message)? actionSuccess,
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
    required TResult Function(ProfileIdle value) idle,
    required TResult Function(ProfileLoading value) loading,
    required TResult Function(ProfileLoaded value) loaded,
    required TResult Function(ProfileActionSuccess value) actionSuccess,
    required TResult Function(ProfileError value) error,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProfileIdle value)? idle,
    TResult? Function(ProfileLoading value)? loading,
    TResult? Function(ProfileLoaded value)? loaded,
    TResult? Function(ProfileActionSuccess value)? actionSuccess,
    TResult? Function(ProfileError value)? error,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileIdle value)? idle,
    TResult Function(ProfileLoading value)? loading,
    TResult Function(ProfileLoaded value)? loaded,
    TResult Function(ProfileActionSuccess value)? actionSuccess,
    TResult Function(ProfileError value)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class ProfileIdle implements ProfileState {
  const factory ProfileIdle() = _$ProfileIdleImpl;
}

/// @nodoc
abstract class _$$ProfileLoadingImplCopyWith<$Res> {
  factory _$$ProfileLoadingImplCopyWith(_$ProfileLoadingImpl value,
          $Res Function(_$ProfileLoadingImpl) then) =
      __$$ProfileLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ProfileLoadingImplCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res, _$ProfileLoadingImpl>
    implements _$$ProfileLoadingImplCopyWith<$Res> {
  __$$ProfileLoadingImplCopyWithImpl(
      _$ProfileLoadingImpl _value, $Res Function(_$ProfileLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ProfileLoadingImpl implements ProfileLoading {
  const _$ProfileLoadingImpl();

  @override
  String toString() {
    return 'ProfileState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ProfileLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(String nickname, String signature, int matchCount)
        loaded,
    required TResult Function(String message) actionSuccess,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(String nickname, String signature, int matchCount)?
        loaded,
    TResult? Function(String message)? actionSuccess,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(String nickname, String signature, int matchCount)? loaded,
    TResult Function(String message)? actionSuccess,
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
    required TResult Function(ProfileIdle value) idle,
    required TResult Function(ProfileLoading value) loading,
    required TResult Function(ProfileLoaded value) loaded,
    required TResult Function(ProfileActionSuccess value) actionSuccess,
    required TResult Function(ProfileError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProfileIdle value)? idle,
    TResult? Function(ProfileLoading value)? loading,
    TResult? Function(ProfileLoaded value)? loaded,
    TResult? Function(ProfileActionSuccess value)? actionSuccess,
    TResult? Function(ProfileError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileIdle value)? idle,
    TResult Function(ProfileLoading value)? loading,
    TResult Function(ProfileLoaded value)? loaded,
    TResult Function(ProfileActionSuccess value)? actionSuccess,
    TResult Function(ProfileError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ProfileLoading implements ProfileState {
  const factory ProfileLoading() = _$ProfileLoadingImpl;
}

/// @nodoc
abstract class _$$ProfileLoadedImplCopyWith<$Res> {
  factory _$$ProfileLoadedImplCopyWith(
          _$ProfileLoadedImpl value, $Res Function(_$ProfileLoadedImpl) then) =
      __$$ProfileLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String nickname, String signature, int matchCount});
}

/// @nodoc
class __$$ProfileLoadedImplCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res, _$ProfileLoadedImpl>
    implements _$$ProfileLoadedImplCopyWith<$Res> {
  __$$ProfileLoadedImplCopyWithImpl(
      _$ProfileLoadedImpl _value, $Res Function(_$ProfileLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nickname = null,
    Object? signature = null,
    Object? matchCount = null,
  }) {
    return _then(_$ProfileLoadedImpl(
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      signature: null == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String,
      matchCount: null == matchCount
          ? _value.matchCount
          : matchCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ProfileLoadedImpl implements ProfileLoaded {
  const _$ProfileLoadedImpl(
      {required this.nickname, this.signature = '', this.matchCount = 0});

  @override
  final String nickname;
  @override
  @JsonKey()
  final String signature;
  @override
  @JsonKey()
  final int matchCount;

  @override
  String toString() {
    return 'ProfileState.loaded(nickname: $nickname, signature: $signature, matchCount: $matchCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileLoadedImpl &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.signature, signature) ||
                other.signature == signature) &&
            (identical(other.matchCount, matchCount) ||
                other.matchCount == matchCount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, nickname, signature, matchCount);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileLoadedImplCopyWith<_$ProfileLoadedImpl> get copyWith =>
      __$$ProfileLoadedImplCopyWithImpl<_$ProfileLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(String nickname, String signature, int matchCount)
        loaded,
    required TResult Function(String message) actionSuccess,
    required TResult Function(String message) error,
  }) {
    return loaded(nickname, signature, matchCount);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(String nickname, String signature, int matchCount)?
        loaded,
    TResult? Function(String message)? actionSuccess,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(nickname, signature, matchCount);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(String nickname, String signature, int matchCount)? loaded,
    TResult Function(String message)? actionSuccess,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(nickname, signature, matchCount);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProfileIdle value) idle,
    required TResult Function(ProfileLoading value) loading,
    required TResult Function(ProfileLoaded value) loaded,
    required TResult Function(ProfileActionSuccess value) actionSuccess,
    required TResult Function(ProfileError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProfileIdle value)? idle,
    TResult? Function(ProfileLoading value)? loading,
    TResult? Function(ProfileLoaded value)? loaded,
    TResult? Function(ProfileActionSuccess value)? actionSuccess,
    TResult? Function(ProfileError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileIdle value)? idle,
    TResult Function(ProfileLoading value)? loading,
    TResult Function(ProfileLoaded value)? loaded,
    TResult Function(ProfileActionSuccess value)? actionSuccess,
    TResult Function(ProfileError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class ProfileLoaded implements ProfileState {
  const factory ProfileLoaded(
      {required final String nickname,
      final String signature,
      final int matchCount}) = _$ProfileLoadedImpl;

  String get nickname;
  String get signature;
  int get matchCount;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileLoadedImplCopyWith<_$ProfileLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProfileActionSuccessImplCopyWith<$Res> {
  factory _$$ProfileActionSuccessImplCopyWith(_$ProfileActionSuccessImpl value,
          $Res Function(_$ProfileActionSuccessImpl) then) =
      __$$ProfileActionSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ProfileActionSuccessImplCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res, _$ProfileActionSuccessImpl>
    implements _$$ProfileActionSuccessImplCopyWith<$Res> {
  __$$ProfileActionSuccessImplCopyWithImpl(_$ProfileActionSuccessImpl _value,
      $Res Function(_$ProfileActionSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ProfileActionSuccessImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ProfileActionSuccessImpl implements ProfileActionSuccess {
  const _$ProfileActionSuccessImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'ProfileState.actionSuccess(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileActionSuccessImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileActionSuccessImplCopyWith<_$ProfileActionSuccessImpl>
      get copyWith =>
          __$$ProfileActionSuccessImplCopyWithImpl<_$ProfileActionSuccessImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(String nickname, String signature, int matchCount)
        loaded,
    required TResult Function(String message) actionSuccess,
    required TResult Function(String message) error,
  }) {
    return actionSuccess(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(String nickname, String signature, int matchCount)?
        loaded,
    TResult? Function(String message)? actionSuccess,
    TResult? Function(String message)? error,
  }) {
    return actionSuccess?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(String nickname, String signature, int matchCount)? loaded,
    TResult Function(String message)? actionSuccess,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (actionSuccess != null) {
      return actionSuccess(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProfileIdle value) idle,
    required TResult Function(ProfileLoading value) loading,
    required TResult Function(ProfileLoaded value) loaded,
    required TResult Function(ProfileActionSuccess value) actionSuccess,
    required TResult Function(ProfileError value) error,
  }) {
    return actionSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProfileIdle value)? idle,
    TResult? Function(ProfileLoading value)? loading,
    TResult? Function(ProfileLoaded value)? loaded,
    TResult? Function(ProfileActionSuccess value)? actionSuccess,
    TResult? Function(ProfileError value)? error,
  }) {
    return actionSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileIdle value)? idle,
    TResult Function(ProfileLoading value)? loading,
    TResult Function(ProfileLoaded value)? loaded,
    TResult Function(ProfileActionSuccess value)? actionSuccess,
    TResult Function(ProfileError value)? error,
    required TResult orElse(),
  }) {
    if (actionSuccess != null) {
      return actionSuccess(this);
    }
    return orElse();
  }
}

abstract class ProfileActionSuccess implements ProfileState {
  const factory ProfileActionSuccess({required final String message}) =
      _$ProfileActionSuccessImpl;

  String get message;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileActionSuccessImplCopyWith<_$ProfileActionSuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProfileErrorImplCopyWith<$Res> {
  factory _$$ProfileErrorImplCopyWith(
          _$ProfileErrorImpl value, $Res Function(_$ProfileErrorImpl) then) =
      __$$ProfileErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ProfileErrorImplCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res, _$ProfileErrorImpl>
    implements _$$ProfileErrorImplCopyWith<$Res> {
  __$$ProfileErrorImplCopyWithImpl(
      _$ProfileErrorImpl _value, $Res Function(_$ProfileErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ProfileErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ProfileErrorImpl implements ProfileError {
  const _$ProfileErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'ProfileState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileErrorImplCopyWith<_$ProfileErrorImpl> get copyWith =>
      __$$ProfileErrorImplCopyWithImpl<_$ProfileErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(String nickname, String signature, int matchCount)
        loaded,
    required TResult Function(String message) actionSuccess,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(String nickname, String signature, int matchCount)?
        loaded,
    TResult? Function(String message)? actionSuccess,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(String nickname, String signature, int matchCount)? loaded,
    TResult Function(String message)? actionSuccess,
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
    required TResult Function(ProfileIdle value) idle,
    required TResult Function(ProfileLoading value) loading,
    required TResult Function(ProfileLoaded value) loaded,
    required TResult Function(ProfileActionSuccess value) actionSuccess,
    required TResult Function(ProfileError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProfileIdle value)? idle,
    TResult? Function(ProfileLoading value)? loading,
    TResult? Function(ProfileLoaded value)? loaded,
    TResult? Function(ProfileActionSuccess value)? actionSuccess,
    TResult? Function(ProfileError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileIdle value)? idle,
    TResult Function(ProfileLoading value)? loading,
    TResult Function(ProfileLoaded value)? loaded,
    TResult Function(ProfileActionSuccess value)? actionSuccess,
    TResult Function(ProfileError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ProfileError implements ProfileState {
  const factory ProfileError({required final String message}) =
      _$ProfileErrorImpl;

  String get message;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileErrorImplCopyWith<_$ProfileErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
