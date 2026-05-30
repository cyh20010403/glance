/// 匹配仪式展示数据模型（纯 Dart，无需 Freezed）
final class CeremonyData {
  final int matchId;
  final List<String> commonPoints;
  final int scorePercent;
  final String theirLook;
  final String yourLookInTheirEyes;
  final String icebreaker;
  final String partnerNickname;
  final String partnerMood;

  const CeremonyData({
    required this.matchId,
    required this.commonPoints,
    required this.scorePercent,
    required this.theirLook,
    required this.yourLookInTheirEyes,
    required this.icebreaker,
    required this.partnerNickname,
    required this.partnerMood,
  });

  factory CeremonyData.fromJson(Map<String, dynamic> json) {
    return CeremonyData(
      matchId: json['matchId'] as int,
      commonPoints: (json['commonPoints'] as List).cast<String>(),
      scorePercent: json['scorePercent'] as int,
      theirLook: json['theirLook'] as String? ?? '',
      yourLookInTheirEyes: json['yourLookInTheirEyes'] as String? ?? '',
      icebreaker: json['icebreaker'] as String? ?? '',
      partnerNickname: json['partnerNickname'] as String? ?? '',
      partnerMood: json['partnerMood'] as String? ?? '',
    );
  }
}
