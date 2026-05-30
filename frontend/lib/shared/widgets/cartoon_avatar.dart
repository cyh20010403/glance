import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

/// 卡通形象预览组件 — Chibi 全身风格
///
/// 从头到脚的完整可爱卡通人物。
/// 实时反映：发型 / 上衣裤子鞋颜色 / 眼镜 / 背包。
/// 所有绘制均为矢量，任意尺寸清晰。
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
    this.size = 240,
  });

  static Color colorFromName(String name) {
    return switch (name) {
      '黑色' => const Color(0xFF3A3A3A),
      '白色' => const Color(0xFFF8F4EE),
      '灰色' => const Color(0xFFA0A0A0),
      '蓝色' => const Color(0xFF5D8CC4),
      '红色' => const Color(0xFFD46868),
      '粉色' => const Color(0xFFF0B4BC),
      '黄色' => const Color(0xFFEAC86A),
      '绿色' => const Color(0xFF8EA77D),
      '棕色' => const Color(0xFFA88B6E),
      '紫色' => const Color(0xFFB5A3C8),
      _ => const Color(0xFFD8D0C4),
    };
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size, height: size * 1.4,
      child: CustomPaint(
        painter: _ChibiPainter(
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

class _ChibiPainter extends CustomPainter {
  final Color topColor, pantsColor, shoeColor;
  final String hairstyle;
  final bool hasGlasses, hasBag;

  _ChibiPainter({
    required this.topColor,
    required this.pantsColor,
    required this.shoeColor,
    required this.hairstyle,
    required this.hasGlasses,
    required this.hasBag,
  });

  static const skin = Color(0xFFFFEDD4);
  static const skinDark = Color(0xFFF5DCC0);
  static const blush = Color(0x2BD46868);
  static const outline = Color(0xFF5D4E41);
  static const hairDark = Color(0xFF5C4033);
  static const bagColor = Color(0xFFD4A76A);
  static const bagStrap = Color(0xFFB08850);

  @override
  void paint(Canvas c, Size s) {
    final w = s.width, h = s.height;
    final cp = Paint()..isAntiAlias = true;
    final sp = Paint()
      ..isAntiAlias = true
      ..color = outline
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.009
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final headX = w * 0.5, headY = h * 0.155, headR = w * 0.195;
    final bodyTop = headY + headR + h * 0.005;
    final bodyH = h * 0.23, bodyW = w * 0.275;
    final bodyCx = headX;
    final bodyCy = bodyTop + bodyH * 0.5;
    final legTop = bodyTop + bodyH;
    final legH = h * 0.23;
    final shoeH = h * 0.042;

    // ── 腿（身体下方,先画）──
    for (final dx in [-bodyW * 0.2, bodyW * 0.2]) {
      _drawRoundedRect(c, Rect.fromLTWH(
        headX + dx - w * 0.055, legTop, w * 0.11, legH,
      ), w * 0.055, cp..color = pantsColor, sp);
    }

    // ── 身体 ──
    final body = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(bodyCx, bodyCy), width: bodyW, height: bodyH),
      Radius.circular(w * 0.06),
    );
    c.drawRRect(body, cp..color = topColor);
    c.drawRRect(body, sp);

    // ── 领口 ──
    final collarPath = Path()
      ..moveTo(bodyCx - bodyW * 0.22, bodyTop + h * 0.012)
      ..quadraticBezierTo(
          bodyCx - bodyW * 0.1, bodyTop + bodyH * 0.15,
          bodyCx, bodyTop + bodyH * 0.10)
      ..quadraticBezierTo(
          bodyCx + bodyW * 0.1, bodyTop + bodyH * 0.15,
          bodyCx + bodyW * 0.22, bodyTop + h * 0.012)
      ..quadraticBezierTo(
          bodyCx + bodyW * 0.08, bodyTop + bodyH * 0.06,
          bodyCx, bodyTop + bodyH * 0.02)
      ..quadraticBezierTo(
          bodyCx - bodyW * 0.08, bodyTop + bodyH * 0.06,
          bodyCx - bodyW * 0.22, bodyTop + h * 0.012)
      ..close();
    c.drawPath(collarPath, cp..color = skin);
    c.drawPath(collarPath, sp);

    // ── 袖子 ──
    for (final (dx, sign) in [(-bodyW * 0.52, -1.0), (bodyW * 0.52, 1.0)]) {
      final sx = bodyCx + dx, sy = bodyTop + bodyH * 0.18;
      final sleeve = RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(sx, sy), width: w * 0.087, height: bodyH * 0.45),
        Radius.circular(w * 0.04),
      );
      c.drawRRect(sleeve, cp..color = topColor);
      c.drawRRect(sleeve, sp);
      // 手
      c.drawCircle(Offset(sx, sy + bodyH * 0.38), w * 0.046, cp..color = skin);
      c.drawCircle(Offset(sx, sy + bodyH * 0.38), w * 0.046, sp);
    }

    // ── 鞋子 ──
    for (final (dx, dir) in [(-bodyW * 0.2, -1.0), (bodyW * 0.2, 1.0)]) {
      final sx = headX + dx, sy = legTop + legH;
      final shoePath = Path()
        ..moveTo(sx - w * 0.07, sy - h * 0.005)
        ..lineTo(sx - w * 0.055, sy + shoeH * 0.5)
        ..quadraticBezierTo(sx, sy + shoeH * 1.1, sx + w * 0.075, sy + shoeH * 0.5)
        ..lineTo(sx + w * 0.07, sy - h * 0.005)
        ..close();
      c.drawPath(shoePath, cp..color = shoeColor);
      c.drawPath(shoePath, sp);
      // 鞋带装饰
      c.drawCircle(Offset(sx, sy + shoeH * 0.35), w * 0.025, cp..color = Colors.white.withAlpha(120));
    }

    // ── 背包 ──
    if (hasBag) {
      final bx = bodyCx + bodyW * 0.38, by = bodyTop + bodyH * 0.28;
      // 包体
      final bag = RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(bx, by), width: w * 0.12, height: bodyH * 0.55),
        Radius.circular(w * 0.03),
      );
      c.drawRRect(bag, cp..color = bagColor);
      c.drawRRect(bag, sp);
      // 包扣
      c.drawCircle(Offset(bx, by - bodyH * 0.08), w * 0.018, cp..color = Colors.white.withAlpha(150));
      // 背带
      c.drawLine(
        Offset(bx - w * 0.04, by - bodyH * 0.28),
        Offset(bodyCx - bodyW * 0.25, bodyTop + bodyH * 0.05),
        Paint()
          ..color = bagStrap
          ..strokeWidth = w * 0.025
          ..strokeCap = StrokeCap.round,
      );
    }

    // ── 头发（头后面部分）──
    _drawHair(c, Offset(headX, headY + headR), headR, w, cp, sp);

    // ── 头 ──
    c.drawCircle(Offset(headX, headY + headR), headR, cp..color = skin);
    c.drawCircle(Offset(headX, headY + headR), headR, sp);

    // ── 刘海 ──
    _drawBangs(c, Offset(headX, headY + headR), headR, w, cp..color = hairDark);
    _drawBangs(c, Offset(headX, headY + headR), headR, w, sp);

    // ── 五官 ──
    // 眼睛
    for (final sign in [-1.0, 1.0]) {
      final ex = headX + sign * headR * 0.33, ey = headY + headR * 0.82;
      // 眼白
      final eyeOval = RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(ex, ey), width: headR * 0.28, height: headR * 0.35),
        Radius.circular(headR * 0.14),
      );
      c.drawRRect(eyeOval, cp..color = Colors.white);
      c.drawRRect(eyeOval, sp..strokeWidth = w * 0.007);
      // 瞳孔
      c.drawCircle(Offset(ex + sign * headR * 0.02, ey + headR * 0.04),
          headR * 0.11, cp..color = const Color(0xFF4A3520));
      // 高光
      c.drawCircle(Offset(ex - sign * headR * 0.04, ey - headR * 0.07),
          headR * 0.055, cp..color = Colors.white);
    }

    // 腮红
    for (final sign in [-1.0, 1.0]) {
      c.drawCircle(
        Offset(headX + sign * headR * 0.55, headY + headR * 1.05),
        headR * 0.13, cp..color = blush,
      );
    }

    // 嘴巴
    final mouth = Path()
      ..moveTo(headX - headR * 0.18, headY + headR * 1.08)
      ..quadraticBezierTo(headX, headY + headR * 1.28, headX + headR * 0.18, headY + headR * 1.08);
    c.drawPath(mouth, sp..strokeWidth = w * 0.008);

    // ── 眼镜 ──
    if (hasGlasses) {
      final gp = Paint()
        ..color = const Color(0xFF4A4A4A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.009
        ..isAntiAlias = true;
      for (final sign in [-1.0, 1.0]) {
        final gx = headX + sign * headR * 0.33, gy = headY + headR * 0.82;
        c.drawCircle(Offset(gx, gy), headR * 0.24, gp);
        // 镜腿
        c.drawLine(
          Offset(gx + sign * headR * 0.24, gy),
          Offset(gx + sign * headR * 0.55, gy - headR * 0.12),
          gp,
        );
      }
      // 鼻梁
      c.drawLine(
        Offset(headX - headR * 0.09, headY + headR * 0.82),
        Offset(headX + headR * 0.09, headY + headR * 0.82),
        gp,
      );
    }
  }

  // ── 头发（后部）──
  void _drawHair(Canvas c, Offset hc, double r, double w, Paint fill, Paint stroke) {
    final path = Path();
    switch (hairstyle) {
      case '长发':
        path.moveTo(hc.dx - r * 1.08, hc.dy - r * 0.05);
        path.quadraticBezierTo(hc.dx - r * 1.2, hc.dy - r * 0.9, hc.dx - r * 0.5, hc.dy - r * 1.1);
        path.quadraticBezierTo(hc.dx, hc.dy - r * 1.2, hc.dx + r * 0.5, hc.dy - r * 1.1);
        path.quadraticBezierTo(hc.dx + r * 1.2, hc.dy - r * 0.9, hc.dx + r * 1.08, hc.dy - r * 0.05);
        // 垂发
        path.quadraticBezierTo(hc.dx + r * 1.3, hc.dy + r * 0.5, hc.dx + r * 0.75, hc.dy + r * 1.6);
        path.lineTo(hc.dx + r * 0.6, hc.dy + r * 1.6);
        path.quadraticBezierTo(hc.dx + r * 1.0, hc.dy + r * 0.4, hc.dx + r * 0.35, hc.dy - r * 0.15);
        path.lineTo(hc.dx - r * 0.35, hc.dy - r * 0.15);
        path.quadraticBezierTo(hc.dx - r * 1.0, hc.dy + r * 0.4, hc.dx - r * 0.6, hc.dy + r * 1.6);
        path.lineTo(hc.dx - r * 0.75, hc.dy + r * 1.6);
        path.quadraticBezierTo(hc.dx - r * 1.3, hc.dy + r * 0.5, hc.dx - r * 1.08, hc.dy - r * 0.05);
        break;

      case '卷发':
        path.moveTo(hc.dx - r * 1.08, hc.dy - r * 0.02);
        for (var i = 0; i < 8; i++) {
          final a = -math.pi * 0.48 + math.pi * 1.1 * i / 7;
          final bulge = (i % 2 == 0) ? r * 1.28 : r * 1.1;
          path.lineTo(hc.dx + math.cos(a) * bulge, hc.dy - r + math.sin(a) * r * 1.12);
        }
        path.quadraticBezierTo(hc.dx + r * 1.12, hc.dy + r * 0.35, hc.dx + r * 0.7, hc.dy + r * 0.7);
        path.lineTo(hc.dx + r * 0.55, hc.dy + r * 0.7);
        path.quadraticBezierTo(hc.dx + r * 0.9, hc.dy + r * 0.2, hc.dx + r * 0.25, hc.dy - r * 0.1);
        path.lineTo(hc.dx - r * 0.25, hc.dy - r * 0.1);
        path.quadraticBezierTo(hc.dx - r * 0.9, hc.dy + r * 0.2, hc.dx - r * 0.55, hc.dy + r * 0.7);
        path.lineTo(hc.dx - r * 0.7, hc.dy + r * 0.7);
        path.quadraticBezierTo(hc.dx - r * 1.12, hc.dy + r * 0.35, hc.dx - r * 1.08, hc.dy - r * 0.02);
        break;

      case '马尾':
        path.moveTo(hc.dx - r * 1.05, hc.dy - r * 0.08);
        path.quadraticBezierTo(hc.dx - r * 1.1, hc.dy - r * 0.9, hc.dx - r * 0.4, hc.dy - r * 1.05);
        path.quadraticBezierTo(hc.dx, hc.dy - r * 1.15, hc.dx + r * 0.4, hc.dy - r * 1.05);
        path.quadraticBezierTo(hc.dx + r * 1.1, hc.dy - r * 0.9, hc.dx + r * 1.05, hc.dy - r * 0.08);
        path.quadraticBezierTo(hc.dx + r * 0.5, hc.dy - r * 0.2, hc.dx + r * 0.12, hc.dy - r * 0.55);
        path.lineTo(hc.dx - r * 0.12, hc.dy - r * 0.55);
        path.quadraticBezierTo(hc.dx - r * 0.5, hc.dy - r * 0.2, hc.dx - r * 1.05, hc.dy - r * 0.08);
        path.close();
        c.drawPath(path, fill..color = hairDark);
        c.drawPath(path, stroke);

        // 马尾垂发
        final tail = Path()
          ..moveTo(hc.dx - r * 0.1, hc.dy - r * 0.55)
          ..cubicTo(hc.dx + r * 0.5, hc.dy - r * 0.7, hc.dx + r * 0.35, hc.dy + r * 1.1, hc.dx + r * 0.12, hc.dy + r * 1.5)
          ..cubicTo(hc.dx + r * 0.08, hc.dy + r * 1.6, hc.dx - r * 0.08, hc.dy + r * 1.6, hc.dx - r * 0.04, hc.dy + r * 1.5)
          ..cubicTo(hc.dx + r * 0.18, hc.dy + r * 0.9, hc.dx + r * 0.2, hc.dy - r * 0.2, hc.dx - r * 0.08, hc.dy - r * 0.55)
          ..close();
        c.drawPath(tail, fill..color = hairDark);
        c.drawPath(tail, stroke);
        return;

      case '丸子头':
        path.addPath(_shortHairTop(hc, r), Offset.zero);
        c.drawPath(path, fill..color = hairDark);
        c.drawPath(path, stroke);
        // 丸子在头顶
        final bunC = Offset(hc.dx, hc.dy - r * 1.1);
        c.drawCircle(bunC, r * 0.28, fill..color = hairDark);
        c.drawCircle(bunC, r * 0.28, stroke);
        return;

      default: // 短发
        path.addPath(_shortHairTop(hc, r), Offset.zero);
        c.drawPath(path, fill..color = hairDark);
        c.drawPath(path, stroke);
        return;
    }
    path.close();
    c.drawPath(path, fill..color = hairDark);
    c.drawPath(path, stroke);
  }

  Path _shortHairTop(Offset hc, double r) {
    return Path()
      ..moveTo(hc.dx - r * 1.08, hc.dy - r * 0.05)
      ..quadraticBezierTo(hc.dx - r * 1.12, hc.dy - r * 0.95, hc.dx - r * 0.5, hc.dy - r * 1.15)
      ..quadraticBezierTo(hc.dx, hc.dy - r * 1.25, hc.dx + r * 0.5, hc.dy - r * 1.15)
      ..quadraticBezierTo(hc.dx + r * 1.12, hc.dy - r * 0.95, hc.dx + r * 1.08, hc.dy - r * 0.05)
      ..quadraticBezierTo(hc.dx + r * 0.6, hc.dy - r * 0.35, hc.dx + r * 0.2, hc.dy - r * 0.35)
      ..lineTo(hc.dx - r * 0.2, hc.dy - r * 0.35)
      ..quadraticBezierTo(hc.dx - r * 0.6, hc.dy - r * 0.35, hc.dx - r * 1.08, hc.dy - r * 0.05)
      ..close();
  }

  // ── 刘海 ──
  void _drawBangs(Canvas c, Offset hc, double r, double w, Paint p) {
    final path = switch (hairstyle) {
      '长发' || '马尾' => Path()
        ..moveTo(hc.dx - r * 1.02, hc.dy - r * 0.12)
        ..quadraticBezierTo(hc.dx - r * 0.9, hc.dy - r * 0.7, hc.dx - r * 0.3, hc.dy - r * 0.75)
        ..quadraticBezierTo(hc.dx, hc.dy - r * 0.8, hc.dx + r * 0.3, hc.dy - r * 0.75)
        ..quadraticBezierTo(hc.dx + r * 0.9, hc.dy - r * 0.7, hc.dx + r * 1.02, hc.dy - r * 0.12)
        ..lineTo(hc.dx + r * 0.4, hc.dy - r * 0.08)
        ..quadraticBezierTo(hc.dx, hc.dy - r * 0.2, hc.dx - r * 0.4, hc.dy - r * 0.08)
        ..close(),
      '卷发' => Path()
        ..moveTo(hc.dx - r * 1.02, hc.dy - r * 0.08)
        ..quadraticBezierTo(hc.dx - r * 0.85, hc.dy - r * 0.65, hc.dx - r * 0.35, hc.dy - r * 0.72)
        ..cubicTo(hc.dx - r * 0.15, hc.dy - r * 0.68, hc.dx - r * 0.05, hc.dy - r * 0.7, hc.dx, hc.dy - r * 0.75)
        ..cubicTo(hc.dx + r * 0.05, hc.dy - r * 0.7, hc.dx + r * 0.15, hc.dy - r * 0.68, hc.dx + r * 0.35, hc.dy - r * 0.72)
        ..quadraticBezierTo(hc.dx + r * 0.85, hc.dy - r * 0.65, hc.dx + r * 1.02, hc.dy - r * 0.08)
        ..lineTo(hc.dx + r * 0.35, hc.dy - r * 0.05)
        ..quadraticBezierTo(hc.dx, hc.dy - r * 0.18, hc.dx - r * 0.35, hc.dy - r * 0.05)
        ..close(),
      _ => Path()
        ..moveTo(hc.dx - r * 1.02, hc.dy - r * 0.08)
        ..quadraticBezierTo(hc.dx - r * 0.85, hc.dy - r * 0.6, hc.dx - r * 0.2, hc.dy - r * 0.7)
        ..quadraticBezierTo(hc.dx, hc.dy - r * 0.75, hc.dx + r * 0.2, hc.dy - r * 0.7)
        ..quadraticBezierTo(hc.dx + r * 0.85, hc.dy - r * 0.6, hc.dx + r * 1.02, hc.dy - r * 0.08)
        ..lineTo(hc.dx + r * 0.25, hc.dy - r * 0.15)
        ..quadraticBezierTo(hc.dx, hc.dy - r * 0.1, hc.dx - r * 0.25, hc.dy - r * 0.15)
        ..close(),
    };
    c.drawPath(path, p);
  }

  void _drawRoundedRect(Canvas c, Rect rect, double r, Paint fill, Paint stroke) {
    c.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(r)), fill);
    c.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(r)), stroke);
  }

  @override
  bool shouldRepaint(covariant _ChibiPainter o) =>
      topColor != o.topColor || pantsColor != o.pantsColor ||
      shoeColor != o.shoeColor || hairstyle != o.hairstyle ||
      hasGlasses != o.hasGlasses || hasBag != o.hasBag;
}
