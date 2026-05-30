import 'package:freezed_annotation/freezed_annotation.dart';
import 'glance_story.dart';

part 'story_state.freezed.dart';

@freezed
sealed class StoryState with _$StoryState {
  const factory StoryState.initial() = StoryInitial;
  const factory StoryState.loading() = StoryLoading;
  const factory StoryState.todayLoaded({GlanceStory? story}) = StoryTodayLoaded;
  const factory StoryState.historyLoaded({required List<GlanceStory> stories}) = StoryHistoryLoaded;
  const factory StoryState.error({required String message}) = StoryError;
}
