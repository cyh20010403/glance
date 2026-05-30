import 'dart:math' as math;
import 'package:flutter/material.dart';

/// 卡通形象预览组件
///
/// 根据用户选择的穿着特征（上衣/裤子/鞋子颜色、发型、眼镜、背包）
/// 实时绘制一个可爱的卡通人物形象。
///
/// 使用方式：
/// ```dart
/// CartoonAvatar(
///   topColor: '蓝色',
///   pantsColor: '黑色',
///   shoeColor: '白色',
///   hairstyle: '短发',
///   hasGlasses: true,
///   hasBag: false,
/// )
/// ```
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

  /// 中文颜色 → 实际颜色值
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
      _ => const Color(0xFFE0D8CC), // 默认暖灰
    };
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size * 1.35,
      child: CustomPaint(
        painter: _CartoonPainter(
          topColor: colorFromName(topColor),
          pantsColor: colorFromName(pantsColor),
          shoeColor: colorFromName(shoeColor),
          hairstyle: hairstyle,
          hasGlasses: hasGlasses,
          hasBag: hasBag,
        ),
      ),
    );
  }
}

class _CartoonPainter extends CustomPainter {
  final Color topColor;
  final Color pantsColor;
  final Color shoeColor;
  final String hairstyle;
  final bool hasGlasses;
  final bool hasBag;

  _CartoonPainter({
    required this.topColor,
    required this.pantsColor,
    required this.shoeColor,
    required this.hairstyle,
    required this.hasGlasses,
    required this.hasBag,
  });

  // 肤色
  static const skinColor = Color(0xFFFFE4C9);
  // ignore: unused_field
  static const skinShadow = Color(0xFFF5D5B8); // 备用肤色
  static const blushColor = Color(0x33D46868);
  static const outlineColor = Color(0xFF5C4F45);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w / 2;

    // 比例基准
    final headY = h * 0.08;
    final headR = w * 0.20;
    final bodyTop = headY + headR * 1.7;
    final bodyH = h * 0.28;
    final bodyW = w * 0.32;
    final legTop = bodyTop + bodyH;
    final legH = h * 0.22;
    final shoeTop = legTop + legH;

    // ── 腿（画在身体之前，被上衣遮挡）──
    _drawLeg(canvas, cx - bodyW * 0.28, legTop, legH, shoeTop);
    _drawLeg(canvas, cx + bodyW * 0.08, legTop, legH, shoeTop);

