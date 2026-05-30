import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

/// 个人页面状态
@freezed
sealed class ProfileState with _$ProfileState {
  const factory ProfileState.idle() = ProfileIdle;
  const factory ProfileState.loading() = ProfileLoading;

  /// 加载完成
  const factory ProfileState.loaded({
    required String nickname,
    @Default('') String signature,
    @Default(0) int matchCount,
  }) = ProfileLoaded;

  /// 操作反馈（举报/拉黑/退出）
  const factory ProfileState.actionSuccess({required String message}) = ProfileActionSuccess;
  const factory ProfileState.error({required String message}) = ProfileError;
}
