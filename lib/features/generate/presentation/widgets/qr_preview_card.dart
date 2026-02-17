import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scanvolt/app/theme.dart';

/// QR コードのプレビューカード。
class QrPreviewCard extends StatelessWidget {
  /// [QrPreviewCard] を生成する。
  const QrPreviewCard({required this.data, super.key});

  /// QR コードに変換するデータ。空なら空カードを表示。
  final String? data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: data != null && data!.isNotEmpty
              ? QrImageView(
                  data: data!,
                  size: 200,
                  backgroundColor: Colors.white,
                )
              : const SizedBox(
                  width: 200,
                  height: 200,
                  child: Center(
                    child: Text(
                      'QR Preview',
                      style: TextStyle(color: AppTheme.textTertiary),
                    ),
                  ),
                ),
        ),
        const SizedBox(height: 8),
        Text(
          'Scan to preview',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.textTertiary,
              ),
        ),
      ],
    );
  }
}
