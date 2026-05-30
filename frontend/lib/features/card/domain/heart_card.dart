import 'package:freezed_annotation/freezed_annotation.dart';

part 'heart_card.freezed.dart';
part 'heart_card.g.dart';

/// 心动卡片模型
@freezed
sealed class HeartCard with _$HeartCard {
  const factory HeartCard({
    @Default('') String imageUrl,
    @Default(0.0) double matchScore,
    required int id,
    required int userId,
    required String scene,
    @Default('') String sceneLabel,
    @Default('') String location,
    required String occurredAt,
    @Default('') String topColor,
    @Default('') String pantsColor,
    @Default(0) int glasses,    // 0-未知 1-有 2-无
    @Default('') String hairstyle,
    @Default(0) int hasBag,     // 0-未知 1-有 2-无
    @Default('') String shoeColor,
    @Default('') String description,
    @Default(1) int status,     // 1-有效 2-已匹配 3-已过期
    required String expireAt,
    required String createdAt,
  }) = _HeartCard;

  factory HeartCard.fromJson(Map<String, dynamic> json) =>
      _$HeartCardFromJson(json);

  const HeartCard._();

  // === 计算属性 ===

  /// 场景中文映射
  static const _sceneLabels = {
    'subway':  '🚇 地铁',
    'library': '📚 图书馆',
    'cafe':    '☕ 咖啡店',
    'campus':  '🏫 校园',
    'other':   '📍 其他',
  };

  String get sceneText => _sceneLabels[scene] ?? scene;

  /// 剩余分钟数
  int get remainingMinutes {
    final expire = DateTime.tryParse(expireAt);
    if (expire == null) return 0;
    return expire.difference(DateTime.now()).inMinutes.clamp(0, 30);
  }

  /// 是否即将过期（< 5 分钟）
  bool get isExpiringSoon => remainingMinutes < 5;

  /// 生成特征标签列表
  List<String> get featureTags {
    final tags = <String>[];
    if (topColor.isNotEmpty) tags.add('👔 $topColor');
    if (pantsColor.isNotEmpty) tags.add('👖 $pantsColor');
    if (hairstyle.isNotEmpty) tags.add('💇 $hairstyle');
    if (shoeColor.isNotEmpty) tags.add('👟 $shoeColor');
    if (glasses == 1) tags.add('👓 戴眼镜');
    if (hasBag == 1) tags.add('🎒 背包');
    return tags;
  }
}
