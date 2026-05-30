import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 卡通形象预览组件 — 基于 DiceBear Avataaars
///
/// 使用免费开源的 DiceBear API 生成精美卡通形象。
/// 根据用户特征（发型/衣着颜色/眼镜等）实时组合参数。
///
/// 风格：avataaars-neutral — 圆润可爱、中性友好
class CartoonAvatar extends StatelessWidget {
  final String topColor;
  final String pantsColor;
  final String shoeColor;
  final String hairstyle;
  final bool hasGlasses;
  final bool hasBag;
  final double size;

  const CartoonAvatar({
    super.key,
    this.topColor = '',
    this.pantsColor = '',
    this.shoeColor = '',
    this.hairstyle = '',
    this.hasGlasses = false,
    this.hasBag = false,
    this.size = 220,
  });

  /// 中文颜色 → 英文映射
  static Color colorFromName(String name) {
    return switch (name) {
      '黑色' => const Color(0xFF3D3D3D),
      '白色' => const Color(0xFFF5F0E8),
      '灰色' => const Color(0xFF9B9B9B),
      '蓝色' => const Color(0xFF5B7DB1),
      '红色' => const Color(0xFFD46868),
      '粉色' => const Color(0xFFE8B4B8),
      '黄色' => const Color(0xFFE8C86A),
      '绿色' => const Color(0xFF8EA77D),
      '棕色' => const Color(0xFFA0856B),
      '紫色' => const Color(0xFFA599B5),
      _ => const Color(0xFFE0D8CC),
    };
  }

  /// 中文颜色 → DiceBear clothesColor 参数
  static String _clothesColor(String cn) {
    return switch (cn) {
      '黑色' => 'black',
      '白色' => 'white',
      '灰色' => 'gray02',
      '蓝色' => 'blue02',
      '红色' => 'red02',
      '粉色' => 'pink02',
      '黄色' => 'yellow02',
      '绿色' => 'green02',
      '棕色' => 'brown',
      '紫色' => 'purple02',
      _ => 'gray01',
    };
  }

  /// 中文发型 → DiceBear top 参数
  static String _hairTop(String cn) {
    return switch (cn) {
      '短发' => 'shortHair',
      '长发' => 'longHair',
      '卷发' => 'curlyHair',
      '马尾' => 'longHairFroBand',
      '丸子头' => 'bun',
      _ => 'shortHair',
    };
  }

  /// 构建 DiceBear URL
  String _buildUrl() {
    final params = <String, String>{
      'seed': '$hairstyle$topColor$pantsColor',
      // 发型
      'top': _hairTop(hairstyle),
      // 衣服颜色
      'clothesColor': _clothesColor(topColor),
      // 眼镜
      if (hasGlasses) 'accessories': 'round',
      // 颜色（DiceBear 用 hairColor 上色头发）
      'hairColor': 'brownDark',
      // 皮肤
      'skinColor': 'tanned',
      // 表情（开心/中性）
      'mouth': 'smile',
      'eyes': 'happy',
    };

    final query = params.entries.map((e) => '${e.key}=${e.value}').join('&');
    return 'https://api.dicebear.com/9.x/avataaars-neutral/svg?$query';
  }

  @override
  Widget build(BuildContext context) {
    final url = _buildUrl();
    return SizedBox(
      width: size,
      height: size,
      child: SvgPicture.network(
        url,
        width: size,
        height: size,
        placeholderBuilder: (_) => _buildPlaceholder(),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8EE),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: SizedBox(
          width: 24, height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}
