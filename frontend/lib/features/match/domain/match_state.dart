import 'package:freezed_annotation/freezed_annotation.dart';
import 'match_record.dart';

part 'match_state.freezed.dart';

/// 匹配流程状态
@freezed
sealed class MatchState with _$MatchState {
  /// 初始
  const factory MatchState.idle() = MatchIdle;

  /// 正在尝试匹配
  const factory MatchState.trying() = MatchTrying;

  /// 匹配成功
  const factory MatchState.matched({required MatchRecord record}) = MatchMatched;

  /// 已发布，等待对方回应
  const factory MatchState.pending({required String message}) = MatchPending;

  /// 失败
  const factory MatchState.error({required String message}) = MatchError;
}
