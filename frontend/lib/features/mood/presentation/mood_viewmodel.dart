import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/mood_state.dart';
import '../data/mood_repository.dart';

final class MoodViewModel extends Notifier<MoodState> {
  final _repo = MoodRepository();

  @override
  MoodState build() => const MoodState.initial();

  Future<void> loadMood() async {
    state = const MoodState.loading();
    try {
      final data = await _repo.getMyMood();
      state = MoodState.loaded(mood: data?['mood']);
    } catch (e) {
      state = MoodState.error(message: e.toString());
    }
  }

  Future<void> setMood(String mood) async {
    try {
      await _repo.updateMood(mood);
      state = MoodState.loaded(mood: mood);
    } catch (e) {
      state = MoodState.error(message: e.toString());
    }
  }
}

final moodViewModelProvider =
    NotifierProvider<MoodViewModel, MoodState>(MoodViewModel.new);
