import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_record.freezed.dart';
part 'match_record.g.dart';

/// 匹配记录模型
@freezed
sealed class MatchRecord with _$MatchRecord {
  const factory MatchRecord({
    required int id,
    required int cardAId,
    required int cardBId,
    required int userAId,
    required int userBId,
    @Default(1) int status,       // 1-已匹配 2-已解除
    required String matchedAt,
  }) = _MatchRecord;

  factory MatchRecord.fromJson(Map<String, dynamic> json) =>
      _$MatchRecordFromJson(json);

  const MatchRecord._();
}
