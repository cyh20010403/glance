// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'card_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CardListState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(List<HeartCard> cards) loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(List<HeartCard> cards)? loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(List<HeartCard> cards)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CardListIdle value) idle,
    required TResult Function(CardListLoading value) loading,
    required TResult Function(CardListLoaded value) loaded,
    required TResult Function(CardListError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CardListIdle value)? idle,
    TResult? Function(CardListLoading value)? loading,
    TResult? Function(CardListLoaded value)? loaded,
    TResult? Function(CardListError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CardListIdle value)? idle,
    TResult Function(CardListLoading value)? loading,
    TResult Function(CardListLoaded value)? loaded,
    TResult Function(CardListError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CardListStateCopyWith<$Res> {
  factory $CardListStateCopyWith(
          CardListState value, $Res Function(CardListState) then) =
      _$CardListStateCopyWithImpl<$Res, CardListState>;
}

/// @nodoc
class _$CardListStateCopyWithImpl<$Res, $Val extends CardListState>
    implements $CardListStateCopyWith<$Res> {
  _$CardListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CardListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CardListIdleImplCopyWith<$Res> {
  factory _$$CardListIdleImplCopyWith(
          _$CardListIdleImpl value, $Res Function(_$CardListIdleImpl) then) =
      __$$CardListIdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CardListIdleImplCopyWithImpl<$Res>
    extends _$CardListStateCopyWithImpl<$Res, _$CardListIdleImpl>
    implements _$$CardListIdleImplCopyWith<$Res> {
  __$$CardListIdleImplCopyWithImpl(
      _$CardListIdleImpl _value, $Res Function(_$CardListIdleImpl) _then)
      : super(_value, _then);

  /// Create a copy of CardListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CardListIdleImpl implements CardListIdle {
  const _$CardListIdleImpl();

  @override
  String toString() {
    return 'CardListState.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CardListIdleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(List<HeartCard> cards) loaded,
    required TResult Function(String message) error,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(List<HeartCard> cards)? loaded,
    TResult? Function(String message)? error,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(List<HeartCard> cards)? loaded,
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
    required TResult Function(CardListIdle value) idle,
    required TResult Function(CardListLoading value) loading,
    required TResult Function(CardListLoaded value) loaded,
    required TResult Function(CardListError value) error,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CardListIdle value)? idle,
    TResult? Function(CardListLoading value)? loading,
    TResult? Function(CardListLoaded value)? loaded,
    TResult? Function(CardListError value)? error,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CardListIdle value)? idle,
    TResult Function(CardListLoading value)? loading,
    TResult Function(CardListLoaded value)? loaded,
    TResult Function(CardListError value)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class CardListIdle implements CardListState {
  const factory CardListIdle() = _$CardListIdleImpl;
}

/// @nodoc
abstract class _$$CardListLoadingImplCopyWith<$Res> {
  factory _$$CardListLoadingImplCopyWith(_$CardListLoadingImpl value,
          $Res Function(_$CardListLoadingImpl) then) =
      __$$CardListLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CardListLoadingImplCopyWithImpl<$Res>
    extends _$CardListStateCopyWithImpl<$Res, _$CardListLoadingImpl>
    implements _$$CardListLoadingImplCopyWith<$Res> {
  __$$CardListLoadingImplCopyWithImpl(
      _$CardListLoadingImpl _value, $Res Function(_$CardListLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of CardListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CardListLoadingImpl implements CardListLoading {
  const _$CardListLoadingImpl();

  @override
  String toString() {
    return 'CardListState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CardListLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(List<HeartCard> cards) loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(List<HeartCard> cards)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(List<HeartCard> cards)? loaded,
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
    required TResult Function(CardListIdle value) idle,
    required TResult Function(CardListLoading value) loading,
    required TResult Function(CardListLoaded value) loaded,
    required TResult Function(CardListError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CardListIdle value)? idle,
    TResult? Function(CardListLoading value)? loading,
    TResult? Function(CardListLoaded value)? loaded,
    TResult? Function(CardListError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CardListIdle value)? idle,
    TResult Function(CardListLoading value)? loading,
    TResult Function(CardListLoaded value)? loaded,
    TResult Function(CardListError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class CardListLoading implements CardListState {
  const factory CardListLoading() = _$CardListLoadingImpl;
}

/// @nodoc
abstract class _$$CardListLoadedImplCopyWith<$Res> {
  factory _$$CardListLoadedImplCopyWith(_$CardListLoadedImpl value,
          $Res Function(_$CardListLoadedImpl) then) =
      __$$CardListLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<HeartCard> cards});
}

/// @nodoc
class __$$CardListLoadedImplCopyWithImpl<$Res>
    extends _$CardListStateCopyWithImpl<$Res, _$CardListLoadedImpl>
    implements _$$CardListLoadedImplCopyWith<$Res> {
  __$$CardListLoadedImplCopyWithImpl(
      _$CardListLoadedImpl _value, $Res Function(_$CardListLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of CardListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cards = null,
  }) {
    return _then(_$CardListLoadedImpl(
      cards: null == cards
          ? _value._cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<HeartCard>,
    ));
  }
}

/// @nodoc

class _$CardListLoadedImpl implements CardListLoaded {
  const _$CardListLoadedImpl({required final List<HeartCard> cards})
      : _cards = cards;

  final List<HeartCard> _cards;
  @override
  List<HeartCard> get cards {
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  @override
  String toString() {
    return 'CardListState.loaded(cards: $cards)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CardListLoadedImpl &&
            const DeepCollectionEquality().equals(other._cards, _cards));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_cards));

  /// Create a copy of CardListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CardListLoadedImplCopyWith<_$CardListLoadedImpl> get copyWith =>
      __$$CardListLoadedImplCopyWithImpl<_$CardListLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(List<HeartCard> cards) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(cards);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(List<HeartCard> cards)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(cards);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(List<HeartCard> cards)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(cards);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CardListIdle value) idle,
    required TResult Function(CardListLoading value) loading,
    required TResult Function(CardListLoaded value) loaded,
    required TResult Function(CardListError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CardListIdle value)? idle,
    TResult? Function(CardListLoading value)? loading,
    TResult? Function(CardListLoaded value)? loaded,
    TResult? Function(CardListError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CardListIdle value)? idle,
    TResult Function(CardListLoading value)? loading,
    TResult Function(CardListLoaded value)? loaded,
    TResult Function(CardListError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class CardListLoaded implements CardListState {
  const factory CardListLoaded({required final List<HeartCard> cards}) =
      _$CardListLoadedImpl;

  List<HeartCard> get cards;

  /// Create a copy of CardListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CardListLoadedImplCopyWith<_$CardListLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CardListErrorImplCopyWith<$Res> {
  factory _$$CardListErrorImplCopyWith(
          _$CardListErrorImpl value, $Res Function(_$CardListErrorImpl) then) =
      __$$CardListErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$CardListErrorImplCopyWithImpl<$Res>
    extends _$CardListStateCopyWithImpl<$Res, _$CardListErrorImpl>
    implements _$$CardListErrorImplCopyWith<$Res> {
  __$$CardListErrorImplCopyWithImpl(
      _$CardListErrorImpl _value, $Res Function(_$CardListErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CardListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$CardListErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CardListErrorImpl implements CardListError {
  const _$CardListErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'CardListState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CardListErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of CardListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CardListErrorImplCopyWith<_$CardListErrorImpl> get copyWith =>
      __$$CardListErrorImplCopyWithImpl<_$CardListErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(List<HeartCard> cards) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(List<HeartCard> cards)? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(List<HeartCard> cards)? loaded,
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
    required TResult Function(CardListIdle value) idle,
    required TResult Function(CardListLoading value) loading,
    required TResult Function(CardListLoaded value) loaded,
    required TResult Function(CardListError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CardListIdle value)? idle,
    TResult? Function(CardListLoading value)? loading,
    TResult? Function(CardListLoaded value)? loaded,
    TResult? Function(CardListError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CardListIdle value)? idle,
    TResult Function(CardListLoading value)? loading,
    TResult Function(CardListLoaded value)? loaded,
    TResult Function(CardListError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class CardListError implements CardListState {
  const factory CardListError({required final String message}) =
      _$CardListErrorImpl;

  String get message;

  /// Create a copy of CardListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CardListErrorImplCopyWith<_$CardListErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CreateCardState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() submitting,
    required TResult Function(HeartCard card) success,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? submitting,
    TResult? Function(HeartCard card)? success,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? submitting,
    TResult Function(HeartCard card)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateCardIdle value) idle,
    required TResult Function(CreateCardSubmitting value) submitting,
    required TResult Function(CreateCardSuccess value) success,
    required TResult Function(CreateCardError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateCardIdle value)? idle,
    TResult? Function(CreateCardSubmitting value)? submitting,
    TResult? Function(CreateCardSuccess value)? success,
    TResult? Function(CreateCardError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateCardIdle value)? idle,
    TResult Function(CreateCardSubmitting value)? submitting,
    TResult Function(CreateCardSuccess value)? success,
    TResult Function(CreateCardError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateCardStateCopyWith<$Res> {
  factory $CreateCardStateCopyWith(
          CreateCardState value, $Res Function(CreateCardState) then) =
      _$CreateCardStateCopyWithImpl<$Res, CreateCardState>;
}

/// @nodoc
class _$CreateCardStateCopyWithImpl<$Res, $Val extends CreateCardState>
    implements $CreateCardStateCopyWith<$Res> {
  _$CreateCardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateCardState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CreateCardIdleImplCopyWith<$Res> {
  factory _$$CreateCardIdleImplCopyWith(_$CreateCardIdleImpl value,
          $Res Function(_$CreateCardIdleImpl) then) =
      __$$CreateCardIdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CreateCardIdleImplCopyWithImpl<$Res>
    extends _$CreateCardStateCopyWithImpl<$Res, _$CreateCardIdleImpl>
    implements _$$CreateCardIdleImplCopyWith<$Res> {
  __$$CreateCardIdleImplCopyWithImpl(
      _$CreateCardIdleImpl _value, $Res Function(_$CreateCardIdleImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateCardState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CreateCardIdleImpl implements CreateCardIdle {
  const _$CreateCardIdleImpl();

  @override
  String toString() {
    return 'CreateCardState.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CreateCardIdleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() submitting,
    required TResult Function(HeartCard card) success,
    required TResult Function(String message) error,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? submitting,
    TResult? Function(HeartCard card)? success,
    TResult? Function(String message)? error,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? submitting,
    TResult Function(HeartCard card)? success,
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
    required TResult Function(CreateCardIdle value) idle,
    required TResult Function(CreateCardSubmitting value) submitting,
    required TResult Function(CreateCardSuccess value) success,
    required TResult Function(CreateCardError value) error,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateCardIdle value)? idle,
    TResult? Function(CreateCardSubmitting value)? submitting,
    TResult? Function(CreateCardSuccess value)? success,
    TResult? Function(CreateCardError value)? error,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateCardIdle value)? idle,
    TResult Function(CreateCardSubmitting value)? submitting,
    TResult Function(CreateCardSuccess value)? success,
    TResult Function(CreateCardError value)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class CreateCardIdle implements CreateCardState {
  const factory CreateCardIdle() = _$CreateCardIdleImpl;
}

/// @nodoc
abstract class _$$CreateCardSubmittingImplCopyWith<$Res> {
  factory _$$CreateCardSubmittingImplCopyWith(_$CreateCardSubmittingImpl value,
          $Res Function(_$CreateCardSubmittingImpl) then) =
      __$$CreateCardSubmittingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CreateCardSubmittingImplCopyWithImpl<$Res>
    extends _$CreateCardStateCopyWithImpl<$Res, _$CreateCardSubmittingImpl>
    implements _$$CreateCardSubmittingImplCopyWith<$Res> {
  __$$CreateCardSubmittingImplCopyWithImpl(_$CreateCardSubmittingImpl _value,
      $Res Function(_$CreateCardSubmittingImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateCardState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CreateCardSubmittingImpl implements CreateCardSubmitting {
  const _$CreateCardSubmittingImpl();

  @override
  String toString() {
    return 'CreateCardState.submitting()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateCardSubmittingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() submitting,
    required TResult Function(HeartCard card) success,
    required TResult Function(String message) error,
  }) {
    return submitting();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? submitting,
    TResult? Function(HeartCard card)? success,
    TResult? Function(String message)? error,
  }) {
    return submitting?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? submitting,
    TResult Function(HeartCard card)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (submitting != null) {
      return submitting();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateCardIdle value) idle,
    required TResult Function(CreateCardSubmitting value) submitting,
    required TResult Function(CreateCardSuccess value) success,
    required TResult Function(CreateCardError value) error,
  }) {
    return submitting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateCardIdle value)? idle,
    TResult? Function(CreateCardSubmitting value)? submitting,
    TResult? Function(CreateCardSuccess value)? success,
    TResult? Function(CreateCardError value)? error,
  }) {
    return submitting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateCardIdle value)? idle,
    TResult Function(CreateCardSubmitting value)? submitting,
    TResult Function(CreateCardSuccess value)? success,
    TResult Function(CreateCardError value)? error,
    required TResult orElse(),
  }) {
    if (submitting != null) {
      return submitting(this);
    }
    return orElse();
  }
}

abstract class CreateCardSubmitting implements CreateCardState {
  const factory CreateCardSubmitting() = _$CreateCardSubmittingImpl;
}

/// @nodoc
abstract class _$$CreateCardSuccessImplCopyWith<$Res> {
  factory _$$CreateCardSuccessImplCopyWith(_$CreateCardSuccessImpl value,
          $Res Function(_$CreateCardSuccessImpl) then) =
      __$$CreateCardSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({HeartCard card});

  $HeartCardCopyWith<$Res> get card;
}

/// @nodoc
class __$$CreateCardSuccessImplCopyWithImpl<$Res>
    extends _$CreateCardStateCopyWithImpl<$Res, _$CreateCardSuccessImpl>
    implements _$$CreateCardSuccessImplCopyWith<$Res> {
  __$$CreateCardSuccessImplCopyWithImpl(_$CreateCardSuccessImpl _value,
      $Res Function(_$CreateCardSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateCardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? card = null,
  }) {
    return _then(_$CreateCardSuccessImpl(
      card: null == card
          ? _value.card
          : card // ignore: cast_nullable_to_non_nullable
              as HeartCard,
    ));
  }

  /// Create a copy of CreateCardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HeartCardCopyWith<$Res> get card {
    return $HeartCardCopyWith<$Res>(_value.card, (value) {
      return _then(_value.copyWith(card: value));
    });
  }
}

/// @nodoc

class _$CreateCardSuccessImpl implements CreateCardSuccess {
  const _$CreateCardSuccessImpl({required this.card});

  @override
  final HeartCard card;

  @override
  String toString() {
    return 'CreateCardState.success(card: $card)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateCardSuccessImpl &&
            (identical(other.card, card) || other.card == card));
  }

  @override
  int get hashCode => Object.hash(runtimeType, card);

  /// Create a copy of CreateCardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateCardSuccessImplCopyWith<_$CreateCardSuccessImpl> get copyWith =>
      __$$CreateCardSuccessImplCopyWithImpl<_$CreateCardSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() submitting,
    required TResult Function(HeartCard card) success,
    required TResult Function(String message) error,
  }) {
    return success(card);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? submitting,
    TResult? Function(HeartCard card)? success,
    TResult? Function(String message)? error,
  }) {
    return success?.call(card);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? submitting,
    TResult Function(HeartCard card)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(card);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateCardIdle value) idle,
    required TResult Function(CreateCardSubmitting value) submitting,
    required TResult Function(CreateCardSuccess value) success,
    required TResult Function(CreateCardError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateCardIdle value)? idle,
    TResult? Function(CreateCardSubmitting value)? submitting,
    TResult? Function(CreateCardSuccess value)? success,
    TResult? Function(CreateCardError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateCardIdle value)? idle,
    TResult Function(CreateCardSubmitting value)? submitting,
    TResult Function(CreateCardSuccess value)? success,
    TResult Function(CreateCardError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class CreateCardSuccess implements CreateCardState {
  const factory CreateCardSuccess({required final HeartCard card}) =
      _$CreateCardSuccessImpl;

  HeartCard get card;

  /// Create a copy of CreateCardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateCardSuccessImplCopyWith<_$CreateCardSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreateCardErrorImplCopyWith<$Res> {
  factory _$$CreateCardErrorImplCopyWith(_$CreateCardErrorImpl value,
          $Res Function(_$CreateCardErrorImpl) then) =
      __$$CreateCardErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$CreateCardErrorImplCopyWithImpl<$Res>
    extends _$CreateCardStateCopyWithImpl<$Res, _$CreateCardErrorImpl>
    implements _$$CreateCardErrorImplCopyWith<$Res> {
  __$$CreateCardErrorImplCopyWithImpl(
      _$CreateCardErrorImpl _value, $Res Function(_$CreateCardErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateCardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$CreateCardErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CreateCardErrorImpl implements CreateCardError {
  const _$CreateCardErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'CreateCardState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateCardErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of CreateCardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateCardErrorImplCopyWith<_$CreateCardErrorImpl> get copyWith =>
      __$$CreateCardErrorImplCopyWithImpl<_$CreateCardErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() submitting,
    required TResult Function(HeartCard card) success,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? submitting,
    TResult? Function(HeartCard card)? success,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? submitting,
    TResult Function(HeartCard card)? success,
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
    required TResult Function(CreateCardIdle value) idle,
    required TResult Function(CreateCardSubmitting value) submitting,
    required TResult Function(CreateCardSuccess value) success,
    required TResult Function(CreateCardError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateCardIdle value)? idle,
    TResult? Function(CreateCardSubmitting value)? submitting,
    TResult? Function(CreateCardSuccess value)? success,
    TResult? Function(CreateCardError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateCardIdle value)? idle,
    TResult Function(CreateCardSubmitting value)? submitting,
    TResult Function(CreateCardSuccess value)? success,
    TResult Function(CreateCardError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class CreateCardError implements CreateCardState {
  const factory CreateCardError({required final String message}) =
      _$CreateCardErrorImpl;

  String get message;

  /// Create a copy of CreateCardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateCardErrorImplCopyWith<_$CreateCardErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
