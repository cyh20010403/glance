import 'package:freezed_annotation/freezed_annotation.dart';

part 'mood_state.freezed.dart';

@freezed
sealed class MoodState with _$MoodState {
  const factory MoodState.initial() = MoodInitial;
  const factory MoodState.loading() = MoodLoading;
  const factory MoodState.loaded({String? mood}) = MoodLoaded;
  const factory MoodState.error({required String message}) = MoodError;
}
