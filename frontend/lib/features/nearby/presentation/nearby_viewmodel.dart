import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/nearby_state.dart';
import '../data/nearby_repository.dart';

final class NearbyViewModel extends Notifier<NearbyState> {
  final _repo = NearbyRepository();

  @override
  NearbyState build() => const NearbyState.initial();

  Future<void> loadStats() async {
    state = const NearbyState.loading();
    try {
      final data = await _repo.getStats();
      if (data != null) {
        final dist = Map<String, int>.from(
          (data['moodDistribution'] as Map<String, dynamic>?)?.map(
            (k, v) => MapEntry(k, (v as num).toInt()),
          ) ?? {},
        );
        state = NearbyState.loaded(
          onlineCount: data['onlineCount'] as int? ?? 0,
          moodDistribution: dist,
        );
      } else {
        state = const NearbyState.loaded(onlineCount: 0, moodDistribution: {});
      }
    } catch (e) {
      state = NearbyState.error(message: e.toString());
    }
  }
}

final nearbyViewModelProvider =
    NotifierProvider<NearbyViewModel, NearbyState>(NearbyViewModel.new);
