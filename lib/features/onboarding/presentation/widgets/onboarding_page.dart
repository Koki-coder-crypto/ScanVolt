import 'package:flutter/material.dart';
import 'package:scanvolt/app/theme.dart';
import 'package:scanvolt/features/onboarding/presentation/widgets/onboarding_generate_illustration.dart';
import 'package:scanvolt/features/onboarding/presentation/widgets/onboarding_history_illustration.dart';
import 'package:scanvolt/features/onboarding/presentation/widgets/onboarding_scan_illustration.dart';

/// オンボーディングページのデータモデル。
class OnboardingPageData {
  /// [OnboardingPageData] を生成する。
  const OnboardingPageData({
    required this.pageIndex,
    required this.title,
    required this.subtitle,
  });

  /// イラストの種別を決めるページインデックス（0〜2）。
  final int pageIndex;

  /// ページのタイトル。
  final String title;

  /// ページのサブタイトル（説明文）。
  final String subtitle;
}

/// オンボーディングの各ページを表示するウィジェット。
///
/// [OnboardingPageData.pageIndex] に応じてアニメーションイラストを切り替える。
class OnboardingPage extends StatelessWidget {
  /// [OnboardingPage] を生成する。
  const OnboardingPage({required this.data, super.key});

  /// ページに表示するデータ。
  final OnboardingPageData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // アニメーションイラスト（280×280）
          _buildIllustration(),
          const SizedBox(height: 32),

          // タイトル（Figma: 28px, bold, white, letterSpacing: -0.02em）
          Text(
            data.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
              letterSpacing: -0.56, // -0.02em × 28
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // サブタイトル（Figma: 16px, #B0B0B0, height 1.6,
          //   letterSpacing: 0.01em）
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              data.subtitle,
              style: const TextStyle(
                fontSize: 16,
                color: AppTheme.textSecondary,
                height: 1.6,
                letterSpacing: 0.16, // 0.01em × 16
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  /// `pageIndex` に応じたイラストウィジェットを返す。
  Widget _buildIllustration() {
    return switch (data.pageIndex) {
      0 => const OnboardingScanIllustration(),
      1 => const OnboardingGenerateIllustration(),
      2 => const OnboardingHistoryIllustration(),
      _ => const SizedBox(width: 280, height: 280),
    };
  }
}
