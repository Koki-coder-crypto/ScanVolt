import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:scanvolt/app/theme.dart';
import 'package:scanvolt/core/constants/app_icons.dart';

/// 履歴が空の場合に表示するウィジェット。
class HistoryEmptyState extends StatelessWidget {
  /// [HistoryEmptyState] を生成する。
  const HistoryEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 時計アイコン
            SvgPicture.asset(
              AppIcons.accessTime,
              colorFilter: ColorFilter.mode(
                AppTheme.textTertiary.withValues(alpha: 0.5),
                BlendMode.srcIn,
              ),
              width: 64,
              height: 64,
            ),
            const SizedBox(height: 20),

            Text(
              'No scans yet',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 8),

            Text(
              'Scan a QR code or barcode to see it here',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textTertiary,
                  ),
            ),
            const SizedBox(height: 28),

            // Start Scanning ボタン
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () => context.go('/scan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryCyan,
                  foregroundColor: AppTheme.darkBackground,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: const Text(
                  'Start Scanning',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
