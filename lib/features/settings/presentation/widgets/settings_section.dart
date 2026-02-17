import 'package:flutter/material.dart';
import 'package:scanvolt/app/theme.dart';

/// 設定画面のセクション（iOS スタイルのグループ化されたリスト）。
class SettingsSection extends StatelessWidget {
  /// [SettingsSection] を生成する。
  const SettingsSection({
    required this.title,
    required this.children,
    super.key,
  });

  /// セクションヘッダーのタイトル。
  final String title;

  /// セクション内のタイルリスト。
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
          child: Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppTheme.textTertiary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppTheme.darkSurface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              for (int i = 0; i < children.length; i++) ...[
                children[i],
                if (i < children.length - 1)
                  const Divider(
                    height: 1,
                    indent: 52,
                    color: AppTheme.darkCard,
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
