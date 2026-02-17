import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scanvolt/app/theme.dart';
import 'package:scanvolt/features/history/data/repositories/providers.dart';
import 'package:scanvolt/features/scan/domain/models/scan_result.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// スキャン結果をモーダルボトムシートで表示する。
Future<void> showScanResultSheet({
  required BuildContext context,
  required ScanResult result,
}) {
  return showModalBottomSheet<void>(
    context: context,
    builder: (context) => ScanResultSheet(result: result),
  );
}

/// スキャン結果のボトムシート。
class ScanResultSheet extends ConsumerWidget {
  /// [ScanResultSheet] を生成する。
  const ScanResultSheet({required this.result, super.key});

  /// 表示するスキャン結果。
  final ScanResult result;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DraggableScrollableSheet(
      initialChildSize: 0.40,
      maxChildSize: 0.60,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppTheme.darkSurface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ドラッグハンドル
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: AppTheme.textTertiary,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  // タイプバッジと時間
                  Row(
                    children: [
                      _TypeBadge(dataType: result.dataType),
                      const Spacer(),
                      Text(
                        'Just now',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.textTertiary,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // スキャン値
                  Text(
                    result.displayValue ?? result.rawValue,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.textPrimary,
                        ),
                  ),

                  // URL 安全性インジケーター
                  if (result.dataType == ScanDataType.url) ...[
                    const SizedBox(height: 6),
                    _SafetyIndicator(rawValue: result.rawValue),
                  ],
                  const SizedBox(height: 20),

                  // アクションボタン行
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        // Open ボタン（URL の場合）
                        if (result.dataType == ScanDataType.url)
                          _FilledActionButton(
                            icon: Icons.open_in_new,
                            label: 'Open',
                            onPressed: () async =>
                                _openUrl(result.rawValue),
                          ),
                        if (result.dataType == ScanDataType.url)
                          const SizedBox(width: 10),

                        // Copy ボタン
                        _OutlineActionButton(
                          icon: Icons.copy_outlined,
                          label: 'Copy',
                          onPressed: () async {
                            await Clipboard.setData(
                              ClipboardData(text: result.rawValue),
                            );
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Copied!')),
                              );
                            }
                          },
                        ),
                        const SizedBox(width: 10),

                        // Share ボタン
                        _OutlineActionButton(
                          icon: Icons.ios_share,
                          label: 'Share',
                          onPressed: () async {
                            await SharePlus.instance.share(
                              ShareParams(text: result.rawValue),
                            );
                          },
                        ),
                        const SizedBox(width: 10),

                        // Search ボタン
                        _OutlineActionButton(
                          icon: Icons.search,
                          label: 'Search',
                          onPressed: () async =>
                              _searchWeb(result.rawValue),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Save to History ボタン
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final repo = ref.read(historyRepositoryProvider);
                        await repo.saveScan(result);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Saved to history')),
                          );
                          Navigator.of(context).pop();
                        }
                      },
                      icon: const Icon(Icons.bookmark_border),
                      label: const Text('Save to History'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.darkCard,
                        foregroundColor: AppTheme.textPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _searchWeb(String query) async {
    final uri = Uri.https('www.google.com', '/search', {'q': query});
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _TypeBadge extends StatelessWidget {
  const _TypeBadge({required this.dataType});

  final ScanDataType dataType;

  @override
  Widget build(BuildContext context) {
    final (icon, label, color) = switch (dataType) {
      ScanDataType.url => (Icons.language, 'URL', AppTheme.primaryCyan),
      ScanDataType.wifi => (Icons.wifi, 'Wi-Fi', AppTheme.successGreen),
      ScanDataType.contact => (Icons.person_outline, 'Contact', Colors.orange),
      ScanDataType.text => (Icons.description_outlined, 'Text', Colors.white70),
      ScanDataType.email => (Icons.email_outlined, 'Email', Colors.amber),
      ScanDataType.phone => (Icons.phone, 'Phone', Colors.lightBlue),
      _ => (Icons.qr_code, dataType.name.toUpperCase(), Colors.grey),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}

class _SafetyIndicator extends StatelessWidget {
  const _SafetyIndicator({required this.rawValue});

  final String rawValue;

  @override
  Widget build(BuildContext context) {
    // 基本的な安全性チェック：https なら Safe、それ以外は Warning
    final isSecure = rawValue.startsWith('https://');
    final color = isSecure ? AppTheme.successGreen : AppTheme.warningRed;
    final label = isSecure ? 'Safe' : 'Warning';
    final icon = isSecure ? Icons.shield_outlined : Icons.warning_amber;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }
}

class _FilledActionButton extends StatelessWidget {
  const _FilledActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryCyan,
        foregroundColor: AppTheme.darkBackground,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

class _OutlineActionButton extends StatelessWidget {
  const _OutlineActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppTheme.textPrimary,
        side: const BorderSide(color: AppTheme.textTertiary),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
