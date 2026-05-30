import 'package:freezed_annotation/freezed_annotation.dart';

part 'nearby_state.freezed.dart';

@freezed
sealed class NearbyState with _$NearbyState {
  const factory NearbyState.initial() = NearbyInitial;
  const factory NearbyState.loading() = NearbyLoading;
  const factory NearbyState.loaded({
    required int onlineCount,
    required Map<String, int> moodDistribution,
  }) = NearbyLoaded;
  const factory NearbyState.error({required String message}) = NearbyError;
}
