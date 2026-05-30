import 'package:flutter/material.dart';

/// 《回眸》App 主题
///
/// 风格：iOS 极简风
/// - 白色背景 + 柔和渐变
/// - 圆角统一 16px
/// - 阴影轻量
/// - 青春感、呼吸感
class AppTheme {
  AppTheme._();

  // === 品牌色系 ===
  /// 主色 - 暖橙（品牌记忆点）
  static const Color primary = Color(0xFFE8826C);

  /// 次要色 - 浅桃（渐变辅助）
  static const Color secondary = Color(0xFFF4A896);

  /// 强调色 - 紫调（匹配按钮等）
  static const Color accent = Color(0xFF8B5E83);

  // === 中性色 ===
  static const Color background = Color(0xFFFAF8F5);
  static const Color surface = Colors.white;
  static const Color textPrimary = Color(0xFF2D2B32);
  static const Color textSecondary = Color(0xFF8E8B94);
  static const Color textHint = Color(0xFFC4C1C9);
  static const Color border = Color(0xFFE8E6EB);
  static const Color error = Color(0xFFE05555);

  // === 圆角 ===
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 20;
  static const double radiusFull = 999;

  // === 间距 ===
  static const double spacingXs = 4;
  static const double spacingSm = 8;
  static const double spacingMd = 12;
  static const double spacingLg = 16;
  static const double spacingXl = 20;
  static const double spacing2xl = 24;
  static const double spacing3xl = 32;

  // === 阴影 ===
  static const shadowSm = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];

  static const shadowMd = [
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 16,
      offset: Offset(0, 4),
    ),
  ];

  // === ThemeData ===
  static ThemeData get lightTheme {
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

      // 字体（使用系统默认中文友好字体栈）
      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: textPrimary, height: 1.3),
        headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: textPrimary, height: 1.3),
        titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: textPrimary, height: 1.4),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: textPrimary, height: 1.4),
        bodyLarge: TextStyle(fontSize: 16, color: textPrimary, height: 1.5),
        bodyMedium: TextStyle(fontSize: 14, color: textSecondary, height: 1.5),
        bodySmall: TextStyle(fontSize: 12, color: textHint, height: 1.4),
        labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
      ),

      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: textPrimary),
      ),

      // 主按钮
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusLg)),
          elevation: 0,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      // 输入框
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: spacingXl, vertical: spacingLg),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          borderSide: const BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          borderSide: const BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          borderSide: const BorderSide(color: primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          borderSide: const BorderSide(color: error),
        ),
        hintStyle: const TextStyle(color: textHint, fontSize: 15),
      ),

      // 卡片
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusXl)),
        margin: EdgeInsets.zero,
      ),

      // 分割线
      dividerTheme: const DividerThemeData(
        color: border,
        thickness: 0.5,
        space: 0,
      ),
    );
  }
}
