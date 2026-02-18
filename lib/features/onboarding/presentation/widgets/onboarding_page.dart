import 'package:flutter/material.dart';
import 'package:scanvolt/app/theme.dart';

/// オンボーディングページのデータモデル。
class OnboardingPageData {
  /// [OnboardingPageData] を生成する。
  const OnboardingPageData({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  /// ページに表示するアイコン。
  final IconData icon;

  /// ページのタイトル。
  final String title;

  /// ページのサブタイトル（説明文）。
  final String subtitle;
}

/// オンボーディングの各ページを表示するウィジェット。
class OnboardingPage extends StatelessWidget {
  /// [OnboardingPage] を生成する。
  const OnboardingPage({required this.data, super.key});

  /// ページに表示するデータ。
  final OnboardingPageData data;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // アイコン（円形背景付き）
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.primaryCyan.withValues(alpha: 0.1),
              border: Border.all(
                color: AppTheme.primaryCyan.withValues(alpha: 0.3),
              ),
            ),
            child: Icon(
              data.icon,
              size: 64,
              color: AppTheme.primaryCyan,
            ),
          ),
          const SizedBox(height: 48),

          // タイトル
          Text(
            data.title,
            style: textTheme.headlineMedium?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // サブタイトル
          Text(
            data.subtitle,
            style: textTheme.bodyLarge?.copyWith(
              color: AppTheme.textSecondary,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
