import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../theme/app_theme.dart';

/// 卡通形象组件 — DiceBear Avataaars + 下身配色指示
///
/// 上半身使用免费开源的 DiceBear API（精美头像级画风），
/// 裤子/鞋子以配色条形式在下方展示。
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
    this.size = 200,
  });

  /// 中文颜色 → Flutter Color
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

  /// 中文 → DiceBear clothesColor
  static String _clothesColor(String cn) => switch (cn) {
    '黑色' => 'black',   '白色' => 'white',
    '灰色' => 'gray02',  '蓝色' => 'blue02',
    '红色' => 'red02',   '粉色' => 'pink02',
    '黄色' => 'yellow',  '绿色' => 'green02',
    '棕色' => 'brown',   '紫色' => 'purple02',
    _ => 'gray01',
  };

  /// 中文发型 → DiceBear top
  static String _hairTop(String cn) => switch (cn) {
    '短发' => 'shortHair',     '长发' => 'longHair',
    '卷发' => 'curlyHair',     '马尾' => 'longHairFroBand',
    '丸子头' => 'bun',         _ => 'shortHair',
  };

  String _buildUrl() {
    final params = <String, String>{
      'seed': '$hairstyle$topColor$pantsColor',
      'top': _hairTop(hairstyle),
      'clothesColor': _clothesColor(topColor),
      'hairColor': 'brownDark',
      'skinColor': 'tanned',
      'mouth': 'smile',
      'eyes': 'happy',
      if (hasGlasses) 'accessories': 'round',
    };
    final query = params.entries.map((e) => '${e.key}=${e.value}').join('&');
    return 'https://api.dicebear.com/9.x/avataaars-neutral/svg?$query';
  }

  @override
  Widget build(BuildContext context) {
    final url = _buildUrl();
    final avatarSize = size * 0.78;

    return SizedBox(
      width: size,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── DiceBear 头像（头 + 上半身）──
          Container(
            width: avatarSize, height: avatarSize,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFFF8EE), AppTheme.background],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: SvgPicture.network(
              url,
              width: avatarSize, height: avatarSize,
              placeholderBuilder: (_) => const Center(
                child: SizedBox(width: 20, height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2)),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // ── 下身配色条 ──
          _ColorBar(color: colorFromName(pantsColor), label: '裤子', size: size),
          const SizedBox(height: 6),
          _ColorBar(color: colorFromName(shoeColor), label: '鞋子', size: size),
        ],
      ),
    );
  }
}

/// 配色条组件
class _ColorBar extends StatelessWidget {
  final Color color;
  final String label;
  final double size;
  const _ColorBar({required this.color, required this.label, required this.size});

  @override
  Widget build(BuildContext context) {
    final w = size * 0.55;
    final hasSelection = color != CartoonAvatar.colorFromName('');
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 36,
          child: Text(label, style: const TextStyle(
            fontSize: 11, color: AppTheme.textSecondary,
          )),
        ),
        const SizedBox(width: 8),
        Container(
          width: w, height: 18,
          decoration: BoxDecoration(
            color: hasSelection ? color : AppTheme.border,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: hasSelection
                  ? color.withAlpha(180)
                  : Colors.transparent,
              width: 0.5,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          hasSelection ? '' : '未设置',
          style: TextStyle(
            fontSize: 11, color: hasSelection ? AppTheme.textSecondary : AppTheme.textHint,
          ),
        ),
      ],
    );
  }
}
