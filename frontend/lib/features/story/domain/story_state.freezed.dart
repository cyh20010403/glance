// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StoryState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(GlanceStory? story) todayLoaded,
    required TResult Function(List<GlanceStory> stories) historyLoaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(GlanceStory? story)? todayLoaded,
    TResult? Function(List<GlanceStory> stories)? historyLoaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(GlanceStory? story)? todayLoaded,
    TResult Function(List<GlanceStory> stories)? historyLoaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StoryInitial value) initial,
    required TResult Function(StoryLoading value) loading,
    required TResult Function(StoryTodayLoaded value) todayLoaded,
    required TResult Function(StoryHistoryLoaded value) historyLoaded,
    required TResult Function(StoryError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StoryInitial value)? initial,
    TResult? Function(StoryLoading value)? loading,
    TResult? Function(StoryTodayLoaded value)? todayLoaded,
    TResult? Function(StoryHistoryLoaded value)? historyLoaded,
    TResult? Function(StoryError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StoryInitial value)? initial,
    TResult Function(StoryLoading value)? loading,
    TResult Function(StoryTodayLoaded value)? todayLoaded,
    TResult Function(StoryHistoryLoaded value)? historyLoaded,
    TResult Function(StoryError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryStateCopyWith<$Res> {
  factory $StoryStateCopyWith(
          StoryState value, $Res Function(StoryState) then) =
      _$StoryStateCopyWithImpl<$Res, StoryState>;
}

/// @nodoc
class _$StoryStateCopyWithImpl<$Res, $Val extends StoryState>
    implements $StoryStateCopyWith<$Res> {
  _$StoryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoryState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$StoryInitialImplCopyWith<$Res> {
  factory _$$StoryInitialImplCopyWith(
          _$StoryInitialImpl value, $Res Function(_$StoryInitialImpl) then) =
      __$$StoryInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StoryInitialImplCopyWithImpl<$Res>
    extends _$StoryStateCopyWithImpl<$Res, _$StoryInitialImpl>
    implements _$$StoryInitialImplCopyWith<$Res> {
  __$$StoryInitialImplCopyWithImpl(
      _$StoryInitialImpl _value, $Res Function(_$StoryInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of StoryState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StoryInitialImpl implements StoryInitial {
  const _$StoryInitialImpl();

  @override
  String toString() {
    return 'StoryState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StoryInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(GlanceStory? story) todayLoaded,
    required TResult Function(List<GlanceStory> stories) historyLoaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(GlanceStory? story)? todayLoaded,
    TResult? Function(List<GlanceStory> stories)? historyLoaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(GlanceStory? story)? todayLoaded,
    TResult Function(List<GlanceStory> stories)? historyLoaded,
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
    required TResult Function(StoryInitial value) initial,
    required TResult Function(StoryLoading value) loading,
    required TResult Function(StoryTodayLoaded value) todayLoaded,
    required TResult Function(StoryHistoryLoaded value) historyLoaded,
    required TResult Function(StoryError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StoryInitial value)? initial,
    TResult? Function(StoryLoading value)? loading,
    TResult? Function(StoryTodayLoaded value)? todayLoaded,
    TResult? Function(StoryHistoryLoaded value)? historyLoaded,
    TResult? Function(StoryError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StoryInitial value)? initial,
    TResult Function(StoryLoading value)? loading,
    TResult Function(StoryTodayLoaded value)? todayLoaded,
    TResult Function(StoryHistoryLoaded value)? historyLoaded,
    TResult Function(StoryError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class StoryInitial implements StoryState {
  const factory StoryInitial() = _$StoryInitialImpl;
}

/// @nodoc
abstract class _$$StoryLoadingImplCopyWith<$Res> {
  factory _$$StoryLoadingImplCopyWith(
          _$StoryLoadingImpl value, $Res Function(_$StoryLoadingImpl) then) =
      __$$StoryLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StoryLoadingImplCopyWithImpl<$Res>
    extends _$StoryStateCopyWithImpl<$Res, _$StoryLoadingImpl>
    implements _$$StoryLoadingImplCopyWith<$Res> {
  __$$StoryLoadingImplCopyWithImpl(
      _$StoryLoadingImpl _value, $Res Function(_$StoryLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of StoryState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StoryLoadingImpl implements StoryLoading {
  const _$StoryLoadingImpl();

  @override
  String toString() {
    return 'StoryState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StoryLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(GlanceStory? story) todayLoaded,
    required TResult Function(List<GlanceStory> stories) historyLoaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(GlanceStory? story)? todayLoaded,
    TResult? Function(List<GlanceStory> stories)? historyLoaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(GlanceStory? story)? todayLoaded,
    TResult Function(List<GlanceStory> stories)? historyLoaded,
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
    required TResult Function(StoryInitial value) initial,
    required TResult Function(StoryLoading value) loading,
    required TResult Function(StoryTodayLoaded value) todayLoaded,
    required TResult Function(StoryHistoryLoaded value) historyLoaded,
    required TResult Function(StoryError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StoryInitial value)? initial,
    TResult? Function(StoryLoading value)? loading,
    TResult? Function(StoryTodayLoaded value)? todayLoaded,
    TResult? Function(StoryHistoryLoaded value)? historyLoaded,
    TResult? Function(StoryError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StoryInitial value)? initial,
    TResult Function(StoryLoading value)? loading,
    TResult Function(StoryTodayLoaded value)? todayLoaded,
    TResult Function(StoryHistoryLoaded value)? historyLoaded,
    TResult Function(StoryError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class StoryLoading implements StoryState {
  const factory StoryLoading() = _$StoryLoadingImpl;
}

/// @nodoc
abstract class _$$StoryTodayLoadedImplCopyWith<$Res> {
  factory _$$StoryTodayLoadedImplCopyWith(_$StoryTodayLoadedImpl value,
          $Res Function(_$StoryTodayLoadedImpl) then) =
      __$$StoryTodayLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({GlanceStory? story});

  $GlanceStoryCopyWith<$Res>? get story;
}

/// @nodoc
class __$$StoryTodayLoadedImplCopyWithImpl<$Res>
    extends _$StoryStateCopyWithImpl<$Res, _$StoryTodayLoadedImpl>
    implements _$$StoryTodayLoadedImplCopyWith<$Res> {
  __$$StoryTodayLoadedImplCopyWithImpl(_$StoryTodayLoadedImpl _value,
      $Res Function(_$StoryTodayLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of StoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? story = freezed,
  }) {
    return _then(_$StoryTodayLoadedImpl(
      story: freezed == story
          ? _value.story
          : story // ignore: cast_nullable_to_non_nullable
              as GlanceStory?,
    ));
  }

  /// Create a copy of StoryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GlanceStoryCopyWith<$Res>? get story {
    if (_value.story == null) {
      return null;
    }

    return $GlanceStoryCopyWith<$Res>(_value.story!, (value) {
      return _then(_value.copyWith(story: value));
    });
  }
}

/// @nodoc

class _$StoryTodayLoadedImpl implements StoryTodayLoaded {
  const _$StoryTodayLoadedImpl({this.story});

  @override
  final GlanceStory? story;

  @override
  String toString() {
    return 'StoryState.todayLoaded(story: $story)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryTodayLoadedImpl &&
            (identical(other.story, story) || other.story == story));
  }

  @override
  int get hashCode => Object.hash(runtimeType, story);

  /// Create a copy of StoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryTodayLoadedImplCopyWith<_$StoryTodayLoadedImpl> get copyWith =>
      __$$StoryTodayLoadedImplCopyWithImpl<_$StoryTodayLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(GlanceStory? story) todayLoaded,
    required TResult Function(List<GlanceStory> stories) historyLoaded,
    required TResult Function(String message) error,
  }) {
    return todayLoaded(story);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(GlanceStory? story)? todayLoaded,
    TResult? Function(List<GlanceStory> stories)? historyLoaded,
    TResult? Function(String message)? error,
  }) {
    return todayLoaded?.call(story);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(GlanceStory? story)? todayLoaded,
    TResult Function(List<GlanceStory> stories)? historyLoaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (todayLoaded != null) {
      return todayLoaded(story);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StoryInitial value) initial,
    required TResult Function(StoryLoading value) loading,
    required TResult Function(StoryTodayLoaded value) todayLoaded,
    required TResult Function(StoryHistoryLoaded value) historyLoaded,
    required TResult Function(StoryError value) error,
  }) {
    return todayLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StoryInitial value)? initial,
    TResult? Function(StoryLoading value)? loading,
    TResult? Function(StoryTodayLoaded value)? todayLoaded,
    TResult? Function(StoryHistoryLoaded value)? historyLoaded,
    TResult? Function(StoryError value)? error,
  }) {
    return todayLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StoryInitial value)? initial,
    TResult Function(StoryLoading value)? loading,
    TResult Function(StoryTodayLoaded value)? todayLoaded,
    TResult Function(StoryHistoryLoaded value)? historyLoaded,
    TResult Function(StoryError value)? error,
    required TResult orElse(),
  }) {
    if (todayLoaded != null) {
      return todayLoaded(this);
    }
    return orElse();
  }
}

abstract class StoryTodayLoaded implements StoryState {
  const factory StoryTodayLoaded({final GlanceStory? story}) =
      _$StoryTodayLoadedImpl;

  GlanceStory? get story;

  /// Create a copy of StoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryTodayLoadedImplCopyWith<_$StoryTodayLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StoryHistoryLoadedImplCopyWith<$Res> {
  factory _$$StoryHistoryLoadedImplCopyWith(_$StoryHistoryLoadedImpl value,
          $Res Function(_$StoryHistoryLoadedImpl) then) =
      __$$StoryHistoryLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<GlanceStory> stories});
}

/// @nodoc
class __$$StoryHistoryLoadedImplCopyWithImpl<$Res>
    extends _$StoryStateCopyWithImpl<$Res, _$StoryHistoryLoadedImpl>
    implements _$$StoryHistoryLoadedImplCopyWith<$Res> {
  __$$StoryHistoryLoadedImplCopyWithImpl(_$StoryHistoryLoadedImpl _value,
      $Res Function(_$StoryHistoryLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of StoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stories = null,
  }) {
    return _then(_$StoryHistoryLoadedImpl(
      stories: null == stories
          ? _value._stories
          : stories // ignore: cast_nullable_to_non_nullable
              as List<GlanceStory>,
    ));
  }
}

/// @nodoc

class _$StoryHistoryLoadedImpl implements StoryHistoryLoaded {
  const _$StoryHistoryLoadedImpl({required final List<GlanceStory> stories})
      : _stories = stories;

  final List<GlanceStory> _stories;
  @override
  List<GlanceStory> get stories {
    if (_stories is EqualUnmodifiableListView) return _stories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stories);
  }

  @override
  String toString() {
    return 'StoryState.historyLoaded(stories: $stories)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryHistoryLoadedImpl &&
            const DeepCollectionEquality().equals(other._stories, _stories));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_stories));

  /// Create a copy of StoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryHistoryLoadedImplCopyWith<_$StoryHistoryLoadedImpl> get copyWith =>
      __$$StoryHistoryLoadedImplCopyWithImpl<_$StoryHistoryLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(GlanceStory? story) todayLoaded,
    required TResult Function(List<GlanceStory> stories) historyLoaded,
    required TResult Function(String message) error,
  }) {
    return historyLoaded(stories);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(GlanceStory? story)? todayLoaded,
    TResult? Function(List<GlanceStory> stories)? historyLoaded,
    TResult? Function(String message)? error,
  }) {
    return historyLoaded?.call(stories);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(GlanceStory? story)? todayLoaded,
    TResult Function(List<GlanceStory> stories)? historyLoaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (historyLoaded != null) {
      return historyLoaded(stories);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StoryInitial value) initial,
    required TResult Function(StoryLoading value) loading,
    required TResult Function(StoryTodayLoaded value) todayLoaded,
    required TResult Function(StoryHistoryLoaded value) historyLoaded,
    required TResult Function(StoryError value) error,
  }) {
    return historyLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StoryInitial value)? initial,
    TResult? Function(StoryLoading value)? loading,
    TResult? Function(StoryTodayLoaded value)? todayLoaded,
    TResult? Function(StoryHistoryLoaded value)? historyLoaded,
    TResult? Function(StoryError value)? error,
  }) {
    return historyLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StoryInitial value)? initial,
    TResult Function(StoryLoading value)? loading,
    TResult Function(StoryTodayLoaded value)? todayLoaded,
    TResult Function(StoryHistoryLoaded value)? historyLoaded,
    TResult Function(StoryError value)? error,
    required TResult orElse(),
  }) {
    if (historyLoaded != null) {
      return historyLoaded(this);
    }
    return orElse();
  }
}

