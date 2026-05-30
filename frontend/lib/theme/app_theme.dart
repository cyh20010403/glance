import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// 《回眸》App 主题 —「暮光手帖」
///
/// 美学方向：黄昏时分的私人手册
/// - 暖黄纸页底色，仿旧纸质感
/// - 靛蓝墨迹主色，克制而深情
/// - 琥珀微光强调，路灯般温暖
/// - 毛玻璃卡片 + 不对称留白
/// - 衬线标题字体 + 系统正文
class AppTheme {
  AppTheme._();

  // === 品牌色系 ===

  /// 靛蓝 — 墨迹主色
  static const Color primary = Color(0xFF3A3F5C);

  /// 灰粉 — 脸红辅色
  static const Color secondary = Color(0xFFC9A5A5);

  /// 琥珀 — 路灯般温暖的强调色
  static const Color accent = Color(0xFFD4954A);

  // === 中性色 ===

  /// 暖奶油 — 纸页底色
  static const Color background = Color(0xFFFAF5EF);

  /// 霜白 — 卡片表面
  static const Color surface = Color(0xFFFFFBF6);

  /// 深灰 — 正文墨色
  static const Color textPrimary = Color(0xFF363131);

  /// 中灰 — 辅助文字
  static const Color textSecondary = Color(0xFF9B9088);

  /// 浅灰 — 占位提示
  static const Color textHint = Color(0xFFC4BBB2);

  /// 暖灰 — 分割线/边框
  static const Color border = Color(0xFFE8E0D5);

  /// 错误红
  static const Color error = Color(0xFFD46868);

  /// 成功绿
  static const Color success = Color(0xFF8EA77D);

  // === 圆角 ===
  static const double radiusSm = 8;
  static const double radiusMd = 14;
  static const double radiusLg = 18;
  static const double radiusXl = 24;
  static const double radiusFull = 999;

  // === 间距 ===
  static const double spacingXs = 4;
  static const double spacingSm = 8;
  static const double spacingMd = 12;
  static const double spacingLg = 16;
  static const double spacingXl = 20;
  static const double spacing2xl = 24;
  static const double spacing3xl = 32;
  static const double spacing4xl = 48;
  static const double spacing5xl = 64;

  // === 阴影 ===

  /// 微阴影 — 毛玻璃卡片
  static const shadowSm = [
    BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 6,
      offset: Offset(0, 2),
    ),
  ];

  /// 中阴影 — 浮起卡片
  static const shadowMd = [
    BoxShadow(
      color: Color(0x12000000),
      blurRadius: 16,
      offset: Offset(0, 4),
    ),
  ];

  /// 暖光阴影 — 强调卡片（带琥珀色调）
  static const shadowGlow = [
    BoxShadow(
      color: Color(0x18D4954A),
      blurRadius: 20,
      offset: Offset(0, 6),
    ),
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];

  // === 品牌渐变 ===

  /// 纸页渐变 — 从暖白到奶油
  static const LinearGradient paperGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFFFBF6), Color(0xFFF7F0E6)],
  );

  /// 暮光渐变 — 从琥珀到灰粉（用于仪式感页面）
  static const LinearGradient twilightGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFF3E0), Color(0xFFFFF0F0)],
  );

  // === ThemeData ===
  static ThemeData get lightTheme {
    final baseTextTheme = ThemeData.light().textTheme;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: primary,
        secondary: secondary,
        surface: surface,
        error: error,
      ),
      scaffoldBackgroundColor: background,

      // 字体：Noto Serif SC 用于标题，系统字体用于正文
      textTheme: GoogleFonts.notoSerifScTextTheme(
        baseTextTheme.copyWith(
          headlineLarge: const TextStyle(
            fontSize: 28, fontWeight: FontWeight.bold,
            color: textPrimary, height: 1.3, letterSpacing: -0.5,
          ),
          headlineMedium: const TextStyle(
            fontSize: 22, fontWeight: FontWeight.w600,
            color: textPrimary, height: 1.3, letterSpacing: -0.3,
          ),
          titleLarge: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600,
            color: textPrimary, height: 1.4,
          ),
          titleMedium: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500,
            color: textPrimary, height: 1.4,
          ),
          bodyLarge: const TextStyle(
            fontSize: 16, color: textPrimary, height: 1.6,
          ),
          bodyMedium: const TextStyle(
            fontSize: 14, color: textSecondary, height: 1.5,
          ),
          bodySmall: const TextStyle(
            fontSize: 12, color: textHint, height: 1.4,
          ),
          labelLarge: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600,
            color: Colors.white, letterSpacing: 0.5,
          ),
        ),
      ),

      // AppBar — 透明毛玻璃
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
      ),

      // 主按钮 — 靛蓝底色 + 微光
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
          textStyle: GoogleFonts.notoSerifSc(
            fontSize: 16, fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),

      // 文字按钮
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: textSecondary,
          textStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // 输入框 — 霜白底色 + 暖灰边框
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: spacingXl, vertical: spacingLg,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          borderSide: const BorderSide(color: border, width: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          borderSide: const BorderSide(color: border, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          borderSide: const BorderSide(color: primary, width: 1.2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          borderSide: const BorderSide(color: error),
        ),
        hintStyle: const TextStyle(color: textHint, fontSize: 15),
      ),

      // 卡片 — 霜白底 + 微阴影
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusXl),
          side: const BorderSide(color: border, width: 0.5),
        ),
        margin: EdgeInsets.zero,
      ),

      // 分割线
      dividerTheme: const DividerThemeData(
        color: border,
        thickness: 0.5,
        space: 0,
      ),

      // Chip/标签
      chipTheme: ChipThemeData(
        backgroundColor: surface,
        selectedColor: primary.withValues(alpha: 0.08),
        labelStyle: const TextStyle(
          fontSize: 13, color: textPrimary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusFull),
          side: const BorderSide(color: border, width: 0.5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
    );
  }
}