    // ── 身体 ──
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(cx, bodyTop + bodyH / 2), width: bodyW, height: bodyH),
      const Radius.circular(14),
    );
    canvas.drawRRect(bodyRect, Paint()..color = topColor);
    // 身体描边
    canvas.drawRRect(
      bodyRect,
      Paint()
        ..color = outlineColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );

    // ── 领口 ──
    final collarPath = Path()
      ..moveTo(cx - bodyW * 0.15, bodyTop + 4)
      ..quadraticBezierTo(cx - bodyW * 0.08, bodyTop + bodyH * 0.18, cx, bodyTop + bodyH * 0.12)
      ..quadraticBezierTo(cx + bodyW * 0.08, bodyTop + bodyH * 0.18, cx + bodyW * 0.15, bodyTop + 4);
    canvas.drawPath(
      collarPath,
      Paint()
        ..color = skinColor
        ..style = PaintingStyle.fill,
    );
    canvas.drawPath(
      collarPath,
      Paint()
        ..color = outlineColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );

    // ── 手臂 ──
    _drawArm(canvas, cx - bodyW * 0.52, bodyTop + bodyH * 0.15, false);
    _drawArm(canvas, cx + bodyW * 0.52, bodyTop + bodyH * 0.15, true);

    // ── 鞋子 ──
    _drawShoe(canvas, cx - bodyW * 0.28, shoeTop);
    _drawShoe(canvas, cx + bodyW * 0.08, shoeTop);

    // ── 背包 ──
    if (hasBag) {
      _drawBag(canvas, cx + bodyW * 0.35, bodyTop + bodyH * 0.15);
    }

    // ── 头 ──
    // 头发（画在头部后面）
    _drawHair(canvas, Offset(cx, headY + headR), headR);

    // 脸部
    canvas.drawCircle(Offset(cx, headY + headR), headR, Paint()..color = skinColor);
    canvas.drawCircle(
      Offset(cx, headY + headR),
      headR,
      Paint()
        ..color = outlineColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );

    // ── 五官 ──
    // 眼睛
    _drawEye(canvas, Offset(cx - headR * 0.35, headY + headR * 0.85), headR);
    _drawEye(canvas, Offset(cx + headR * 0.35, headY + headR * 0.85), headR);

    // 腮红
    canvas.drawCircle(
      Offset(cx - headR * 0.55, headY + headR * 1.05),
      headR * 0.14,
      Paint()..color = blushColor,
    );
    canvas.drawCircle(
      Offset(cx + headR * 0.55, headY + headR * 1.05),
      headR * 0.14,
      Paint()..color = blushColor,
    );

    // 嘴巴（微笑弧线）
    final mouthPath = Path()
      ..moveTo(cx - headR * 0.22, headY + headR * 1.12)
      ..quadraticBezierTo(cx, headY + headR * 1.3, cx + headR * 0.22, headY + headR * 1.12);
    canvas.drawPath(
      mouthPath,
      Paint()
        ..color = outlineColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2
        ..strokeCap = StrokeCap.round,
    );

    // ── 眼镜 ──
    if (hasGlasses) {
      _drawGlasses(canvas, Offset(cx, headY + headR * 0.85), headR);
    }
  }

  // ─── 眼睛 ───
  void _drawEye(Canvas canvas, Offset center, double scale) {
    final eyeR = scale * 0.13;
    // 眼白
    canvas.drawCircle(center, eyeR * 1.3, Paint()..color = Colors.white);
    // 瞳孔
    canvas.drawCircle(
      Offset(center.dx, center.dy + eyeR * 0.1),
      eyeR * 0.65,
      Paint()..color = const Color(0xFF4A3728),
    );
    // 高光
    canvas.drawCircle(
      Offset(center.dx - eyeR * 0.3, center.dy - eyeR * 0.35),
      eyeR * 0.25,
      Paint()..color = Colors.white,
    );
  }

  // ─── 眼镜 ───
  void _drawGlasses(Canvas canvas, Offset eyeCenter, double scale) {
    final frameR = scale * 0.24;
    final bridgeY = eyeCenter.dy;

    final paint = Paint()
      ..color = const Color(0xFF5C4F45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // 左镜框
    canvas.drawCircle(Offset(eyeCenter.dx - scale * 0.35, bridgeY), frameR, paint);
    // 右镜框
    canvas.drawCircle(Offset(eyeCenter.dx + scale * 0.35, bridgeY), frameR, paint);
    // 鼻梁
    canvas.drawLine(
      Offset(eyeCenter.dx - scale * 0.11, bridgeY),
      Offset(eyeCenter.dx + scale * 0.11, bridgeY),
      paint,
    );
    // 镜腿
    canvas.drawLine(
      Offset(eyeCenter.dx - scale * 0.35 - frameR, bridgeY),
      Offset(eyeCenter.dx - scale * 0.8, bridgeY - scale * 0.15),
      paint,
    );
    canvas.drawLine(
      Offset(eyeCenter.dx + scale * 0.35 + frameR, bridgeY),
      Offset(eyeCenter.dx + scale * 0.8, bridgeY - scale * 0.15),
      paint,
    );
  }

  // ─── 头发 ───
  void _drawHair(Canvas canvas, Offset headCenter, double headR) {
    final hairPaint = Paint()..color = const Color(0xFF4A3728);
    final outlineP = Paint()
      ..color = outlineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    switch (hairstyle) {
      case '长发':
        _drawLongHair(canvas, headCenter, headR, hairPaint, outlineP);
      case '卷发':
        _drawCurlyHair(canvas, headCenter, headR, hairPaint, outlineP);
      case '马尾':
        _drawPonytail(canvas, headCenter, headR, hairPaint, outlineP);
      case '丸子头':
        _drawBun(canvas, headCenter, headR, hairPaint, outlineP);
      default: // 短发
        _drawShortHair(canvas, headCenter, headR, hairPaint, outlineP);
    }
  }

  void _drawShortHair(Canvas canvas, Offset c, double r, Paint fill, Paint stroke) {
    final path = Path()
      ..moveTo(c.dx - r * 1.08, c.dy - r * 0.1)
      ..quadraticBezierTo(c.dx - r * 1.15, c.dy - r * 1.1, c.dx - r * 0.6, c.dy - r * 1.25)
      ..quadraticBezierTo(c.dx, c.dy - r * 1.35, c.dx + r * 0.6, c.dy - r * 1.25)
      ..quadraticBezierTo(c.dx + r * 1.15, c.dy - r * 1.1, c.dx + r * 1.08, c.dy - r * 0.1)
      ..quadraticBezierTo(c.dx + r * 0.7, c.dy - r * 0.5, c.dx + r * 0.25, c.dy - r * 0.45)
      ..lineTo(c.dx - r * 0.25, c.dy - r * 0.45)
      ..quadraticBezierTo(c.dx - r * 0.7, c.dy - r * 0.5, c.dx - r * 1.08, c.dy - r * 0.1)
      ..close();
    canvas.drawPath(path, fill);
    canvas.drawPath(path, stroke);
  }

  void _drawLongHair(Canvas canvas, Offset c, double r, Paint fill, Paint stroke) {
    // 头顶 + 两侧垂发
    final path = Path()
      ..moveTo(c.dx - r * 1.08, c.dy - r * 0.1)
      ..quadraticBezierTo(c.dx - r * 1.15, c.dy - r * 1.1, c.dx - r * 0.5, c.dy - r * 1.2)
      ..quadraticBezierTo(c.dx, c.dy - r * 1.3, c.dx + r * 0.5, c.dy - r * 1.2)
      ..quadraticBezierTo(c.dx + r * 1.15, c.dy - r * 1.1, c.dx + r * 1.08, c.dy - r * 0.1)
      // 右侧垂发
      ..quadraticBezierTo(c.dx + r * 1.2, c.dy + r * 0.6, c.dx + r * 0.7, c.dy + r * 1.5)
      ..lineTo(c.dx + r * 0.55, c.dy + r * 1.5)
      ..quadraticBezierTo(c.dx + r * 0.9, c.dy + r * 0.4, c.dx + r * 0.3, c.dy - r * 0.3)
      // 左侧垂发
      ..lineTo(c.dx - r * 0.3, c.dy - r * 0.3)
      ..quadraticBezierTo(c.dx - r * 0.9, c.dy + r * 0.4, c.dx - r * 0.55, c.dy + r * 1.5)
      ..lineTo(c.dx - r * 0.7, c.dy + r * 1.5)
      ..quadraticBezierTo(c.dx - r * 1.2, c.dy + r * 0.6, c.dx - r * 1.08, c.dy - r * 0.1)
      ..close();
    canvas.drawPath(path, fill);
    canvas.drawPath(path, stroke);
  }

  void _drawCurlyHair(Canvas canvas, Offset c, double r, Paint fill, Paint stroke) {
    // 蓬松的波浪形轮廓
    final path = Path();
    path.moveTo(c.dx - r * 1.1, c.dy - r * 0.05);
    for (var i = 0; i < 8; i++) {
      final angle = -3.14 * 0.45 + 3.14 * 1.1 * i / 7;
      final bulge = (i % 2 == 0) ? r * 1.25 : r * 1.08;
      final x = c.dx + math.cos(angle) * bulge;
      final y = c.dy - r + math.sin(angle) * r * 1.15;
      path.lineTo(x, y);
    }
    // 两侧
    path.quadraticBezierTo(c.dx + r * 1.1, c.dy + r * 0.3, c.dx + r * 0.7, c.dy + r * 0.6);
    path.lineTo(c.dx + r * 0.55, c.dy + r * 0.6);
    path.quadraticBezierTo(c.dx + r * 0.9, c.dy + r * 0.2, c.dx + r * 0.2, c.dy - r * 0.2);
    path.lineTo(c.dx - r * 0.2, c.dy - r * 0.2);
    path.quadraticBezierTo(c.dx - r * 0.9, c.dy + r * 0.2, c.dx - r * 0.55, c.dy + r * 0.6);
    path.lineTo(c.dx - r * 0.7, c.dy + r * 0.6);
    path.quadraticBezierTo(c.dx - r * 1.1, c.dy + r * 0.3, c.dx - r * 1.1, c.dy - r * 0.05);
    path.close();
    canvas.drawPath(path, fill);
    canvas.drawPath(path, stroke);

    // 卷发纹理
    for (var i = 0; i < 3; i++) {
      final tx = c.dx - r * 0.3 + i * r * 0.3;
      final ty = c.dy - r * 1.0;
      final cp = Path()
        ..moveTo(tx, ty)
        ..quadraticBezierTo(tx - r * 0.08, ty - r * 0.15, tx, ty - r * 0.25);
      canvas.drawPath(cp, stroke..strokeWidth = 0.8);
    }
  }

  void _drawPonytail(Canvas canvas, Offset c, double r, Paint fill, Paint stroke) {
    // 头顶短发部分
    final topPath = Path()
      ..moveTo(c.dx - r * 1.05, c.dy - r * 0.15)
      ..quadraticBezierTo(c.dx - r * 1.1, c.dy - r * 1.0, c.dx - r * 0.4, c.dy - r * 1.15)
      ..quadraticBezierTo(c.dx, c.dy - r * 1.25, c.dx + r * 0.4, c.dy - r * 1.15)
      ..quadraticBezierTo(c.dx + r * 1.1, c.dy - r * 1.0, c.dx + r * 1.05, c.dy - r * 0.15)
      ..quadraticBezierTo(c.dx + r * 0.5, c.dy - r * 0.3, c.dx + r * 0.1, c.dy - r * 0.6)
      ..lineTo(c.dx - r * 0.1, c.dy - r * 0.6)
      ..quadraticBezierTo(c.dx - r * 0.5, c.dy - r * 0.3, c.dx - r * 1.05, c.dy - r * 0.15)
      ..close();
    canvas.drawPath(topPath, fill);
    canvas.drawPath(topPath, stroke);

    // 马尾
    final tailPath = Path()
      ..moveTo(c.dx - r * 0.12, c.dy - r * 0.6)
      ..cubicTo(c.dx + r * 0.6, c.dy - r * 0.8, c.dx + r * 0.4, c.dy + r * 1.0, c.dx + r * 0.15, c.dy + r * 1.4)
      ..cubicTo(c.dx + r * 0.1, c.dy + r * 1.5, c.dx - r * 0.1, c.dy + r * 1.5, c.dx - r * 0.05, c.dy + r * 1.4)
      ..cubicTo(c.dx + r * 0.2, c.dy + r * 0.8, c.dx + r * 0.25, c.dy - r * 0.3, c.dx - r * 0.05, c.dy - r * 0.6)
      ..close();
    canvas.drawPath(tailPath, fill);
    canvas.drawPath(tailPath, stroke);
  }

  void _drawBun(Canvas canvas, Offset c, double r, Paint fill, Paint stroke) {
    // 短发基础
    _drawShortHair(canvas, c, r, fill, stroke);
    // 丸子
    final bunCenter = Offset(c.dx, c.dy - r * 1.2);
    canvas.drawCircle(bunCenter, r * 0.28, fill);
    canvas.drawCircle(bunCenter, r * 0.28, stroke);
  }

  // ─── 腿 ───
  void _drawLeg(Canvas canvas, double x, double top, double h, double shoeTop) {
    final legW = 14.0;
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(x - legW / 2, top, legW, h),
      const Radius.circular(7),
    );
    canvas.drawRRect(rect, Paint()..color = pantsColor);
    canvas.drawRRect(
      rect,
      Paint()
        ..color = outlineColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );
  }

  // ─── 鞋子 ───
  void _drawShoe(Canvas canvas, double cx, double top) {
    final path = Path()
      ..moveTo(cx - 10, top)
      ..lineTo(cx - 8, top + 12)
      ..quadraticBezierTo(cx, top + 16, cx + 10, top + 12)
      ..lineTo(cx + 12, top)
      ..close();
    canvas.drawPath(path, Paint()..color = shoeColor);
    canvas.drawPath(
      path,
      Paint()
        ..color = outlineColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );
  }

  // ─── 手臂 ───
  void _drawArm(Canvas canvas, double x, double top, bool isRight) {
    final path = Path()
      ..moveTo(x, top)
      ..quadraticBezierTo(
        isRight ? x + 8 : x - 8, top + 22,
        isRight ? x + 6 : x - 6, top + 40,
      );
    canvas.drawPath(
      path,
      Paint()
        ..color = skinColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawPath(
      path,
      Paint()
        ..color = outlineColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0
        ..strokeCap = StrokeCap.round,
    );
    // 小手
    canvas.drawCircle(
      Offset(isRight ? x + 6 : x - 6, top + 42),
      6,
      Paint()..color = skinColor,
    );
    canvas.drawCircle(
      Offset(isRight ? x + 6 : x - 6, top + 42),
      6,
      Paint()
        ..color = outlineColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );
  }

  // ─── 背包 ───
  void _drawBag(Canvas canvas, double x, double y) {
    final bagPaint = Paint()..color = const Color(0xFFC9A05A);
    final bagRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(x, y + 14), width: 22, height: 28),
      const Radius.circular(6),
    );
    canvas.drawRRect(bagRect, bagPaint);
    canvas.drawRRect(
      bagRect,
      Paint()
        ..color = outlineColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );
    // 背带
    canvas.drawLine(
      Offset(x - 8, y),
      Offset(x - 16, y - 20),
      Paint()
        ..color = const Color(0xFFA08050)
        ..strokeWidth = 2.5,
    );
  }

  @override
  bool shouldRepaint(covariant _CartoonPainter old) {
    return topColor != old.topColor ||
        pantsColor != old.pantsColor ||
        shoeColor != old.shoeColor ||
        hairstyle != old.hairstyle ||
        hasGlasses != old.hasGlasses ||
        hasBag != old.hasBag;
  }
}
