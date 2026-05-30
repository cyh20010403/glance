// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String phone) codeSent,
    required TResult Function() loading,
    required TResult Function(
            String token, int userId, String nickname, bool isNewUser)
        success,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String phone)? codeSent,
    TResult? Function()? loading,
    TResult? Function(
            String token, int userId, String nickname, bool isNewUser)?
        success,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String phone)? codeSent,
    TResult Function()? loading,
    TResult Function(String token, int userId, String nickname, bool isNewUser)?
        success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthIdle value) idle,
    required TResult Function(AuthCodeSent value) codeSent,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthSuccess value) success,
    required TResult Function(AuthError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthIdle value)? idle,
    TResult? Function(AuthCodeSent value)? codeSent,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthSuccess value)? success,
    TResult? Function(AuthError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthIdle value)? idle,
    TResult Function(AuthCodeSent value)? codeSent,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthSuccess value)? success,
    TResult Function(AuthError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AuthIdleImplCopyWith<$Res> {
  factory _$$AuthIdleImplCopyWith(
          _$AuthIdleImpl value, $Res Function(_$AuthIdleImpl) then) =
      __$$AuthIdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthIdleImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthIdleImpl>
    implements _$$AuthIdleImplCopyWith<$Res> {
  __$$AuthIdleImplCopyWithImpl(
      _$AuthIdleImpl _value, $Res Function(_$AuthIdleImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthIdleImpl implements AuthIdle {
  const _$AuthIdleImpl();

  @override
  String toString() {
    return 'AuthState.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthIdleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String phone) codeSent,
    required TResult Function() loading,
    required TResult Function(
            String token, int userId, String nickname, bool isNewUser)
        success,
    required TResult Function(String message) error,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String phone)? codeSent,
    TResult? Function()? loading,
    TResult? Function(
            String token, int userId, String nickname, bool isNewUser)?
        success,
    TResult? Function(String message)? error,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String phone)? codeSent,
    TResult Function()? loading,
    TResult Function(String token, int userId, String nickname, bool isNewUser)?
        success,
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
    required TResult Function(AuthIdle value) idle,
    required TResult Function(AuthCodeSent value) codeSent,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthSuccess value) success,
    required TResult Function(AuthError value) error,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthIdle value)? idle,
    TResult? Function(AuthCodeSent value)? codeSent,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthSuccess value)? success,
    TResult? Function(AuthError value)? error,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthIdle value)? idle,
    TResult Function(AuthCodeSent value)? codeSent,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthSuccess value)? success,
    TResult Function(AuthError value)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class AuthIdle implements AuthState {
  const factory AuthIdle() = _$AuthIdleImpl;
}

/// @nodoc
abstract class _$$AuthCodeSentImplCopyWith<$Res> {
  factory _$$AuthCodeSentImplCopyWith(
          _$AuthCodeSentImpl value, $Res Function(_$AuthCodeSentImpl) then) =
      __$$AuthCodeSentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String phone});
}