abstract class StoryHistoryLoaded implements StoryState {
  const factory StoryHistoryLoaded({required final List<GlanceStory> stories}) =
      _$StoryHistoryLoadedImpl;

  List<GlanceStory> get stories;

  /// Create a copy of StoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryHistoryLoadedImplCopyWith<_$StoryHistoryLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StoryErrorImplCopyWith<$Res> {
  factory _$$StoryErrorImplCopyWith(
          _$StoryErrorImpl value, $Res Function(_$StoryErrorImpl) then) =
      __$$StoryErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$StoryErrorImplCopyWithImpl<$Res>
    extends _$StoryStateCopyWithImpl<$Res, _$StoryErrorImpl>
    implements _$$StoryErrorImplCopyWith<$Res> {
  __$$StoryErrorImplCopyWithImpl(
      _$StoryErrorImpl _value, $Res Function(_$StoryErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of StoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$StoryErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$StoryErrorImpl implements StoryError {
  const _$StoryErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'StoryState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of StoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryErrorImplCopyWith<_$StoryErrorImpl> get copyWith =>
      __$$StoryErrorImplCopyWithImpl<_$StoryErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(GlanceStory? story) todayLoaded,
    required TResult Function(List<GlanceStory> stories) historyLoaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(GlanceStory? story)? todayLoaded,
    TResult? Function(List<GlanceStory> stories)? historyLoaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(GlanceStory? story)? todayLoaded,
    TResult Function(List<GlanceStory> stories)? historyLoaded,
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
    required TResult Function(StoryInitial value) initial,
    required TResult Function(StoryLoading value) loading,
    required TResult Function(StoryTodayLoaded value) todayLoaded,
    required TResult Function(StoryHistoryLoaded value) historyLoaded,
    required TResult Function(StoryError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StoryInitial value)? initial,
    TResult? Function(StoryLoading value)? loading,
    TResult? Function(StoryTodayLoaded value)? todayLoaded,
    TResult? Function(StoryHistoryLoaded value)? historyLoaded,
    TResult? Function(StoryError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StoryInitial value)? initial,
    TResult Function(StoryLoading value)? loading,
    TResult Function(StoryTodayLoaded value)? todayLoaded,
    TResult Function(StoryHistoryLoaded value)? historyLoaded,
    TResult Function(StoryError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class StoryError implements StoryState {
  const factory StoryError({required final String message}) = _$StoryErrorImpl;

  String get message;

  /// Create a copy of StoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryErrorImplCopyWith<_$StoryErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
