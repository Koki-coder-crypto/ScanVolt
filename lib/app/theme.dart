import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// ScanVolt アプリのテーマ定義。
///
/// Figma デザインシステムと同期するためのカラー・タイポグラフィ基盤。
class AppTheme {
  AppTheme._();

  // ---------------------------------------------------------------------------
  // カラー定数（Figma で同じ値を使用）
  // ---------------------------------------------------------------------------

  /// プライマリカラー（シアン系）
  static const primaryCyan = Color(0xFF00BCD4);

  /// ダークモード背景色
  static const darkBackground = Color(0xFF121212);

  /// ダークモードサーフェス色
  static const darkSurface = Color(0xFF1E1E1E);

  /// ダークモードカード色
  static const darkCard = Color(0xFF2C2C2C);

  /// スキャンオーバーレイ（半透明黒）
  static const scanOverlay = Color(0x80000000);

  /// スキャンコーナー色
  static const scanCorner = Color(0xFF00BCD4);

  /// 成功インジケーター
  static const successGreen = Color(0xFF4CAF50);

  /// 警告インジケーター
  static const warningRed = Color(0xFFF44336);

  /// プライマリテキスト色
  static const textPrimary = Color(0xFFFFFFFF);

  /// セカンダリテキスト色
  static const textSecondary = Color(0xFFB0B0B0);

  /// ターシャリテキスト色
  static const textTertiary = Color(0xFF707070);

  // ---------------------------------------------------------------------------
  // テーマ
  // ---------------------------------------------------------------------------

  /// ダークテーマ
  static ThemeData darkTheme() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primaryCyan,
      brightness: Brightness.dark,
      surface: darkBackground,
    );

    final textTheme = GoogleFonts.interTextTheme(
      ThemeData.dark().textTheme,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      textTheme: textTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: primaryCyan.withValues(alpha: 0.2),
        backgroundColor: darkSurface,
      ),
    );
  }

  /// ライトテーマ
  static ThemeData lightTheme() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primaryCyan,
    );

    final textTheme = GoogleFonts.interTextTheme(
      ThemeData.light().textTheme,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: primaryCyan.withValues(alpha: 0.2),
      ),
    );
  }
}
