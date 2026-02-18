import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scanvolt/app/theme.dart';

/// オンボーディングページのデータモデル。
class OnboardingPageData {
  /// [OnboardingPageData] を生成する。
  const OnboardingPageData({
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });

  /// ページに表示する SVG イラストのアセットパス。
  final String imagePath;

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // イラスト（280×280 の SVG）
          SvgPicture.asset(
            data.imagePath,
            width: 280,
            height: 280,
          ),
          const SizedBox(height: 32),

          // タイトル
          Text(
            data.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // サブタイトル
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              data.subtitle,
              style: const TextStyle(
                fontSize: 16,
                color: AppTheme.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
