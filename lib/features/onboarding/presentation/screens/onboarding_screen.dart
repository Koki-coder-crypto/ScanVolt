import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scanvolt/app/theme.dart';
import 'package:scanvolt/features/onboarding/presentation/widgets/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// オンボーディングページの定義。
const _pages = [
  OnboardingPageData(
    icon: Icons.qr_code_scanner_rounded,
    title: 'Instant Scan',
    subtitle: 'Point your camera at any QR code or barcode.\n'
        'Results appear in a flash.',
  ),
  OnboardingPageData(
    icon: Icons.add_box_rounded,
    title: 'Generate & Share',
    subtitle: 'Create QR codes for URLs, Wi-Fi, contacts,\n'
        'and share them instantly.',
  ),
  OnboardingPageData(
    icon: Icons.history_rounded,
    title: 'History at a Glance',
    subtitle: 'Every scan is saved automatically.\n'
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
                padding: const EdgeInsets.only(top: 8, right: 16),
                child: TextButton(
                  onPressed: _completeOnboarding,
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: AppTheme.textTertiary,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

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
              padding: const EdgeInsets.only(bottom: 24),
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
                      borderRadius: BorderRadius.circular(4),
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
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
              child: SizedBox(
                width: double.infinity,
                height: 56,
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
                    foregroundColor: AppTheme.textPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
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
