import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/glance_story.dart';
import '../domain/story_state.dart';
import '../data/story_repository.dart';

final class StoryViewModel extends Notifier<StoryState> {
  final _repo = StoryRepository();

  @override
  StoryState build() => const StoryState.initial();

  Future<void> loadTodayStory() async {
    state = const StoryState.loading();
    try {
      final data = await _repo.getTodayStory();
      if (data != null) {
        state = StoryState.todayLoaded(
          story: GlanceStory.fromJson(data),
        );
      } else {
        state = const StoryState.todayLoaded(story: null);
      }
    } catch (e) {
      state = StoryState.error(message: e.toString());
    }
  }

  Future<void> loadHistory() async {
    try {
      final stories = await _repo.getHistory();
      state = StoryState.historyLoaded(stories: stories);
    } catch (e) {
      state = StoryState.error(message: e.toString());
    }
  }
}

final storyViewModelProvider =
    NotifierProvider<StoryViewModel, StoryState>(StoryViewModel.new);
