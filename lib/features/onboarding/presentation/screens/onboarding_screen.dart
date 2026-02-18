import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scanvolt/app/theme.dart';
import 'package:scanvolt/features/onboarding/presentation/widgets/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// オンボーディングページの定義。
const _pages = [
  OnboardingPageData(
    imagePath: 'assets/onboarding/scan.svg',
    title: 'Instant Scan',
    subtitle: 'Point your camera at any QR code or barcode. '
        'Results appear in a flash.',
  ),
  OnboardingPageData(
    imagePath: 'assets/onboarding/generate.svg',
    title: 'Generate & Share',
    subtitle: 'Create QR codes for URLs, Wi-Fi, contacts, '
        'and share them instantly.',
  ),
  OnboardingPageData(
    imagePath: 'assets/onboarding/history.svg',
    title: 'History at a Glance',
    subtitle: 'Every scan is saved automatically. '
        'Search, filter, and manage with ease.',
  ),
];

/// 初回起動時に表示するオンボーディング画面。
///
/// 3ページのスワイプ式 [PageView] で構成され、
/// 完了または Skip 時に SharedPreferences へフラグを保存して
/// スキャン画面へ遷移する。
class OnboardingScreen extends ConsumerStatefulWidget {
  /// [OnboardingScreen] を生成する。
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// オンボーディング完了フラグを保存してスキャン画面へ遷移する。
  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', true);
    if (mounted) {
      context.go('/scan');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      body: SafeArea(
        child: Column(
          children: [
            // 上部：Skip ボタン
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 64, right: 24),
                child: TextButton(
                  onPressed: _completeOnboarding,
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: AppTheme.textTertiary,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // ページコンテンツ
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  return OnboardingPage(data: _pages[index]);
                },
              ),
            ),

            // ドットインジケーター
            Padding(
              padding: const EdgeInsets.only(bottom: 48),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 28 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: _currentPage == index
                          ? BorderRadius.circular(4)
                          : BorderRadius.circular(4),
                      color: _currentPage == index
                          ? AppTheme.primaryCyan
                          : AppTheme.textTertiary,
                    ),
                  ),
                ),
              ),
            ),

            // Next / Get Started ボタン
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 48),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_currentPage == _pages.length - 1) {
                      await _completeOnboarding();
                    } else {
                      await _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryCyan,
                    foregroundColor: AppTheme.darkBackground,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: Text(
                    _currentPage == _pages.length - 1
                        ? 'Get Started'
                        : 'Next',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