/// @nodoc
class __$$AuthCodeSentImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthCodeSentImpl>
    implements _$$AuthCodeSentImplCopyWith<$Res> {
  __$$AuthCodeSentImplCopyWithImpl(
      _$AuthCodeSentImpl _value, $Res Function(_$AuthCodeSentImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = null,
  }) {
    return _then(_$AuthCodeSentImpl(
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AuthCodeSentImpl implements AuthCodeSent {
  const _$AuthCodeSentImpl({required this.phone});

  @override
  final String phone;

  @override
  String toString() {
    return 'AuthState.codeSent(phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthCodeSentImpl &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @override
  int get hashCode => Object.hash(runtimeType, phone);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthCodeSentImplCopyWith<_$AuthCodeSentImpl> get copyWith =>
      __$$AuthCodeSentImplCopyWithImpl<_$AuthCodeSentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String phone) codeSent,
    required TResult Function() loading,
    required TResult Function(
            String token, int userId, String nickname, bool isNewUser)
        success,
    required TResult Function(String message) error,
  }) {
    return codeSent(phone);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String phone)? codeSent,
    TResult? Function()? loading,
    TResult? Function(
            String token, int userId, String nickname, bool isNewUser)?
        success,
    TResult? Function(String message)? error,
  }) {
    return codeSent?.call(phone);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String phone)? codeSent,
    TResult Function()? loading,
    TResult Function(String token, int userId, String nickname, bool isNewUser)?
        success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (codeSent != null) {
      return codeSent(phone);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthIdle value) idle,
    required TResult Function(AuthCodeSent value) codeSent,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthSuccess value) success,
    required TResult Function(AuthError value) error,
  }) {
    return codeSent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthIdle value)? idle,
    TResult? Function(AuthCodeSent value)? codeSent,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthSuccess value)? success,
    TResult? Function(AuthError value)? error,
  }) {
    return codeSent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthIdle value)? idle,
    TResult Function(AuthCodeSent value)? codeSent,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthSuccess value)? success,
    TResult Function(AuthError value)? error,
    required TResult orElse(),
  }) {
    if (codeSent != null) {
      return codeSent(this);
    }
    return orElse();
  }
}

abstract class AuthCodeSent implements AuthState {
  const factory AuthCodeSent({required final String phone}) =
      _$AuthCodeSentImpl;

