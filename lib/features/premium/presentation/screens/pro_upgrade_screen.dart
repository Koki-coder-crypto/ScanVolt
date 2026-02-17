import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scanvolt/app/theme.dart';

/// ScanVolt Pro アップグレードペイウォール画面。
class ProUpgradeScreen extends ConsumerStatefulWidget {
  /// [ProUpgradeScreen] を生成する。
  const ProUpgradeScreen({super.key});

  @override
  ConsumerState<ProUpgradeScreen> createState() => _ProUpgradeScreenState();
}

class _ProUpgradeScreenState extends ConsumerState<ProUpgradeScreen> {
  int _selectedPlan = 1; // 0=Monthly, 1=Annual, 2=Lifetime

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 12),

              // 閉じるボタン（右上）
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.close,
                    color: AppTheme.textSecondary,
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // ⚡ アイコン
              const Text('⚡', style: TextStyle(fontSize: 48)),
              const SizedBox(height: 12),

              // タイトル
              Text(
                'ScanVolt Pro',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                'Unlock the full experience',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textTertiary,
                    ),
              ),
              const SizedBox(height: 32),

              // 機能リスト
              ..._features.map(
                (f) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle_outline,
                        color: AppTheme.primaryCyan,
                        size: 24,
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          f,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppTheme.textPrimary,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // プランカード
              Row(
                children: [
                  _PlanCard(
                    label: 'Monthly',
                    price: r'$2.99',
                    period: '/month',
                    isSelected: _selectedPlan == 0,
                    onTap: () => setState(() => _selectedPlan = 0),
                  ),
                  const SizedBox(width: 10),
                  _PlanCard(
                    label: 'Annual',
                    price: r'$19.99',
                    period: '/year',
                    isSelected: _selectedPlan == 1,
                    badge: 'SAVE 44%',
                    onTap: () => setState(() => _selectedPlan = 1),
                  ),
                  const SizedBox(width: 10),
                  _PlanCard(
                    label: 'Lifetime',
                    price: r'$39.99',
                    period: 'one-time',
                    isSelected: _selectedPlan == 2,
                    onTap: () => setState(() => _selectedPlan = 2),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // CTA ボタン
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO(scanvolt): integrate RevenueCat purchase flow
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryCyan,
                    foregroundColor: AppTheme.darkBackground,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  child: const Text('Start Free Trial'),
                ),
              ),
              const SizedBox(height: 16),

              // 法的テキスト
              Text(
                r'3-day free trial, then $19.99/year. Cancel anytime.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textTertiary,
                    ),
              ),
              const SizedBox(height: 10),

              // リンク
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _LinkButton(
                    label: 'Restore Purchases',
                    onTap: () {
                      // TODO(scanvolt): integrate RevenueCat restore purchases
                    },
                  ),
                  Text(
                    ' | ',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textTertiary,
                        ),
                  ),
                  _LinkButton(
                    label: 'Terms',
                    onTap: () {
                      // TODO(scanvolt): open terms of service URL
                    },
                  ),
                  Text(
                    ' | ',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textTertiary,
                        ),
                  ),
                  _LinkButton(
                    label: 'Privacy',
                    onTap: () {
                      // TODO(scanvolt): open privacy policy URL
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  static const _features = [
    'Unlimited scan history & cloud sync',
    'Custom QR codes with colors & logos',
    'Batch scan & export (CSV, JSON, PDF)',
    'Widgets, Siri Shortcuts & more',
  ];
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.label,
    required this.price,
    required this.period,
    required this.isSelected,
    required this.onTap,
    this.badge,
  });

  final String label;
  final String price;
  final String period;
  final bool isSelected;
  final String? badge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              decoration: BoxDecoration(
                color: AppTheme.darkSurface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color:
                      isSelected ? AppTheme.primaryCyan : AppTheme.textTertiary,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    price,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    period,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textTertiary,
                        ),
                  ),
                ],
              ),
            ),
            if (badge != null)
              Positioned(
                top: -10,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryCyan,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      badge!,
                      style: const TextStyle(
                        color: AppTheme.darkBackground,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
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

class _LinkButton extends StatelessWidget {
  const _LinkButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.textTertiary,
              decoration: TextDecoration.underline,
              decorationColor: AppTheme.textTertiary,
            ),
      ),
    );
  }
}
