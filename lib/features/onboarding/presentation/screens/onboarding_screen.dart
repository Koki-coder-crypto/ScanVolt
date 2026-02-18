import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scanvolt/app/theme.dart';
import 'package:scanvolt/features/onboarding/presentation/widgets/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// オンボーディングページの定義。
const _pages = [
  OnboardingPageData(
    pageIndex: 0,
    title: 'Instant Scan',
    subtitle: 'Point your camera at any QR code or barcode. '
        'Results appear in a flash.',
  ),
  OnboardingPageData(
    pageIndex: 1,
    title: 'Generate & Share',
    subtitle: 'Create QR codes for URLs, Wi-Fi, contacts, '
        'and share them instantly.',
  ),
  OnboardingPageData(
    pageIndex: 2,
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
            // 上部：Skip ボタン（Figma: 16px, #707070, top 64）
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
            // Figma: active 32×8 rounded 4px #00BCD4,
            //   inactive 8×8 circle #3C3C3C, gap 8
            Padding(
              padding: const EdgeInsets.only(bottom: 48),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 32 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: _currentPage == index
                          ? AppTheme.primaryCyan
                          : const Color(0xFF3C3C3C),
                    ),
                  ),
                ),
              ),
            ),

            // Next / Get Started ボタン
            // Figma: borderRadius 16, gradient #00E5FF→#00BCD4,
            //   fontSize 17, bold, color #0A0A0A, py 16, bottom 48
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 48),
              child: SizedBox(
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF00E5FF), AppTheme.primaryCyan],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryCyan.withValues(alpha: 0.35),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                      BoxShadow(
                        color: AppTheme.primaryCyan.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
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
                      backgroundColor: Colors.transparent,
                      foregroundColor: AppTheme.darkBackground,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.34, // 0.02em × 17
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
            ),
          ],
        ),
      ),
    );
  }
}