  String get phone;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthCodeSentImplCopyWith<_$AuthCodeSentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthLoadingImplCopyWith<$Res> {
  factory _$$AuthLoadingImplCopyWith(
          _$AuthLoadingImpl value, $Res Function(_$AuthLoadingImpl) then) =
      __$$AuthLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthLoadingImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthLoadingImpl>
    implements _$$AuthLoadingImplCopyWith<$Res> {
  __$$AuthLoadingImplCopyWithImpl(
      _$AuthLoadingImpl _value, $Res Function(_$AuthLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthLoadingImpl implements AuthLoading {
  const _$AuthLoadingImpl();

  @override
  String toString() {
    return 'AuthState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String phone) codeSent,
    required TResult Function() loading,
    required TResult Function(
            String token, int userId, String nickname, bool isNewUser)
        success,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String phone)? codeSent,
    TResult? Function()? loading,
    TResult? Function(
            String token, int userId, String nickname, bool isNewUser)?
        success,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String phone)? codeSent,
    TResult Function()? loading,
    TResult Function(String token, int userId, String nickname, bool isNewUser)?
        success,
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
    required TResult Function(AuthIdle value) idle,
    required TResult Function(AuthCodeSent value) codeSent,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthSuccess value) success,
    required TResult Function(AuthError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthIdle value)? idle,
    TResult? Function(AuthCodeSent value)? codeSent,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthSuccess value)? success,
    TResult? Function(AuthError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthIdle value)? idle,
    TResult Function(AuthCodeSent value)? codeSent,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthSuccess value)? success,
    TResult Function(AuthError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AuthLoading implements AuthState {
  const factory AuthLoading() = _$AuthLoadingImpl;
}

/// @nodoc
abstract class _$$AuthSuccessImplCopyWith<$Res> {
  factory _$$AuthSuccessImplCopyWith(
          _$AuthSuccessImpl value, $Res Function(_$AuthSuccessImpl) then) =
      __$$AuthSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String token, int userId, String nickname, bool isNewUser});
}

/// @nodoc
class __$$AuthSuccessImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthSuccessImpl>
    implements _$$AuthSuccessImplCopyWith<$Res> {
  __$$AuthSuccessImplCopyWithImpl(
      _$AuthSuccessImpl _value, $Res Function(_$AuthSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? userId = null,
    Object? nickname = null,
    Object? isNewUser = null,
  }) {
    return _then(_$AuthSuccessImpl(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      isNewUser: null == isNewUser
          ? _value.isNewUser
          : isNewUser // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AuthSuccessImpl implements AuthSuccess {
  const _$AuthSuccessImpl(
      {required this.token,
      required this.userId,
      required this.nickname,
      required this.isNewUser});

  @override
  final String token;
  @override
  final int userId;
  @override
  final String nickname;
  @override
  final bool isNewUser;

  @override
  String toString() {
    return 'AuthState.success(token: $token, userId: $userId, nickname: $nickname, isNewUser: $isNewUser)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthSuccessImpl &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.isNewUser, isNewUser) ||
                other.isNewUser == isNewUser));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, token, userId, nickname, isNewUser);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthSuccessImplCopyWith<_$AuthSuccessImpl> get copyWith =>
      __$$AuthSuccessImplCopyWithImpl<_$AuthSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String phone) codeSent,
    required TResult Function() loading,
    required TResult Function(
            String token, int userId, String nickname, bool isNewUser)
        success,
    required TResult Function(String message) error,
  }) {
    return success(token, userId, nickname, isNewUser);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String phone)? codeSent,
    TResult? Function()? loading,
    TResult? Function(
            String token, int userId, String nickname, bool isNewUser)?
        success,
    TResult? Function(String message)? error,
  }) {
    return success?.call(token, userId, nickname, isNewUser);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String phone)? codeSent,
    TResult Function()? loading,
    TResult Function(String token, int userId, String nickname, bool isNewUser)?
        success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(token, userId, nickname, isNewUser);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthIdle value) idle,
    required TResult Function(AuthCodeSent value) codeSent,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthSuccess value) success,
    required TResult Function(AuthError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthIdle value)? idle,
    TResult? Function(AuthCodeSent value)? codeSent,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthSuccess value)? success,
    TResult? Function(AuthError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthIdle value)? idle,
    TResult Function(AuthCodeSent value)? codeSent,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthSuccess value)? success,
    TResult Function(AuthError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class AuthSuccess implements AuthState {
  const factory AuthSuccess(
      {required final String token,
      required final int userId,
      required final String nickname,
      required final bool isNewUser}) = _$AuthSuccessImpl;

  String get token;
  int get userId;
  String get nickname;
  bool get isNewUser;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthSuccessImplCopyWith<_$AuthSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthErrorImplCopyWith<$Res> {
  factory _$$AuthErrorImplCopyWith(
          _$AuthErrorImpl value, $Res Function(_$AuthErrorImpl) then) =
      __$$AuthErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AuthErrorImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthErrorImpl>
    implements _$$AuthErrorImplCopyWith<$Res> {
  __$$AuthErrorImplCopyWithImpl(
      _$AuthErrorImpl _value, $Res Function(_$AuthErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$AuthErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AuthErrorImpl implements AuthError {
  const _$AuthErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'AuthState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthErrorImplCopyWith<_$AuthErrorImpl> get copyWith =>
      __$$AuthErrorImplCopyWithImpl<_$AuthErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String phone) codeSent,
    required TResult Function() loading,
    required TResult Function(
            String token, int userId, String nickname, bool isNewUser)
        success,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String phone)? codeSent,
    TResult? Function()? loading,
    TResult? Function(
            String token, int userId, String nickname, bool isNewUser)?
        success,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String phone)? codeSent,
    TResult Function()? loading,
    TResult Function(String token, int userId, String nickname, bool isNewUser)?
        success,
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
    required TResult Function(AuthIdle value) idle,
    required TResult Function(AuthCodeSent value) codeSent,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthSuccess value) success,
    required TResult Function(AuthError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthIdle value)? idle,
    TResult? Function(AuthCodeSent value)? codeSent,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthSuccess value)? success,
    TResult? Function(AuthError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthIdle value)? idle,
    TResult Function(AuthCodeSent value)? codeSent,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthSuccess value)? success,
    TResult Function(AuthError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AuthError implements AuthState {
  const factory AuthError({required final String message}) = _$AuthErrorImpl;

  String get message;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthErrorImplCopyWith<_$AuthErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
